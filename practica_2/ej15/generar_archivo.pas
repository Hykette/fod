program generar_archivo;

uses types, sysutils;

procedure generar_maestro(var maestro:arch_maestro);
var
    carencia:carencias;
    i, j, k:integer;
begin 
    rewrite(maestro);
    for i:=1 to dimF do begin
        carencia.codigo_provincia := i;
        carencia.nombre_provincia := generar_string();
        for j:=1 to dimF do begin
            carencia.codigo_localidad := j;
            carencia.nombre_localidad := generar_string();
            for k:=1 to 5 do begin 
                carencia.viviendas[k] := random(1000) + 10;
            end;
            write(maestro, carencia);
        end;
    end;
    close(maestro);
end;

procedure generar_detalles(var detalles:vector_detalles);
var 
    obra:obras;
    i, j, k, l, m, veces:integer;
begin 
    for i:=1 to dimF do begin 
        rewrite(detalles[i]);
        for j:=1 to dimF do begin 
            obra.codigo_provincia := j;
            obra.nombre_provincia := generar_string();
            // las localidades no se repiten
            for k:=1 to dimF do begin 
                obra.codigo_localidad := k;
                obra.nombre_localidad := generar_string();
                for l:=1 to 5 do begin 
                    obra.obras[l] := random(5);
                end;
                write(detalles[i], obra);
                veces := random(5) + 1;
            end;
        end;
        close(detalles[i]);
    end;
end;

procedure imprimir_detalles(var detalles:vector_detalles);
var 
    obra:obras;
    i:integer;
begin 
    for i:=1 to dimF do begin 
        reset(detalles[i]);
        while (not eof(detalles[i])) do begin 
            read(detalles[i], obra);
            write(obra.codigo_localidad);
        end;
        close(detalles[i]);
    end;
end;

var 
    detalles:vector_detalles;
    maestro:arch_maestro;
    path, nombre_fisico:string;
    i:integer;
begin 
    path := './detalles/detalle';
    for i:=1 to dimF do begin 
        nombre_fisico:= path + IntToStr(i) + '.dat';
        assign(detalles[i], nombre_fisico);
    end;
    assign(maestro, 'maestro.dat');
    generar_maestro(maestro);
    generar_detalles(detalles);
    imprimir_detalles(detalles);
end.
