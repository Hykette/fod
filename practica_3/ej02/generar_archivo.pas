program generar_archivo;

uses types;

procedure generar_maestro(var maestro:arch_maestro);
var 
    asistente:asistentes;
    i:longint;
begin 
    rewrite(maestro);
    with asistente do begin
        for i:=1 to cant_empleados + 1 do begin 
            id := i + 499;
            apellido := generar_string();
            nombre := generar_string();
            email := generar_string();
            telefono := random(9000);
            dni := random(1000000);
            write(maestro, asistente);
        end;
    end;
    close(maestro);
end;

procedure imprimir_maestro(var maestro:arch_maestro);
var 
    asistente:asistentes;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(maestro, asistente);
        write(asistente.id, '|');
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
