program generar_archivo;

uses types;

procedure generar_aves(var maestro:arch_maestro);
var 
    ave:aves;
    i:integer;
begin 
    rewrite(maestro);
    ave.codigo := 0;
    ave.nombre := '';
    ave.familia := '';
    ave.descripcion := '';
    ave.zona := '';
    write(maestro, ave);
    
    for i:=1 to 5 do begin 
        ave.codigo := i;
        ave.nombre := generar_string();
        ave.familia := generar_string();
        ave.descripcion := generar_string();
        ave.zona := generar_string();
        write(maestro, ave);
    end;

    close(maestro);
end;

var 
    maestro:arch_maestro;
begin 
    assign(maestro, 'maestro.dat');
    generar_aves(maestro);
    imprimir_aves(maestro);
end.
