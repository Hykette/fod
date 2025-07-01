program generar_archivo;

uses types;

procedure generar_maestro(var maestro:arch_maestro);
var 
    f:flor; i:integer;
begin 
    rewrite(maestro);
    f.codigo := 0;
    f.nombre := '';
    write(maestro, f);
    for i:=1 to 50 do begin 
        f.codigo := i;
        f.nombre := generar_string();
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
        write(f.codigo, '|');
    end;
    close(maestro);
end;
        
var 
    maestro:arch_maestro;
begin 
    assign(maestro, 'maestro.dat');
    generar_maestro(maestro);
    imprimir_maestro(maestro);
end.
