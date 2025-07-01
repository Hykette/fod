unit types;

interface 
const 
    valor_alto = 9999;
    total_novelas = 30; //para hacer
type
    
    novela = record
        //indice:integer;
        id:integer;
        genero:string;
        nombre:string;
        duracion:integer;
        director:string;
        precio:real;
    end;

    arch_maestro = file of novela;

    procedure leer_maestro(var maestro:arch_maestro; var nov:novela);
    function generar_string():string;
    function es_numerico(c:char):boolean;
    function indice_de(str:string):integer;
    procedure imprimir_maestro(var maestro:arch_maestro);
    procedure menu(var eleccion:integer);
    function borrado(c:char):boolean;
    procedure nueva_novela(var maestro:arch_maestro; var nov:novela);
    procedure nuevo_indice(var str:string; indice:integer);
    //genero para el indice

implementation
    uses sysutils;

    procedure leer_maestro(var maestro:arch_maestro; var nov:novela);
    begin 
        if (eof(maestro)) then nov.id := valor_alto
        else read(maestro, nov);
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

    function es_numerico(c:char):boolean;
    begin 
        es_numerico := ((c < ':') and (c > '/'));
    end;

    function borrado(c:char):boolean;
    begin 
        borrado := ((c = '@') or (es_numerico(c)));
    end;

    function indice_de(str:string):integer;
    var 
        i:integer;
        aux:string;
    begin 
        i := 1;
        aux := '';
        if (es_numerico(str[i])) then begin //si es numero

            while (str[i] <> '@') do begin //concatena los char
                aux := aux + str[i];
                inc(i);
            end;
            
            if (aux = '') then indice_de := -1 
            else indice_de := StrToInt(aux);

        end else
            indice_de := -1;
    end;

    procedure nuevo_indice(var str:string; indice:integer);
    var 
        i:integer;
        aux:string;
    begin 
        i:=1;
        aux := intToStr(indice);
        while (str[i] <> '@') do inc(i);
        
        while (i < length(str)) do begin 
            aux := aux + str[i];
            inc(i);
        end;
        str := aux;
    end;



    procedure imprimir_maestro(var maestro:arch_maestro);
    var 
        nov:novela;
    begin 
        reset(maestro);
        while (not eof(maestro)) do begin 
            read(maestro, nov);
            if (not es_numerico(nov.genero[1])) then write( nov.id, '|');
        end;
        close(maestro);
    end;

    
    procedure nueva_novela(var maestro:arch_maestro; var nov:novela);
    var 
        nueva_id:integer;
    begin 
        nueva_id := valor_alto;
        while (not eof(maestro)) do begin 
            read(maestro, nov);
            if (nov.id < nueva_id) then nueva_id := nov.id;
        end;
        
        nueva_id := 1 + nov.id;
        with nov do begin 
            id := nueva_id;
            genero := generar_string();
            nombre := generar_string();
            duracion := random(100);
            director := generar_string();
            precio := random(1000) + (1 / (random(10) + 1));
        end;
        seek(maestro, 0);
    end;



    procedure menu(var eleccion:integer);
    begin 
        writeln('Elegir accion: ');
        writeln('1: Agregar novela');
        writeln('2: Modificar novela');
        writeln('3: Eliminar novela');
        writeln('4: Pasar a txt'); 
        writeln('5: imprimir novelas');
        writeln('0: cerrar');
        readln(eleccion);
    end;


end.
