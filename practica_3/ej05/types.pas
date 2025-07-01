unit types;

interface 

const
    valor_alto = 9999;

type 
    flor = record
        nombre: string[45];
        codigo:integer;
    end;
      
    arch_maestro = file of flor;

    {Abre  el  archivo  y  agrega  una  flor,  recibida  como  parámetro 
    manteniendo la política descrita anteriormente}

    procedure leer_maestro(var maestro:arch_maestro; var f:flor);
    function generar_string():string;
    function borrado(n:integer):boolean;
    procedure agregar_flor(var maestro:arch_maestro);
    procedure borrar_registro(var maestro:arch_maestro);
    procedure imprimir_maestro_sin_borrados(var maestro:arch_maestro);
    procedure imprimir_maestro(var maestro:arch_maestro);
    
implementation

    procedure leer_maestro(var maestro:arch_maestro; var f:flor);
    begin 
        if(eof(maestro)) then f.codigo := valor_alto
        else read(maestro, f);
    end;

    function borrado(n:integer):boolean;
    begin 
        borrado := (n <= 0);
    end;

    function generar_string():string;
    const
        caracteres = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    var
        i, longitud: integer; aux: string;

    begin
        aux := '';
        longitud := 5;
        for i := 1 to longitud do begin
            aux := aux + caracteres[Random(52) + 1]; 
        end;
        generar_string := aux;
    end;

    procedure borrar_registro(var maestro:arch_maestro);
    var
        f:flor;
        aux:flor;
        id:integer;
        indice:integer;
    begin 
        // hacer como en el agregar
        writeln('id flor a borrar');
        readln(id);

        reset(maestro);
        leer_maestro(maestro, f);
        while ((f.codigo <> valor_alto) and (f.codigo <> id)) do leer_maestro(maestro, f);
        if (f.codigo = id) then begin  
            // guarda el indice y va al maestro
            indice := filepos(maestro) -1;
            seek(maestro, 0);
            read(maestro, aux);
            
            // intercambia los codigos(indices) entre el maestro y el nuevo registro a borrar
            f.codigo := aux.codigo;
            aux.codigo := indice * -1;

            // escribe en la cabecera el nuevo indice
            seek(maestro, 0);
            write(maestro, aux);

            //vuelve al indice a borrar logicamente
            seek(maestro, indice);
            write(maestro, f);
            
        end else writeln('no encontrada');
        close(maestro);
    end;

    //corregir
    procedure agregar_flor(var maestro:arch_maestro);
    var 
        nueva_flor, f:flor;
        recorrer:integer;
    begin 
        nueva_flor.codigo := random(100) + 1;
        nueva_flor.nombre := generar_string();
        reset(maestro);
        read(maestro, f);
        if (f.codigo >= 0) then begin 
            seek(maestro, filesize(maestro));
            write(maestro, nueva_flor); 
        end else begin 
            recorrer := f.codigo * -1;
            seek(maestro, recorrer);
            read(maestro, f);
            seek(maestro, filepos(maestro) - 1);

            write(maestro, nueva_flor);
            f.nombre := '';
            if (f.codigo > 0) then f.codigo := 0;

            seek(maestro, 0);
            write(maestro, f);
        end;
        close(maestro);
    end;

    procedure imprimir_maestro(var maestro:arch_maestro);
    var 
        f:flor;
    begin 
        reset(maestro);
        while (not eof(maestro)) do begin 
            read(maestro, f);
            write(f.codigo, '|', f.nombre, '|   ');
        end;
        close(maestro);
        writeln();
    end;

    procedure imprimir_maestro_sin_borrados(var maestro:arch_maestro);
    var 
        f:flor;
    begin 
        reset(maestro);
        while (not eof(maestro)) do begin 
            read(Maestro, f);
            if (not borrado(f.codigo)) then write(f.codigo, '|');
        end;
        writeln();
        close(maestro);
    end;


end.