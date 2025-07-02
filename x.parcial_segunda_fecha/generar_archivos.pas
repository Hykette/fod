program generar_archivos;

uses types, sysutils;

const 
    resultados: array[1..3] of integer = (3, 1, 0);

procedure generar_maestro(var maestro:arch_maestro);
var
    i:integer;
    registro:equipo;
begin 
    rewrite(maestro);
    for i:=1 to equipos_totales do begin 
        with registro do begin 
            codigo := i;
            jugados := random(100) + 1;
            ganados := random(100) + 1;
            empatados := random(100) + 1;
            perdidos := random(100) + 1;
            puntos := random(100) + 1;
            nombre := generar_string();
        end;
        write(maestro, registro);
    end;
    close(maestro);
end;

procedure generar_partido(var registro:partido);
begin
    with registro do begin 
        fecha := random(10);
        puntos := resultados[(random(3) + 1)];
        cod_rival := random(30) + 1;
    end;
end;

procedure generar_detalles(var vec_detalles:vector_detalles);
var 
    registro:partido;
    i,j,k:integer;
    n_random:integer;
begin 
    for i:=1 to cant_detalles do begin 
        rewrite(vec_detalles[i]);
        for j:=1 to equipos_totales do begin 
            registro.codigo := j;
            n_random := random(4) + 1;
            for k:=1 to n_random do begin
                generar_partido(registro); 
                write(vec_detalles[i], registro);
            end;
        end;
        close(vec_detalles[i]);
    end;
end;

procedure imprimir_detalles(var vec_detalles:vector_detalles);
var 
    i:integer;
    registro:partido;
begin 
    for i:=1 to cant_detalles do begin 
        reset(vec_detalles[i]);
        while (not eof(vec_detalles[i])) do begin 
            read(vec_detalles[i], registro);
            write(registro.codigo, ' |');
        end;
        close(vec_detalles[i]);
        writeln();
    end;
end;

procedure imprimir_maestro(var maestro:arch_maestro);
var 
    registro:equipo;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(maestro, registro);
        write('Codigo: ', registro.codigo, ' |');
    end;
    close(maestro);
end;

var 
    path:string;
    i:integer;
    maestro:arch_maestro;
    vec_detalles:vector_detalles;
begin 
    assign(maestro, 'maestro.dat');
    path := 'detalles/detalle';
    for i:=1 to cant_detalles do begin 
        assign(vec_detalles[i], (path + inttostr(i) + '.dat'));
    end;
    generar_maestro(maestro);
    generar_detalles(vec_detalles);
    imprimir_maestro(maestro);
    writeln();
    writeln();
    imprimir_detalles(vec_detalles);
end.

