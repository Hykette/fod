program generar_archivo;

uses types;

procedure generar_maestro(var maestro:arch_maestro);
var
    nov:novela;
    i:integer;
begin 
    rewrite(maestro);
    with nov do begin 
        id := 0;
        genero := '@';
        nombre := '';
        duracion := 0;
        director := '';
        precio := 0;
        write(maestro, nov);
        for i:=1 to total_novelas do begin 
            id := i;
            genero := generar_string();
            nombre := generar_string();
            duracion := random(100);
            director := generar_string();
            precio := random(1000) + (1 / (random(10) + 1));
            write(maestro, nov);
        end;
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