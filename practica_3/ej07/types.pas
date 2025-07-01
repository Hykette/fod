unit types;

interface

const 
    valor_alto = 9999;

type 

    aves = record 
        codigo:integer;
        nombre:string;
        familia:string;
        descripcion:string;
        zona:string;
    end;

    arch_maestro = file of aves;

    procedure leer_maestro(var maestro:arch_maestro; var ave:aves);
    function generar_string():string;
    procedure imprimir_aves(var maestro:arch_maestro);
    function borrado(ave:aves):boolean;
    
implementation 

    function borrado(ave:aves):boolean;
    begin 
        borrado := (ave.codigo <= 0);
    end;

    procedure leer_maestro(var maestro:arch_maestro; var ave:aves);
    begin 
        if (eof(maestro)) then ave.codigo := valor_alto
        else read(maestro, ave);
    end;

    procedure imprimir_aves(var maestro:arch_maestro);
    var 
        ave:aves;
    begin 
        reset(maestro);
        while (not eof(maestro)) do begin 
            read(maestro, ave);
            write(ave.codigo, '|');
        end;
        close(maestro);
        writeln();
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

end.