program generar_archivo;

uses sysutils, types;

procedure generar_archivo(var maestro:arch_maestro);
var 
    i, j, k, l, veces:integer;
    caso:casos;
begin 
    rewrite(maestro);
    for i:=1 to 10 do begin 
        caso.codigo_localidad := i;
        caso.nombre_localidad := generar_string();
        for j:=1 to 10 do begin 
            caso.codigo_municipio := j;
            caso.nombre_municipio := generar_string();
            for k:=1 to 10 do begin 
                caso.codigo_hospital := k;
                caso.nombre_hospital := generar_string();
                veces := random(10) + 1;
                for l:=1 to veces do begin 
                    caso.fecha := random(30);
                    caso.casos_positivos := random(50);
                    write(maestro, caso);
                end;
            end;
        end;
    end;
    close(maestro);
end;

procedure imprimir_maestro(var maestro:arch_maestro);
var 
    caso:casos;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin
        read(maestro, caso);
        writeln(caso.codigo_localidad, '|', caso.codigo_municipio, '|', caso.codigo_hospital);
    end;
    close(maestro);
end;

var 
    maestro:arch_maestro;
begin 
    assign(maestro, 'maestro.dat');
    generar_archivo(maestro);
    imprimir_maestro(maestro);
end.