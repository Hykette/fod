program e8;

uses types, sysutils;

function registro_minimo(vec_consumos:vector_consumos):integer;
var 
    i:integer;
    indice:integer;
    minimo:integer;
begin 
    minimo := valor_alto;
    for i:=1 to dimF do begin 
        if (vec_consumos[i].codigo_provincia <= minimo) then begin 
            indice := i;
            minimo := vec_consumos[i].codigo_provincia;
        end;
    end;
    registro_minimo := indice;
end;

procedure minimo(var detalles:vec_detalles; var vec_consumos:vector_consumos; var min:consumos);
var 
    i:integer;
begin 
    i := registro_minimo(vec_consumos);
    min := vec_consumos[i];
    leerD(detalles[i], vec_consumos[i]);
end;

procedure actualizar_maestro(var maestro:arch_maestro; var detalles:vec_detalles);
var 
    i:integer;
    prov:provincia;
    vec_consumos:vector_consumos;
    min:consumos;
    promedio:real;
begin 
    reset(maestro);
    for i:=1 to dimF do begin 
        reset(detalles[i]);
        leerD(detalles[i], vec_consumos[i]);
    end;
    leerM(maestro, prov);
    minimo(detalles, vec_consumos, min);

    while (min.codigo_provincia <> valor_alto) do begin 

        while (prov.codigo_provincia <> min.codigo_provincia) do begin 
            if (prov.kilos_historicos > 100000) then begin 
                writeln('codigo: ', prov.codigo_provincia, 'nombre:', prov.nombre);
                promedio := prov.habitantes/prov.kilos_historicos;
                writeln('promedio kg yerba por habitante: ', promedio:0:2);
            end;
            leerM(maestro, prov);
        end;

        while (prov.codigo_provincia = min.codigo_provincia) do begin 
            prov.kilos_historicos := prov.kilos_historicos + min.kilos;
            minimo(detalles, vec_consumos, min);
        end;

        if (prov.kilos_historicos > 100000) then begin 
            writeln('codigo: ', prov.codigo_provincia, 'nombre:', prov.nombre);
            promedio := prov.habitantes/prov.kilos_historicos;
            writeln('promedio yerba por habitante', promedio:0:2);
        end;

        seek(maestro, filepos(maestro) - 1);
        write(maestro, prov);
    end;

    for i:=1 to dimF do begin 
        close(detalles[i]);
    end;
    close(maestro);
end;

procedure imprimir_maestro(var maestro:arch_maestro);
var 
    prov:provincia;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(maestro, prov);
        write(prov.codigo_provincia, '|', prov.kilos_historicos, '|');
    end;
    close(maestro);
end;

var 
    maestro:arch_maestro;
    detalles:vec_detalles;
    path, nombre_fisico:string;
    i:integer;
begin 
    path := './detalles/detalle';
    for i:=1 to dimF do begin 
        nombre_fisico := path + IntToStr(i) + '.dat';
        assign(detalles[i], nombre_fisico);
    end;
    assign(maestro, 'maestro.dat');
    actualizar_maestro(maestro, detalles);
    imprimir_maestro(maestro);
end.

