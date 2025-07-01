program e15;

uses types, Sysutils;

function registro_minimo(vec_obras:vector_obras):integer;
var 
    prov_minimo:integer;
    localidad_minimo:integer;
    indice:integer;
    i:integer;
begin 
    prov_minimo := valor_alto;
    localidad_minimo := valor_alto;
    indice := 1; //por si no se actualiza
    for i:=1 to dimF do begin 
        if ((vec_obras[i].codigo_provincia < prov_minimo) or 
            ((vec_obras[i].codigo_provincia = prov_minimo) and (vec_obras[i].codigo_localidad < localidad_minimo))) then begin 
            prov_minimo := vec_obras[i].codigo_provincia;
            localidad_minimo := vec_obras[i].codigo_localidad;    
            indice := i;   
        end;
    end;      
    registro_minimo := indice;
end;

procedure minimo(var vec_detalles:vector_detalles; var vec_obras:vector_obras; var min:obras);
var 
    i:integer;
begin 
    i := registro_minimo(vec_obras);
    min := vec_obras[i];
    leer_detalle(vec_detalles[i], vec_obras[i]);
end;

procedure actualizar_maestro(var maestro:arch_maestro; var vec_detalles:vector_detalles);
var 
    car:carencias;
    min:obras;
    vec_obras:vector_obras;
    i:integer;
    aux:carencias;
begin 
    for i:=1 to dimF do begin 
        reset(vec_detalles[i]);
        leer_detalle(vec_detalles[i], vec_obras[i]);
    end;
    reset(maestro);

    leer_maestro(maestro, car);
    minimo(vec_detalles, vec_obras, min);

    while ((min.codigo_provincia <> valor_alto) or (car.codigo_provincia <> valor_alto)) do begin 
        aux := car;
        while ((min.codigo_provincia <> car.codigo_provincia) and (car.codigo_provincia <> valor_alto)) do begin 
            if (car.viviendas[5] < 1) then writeln('sin chapa');
            leer_maestro(maestro, car);
        end;

        while ((min.codigo_provincia = car.codigo_provincia) and (min.codigo_provincia <> valor_alto) and (min.codigo_localidad = car.codigo_localidad)) do begin 
            for i:=1 to 5 do begin 
                car.viviendas[i] := car.viviendas[i] - min.obras[i];
            end;
            minimo(vec_detalles, vec_obras, min);
        end;

        if (car.viviendas[5] < 1) then writeln('sin chapa');

        if (car.codigo_provincia <> valor_alto) then begin
            seek(maestro, filepos(maestro) - 1);
            write(maestro, car);
        end;
        leer_maestro(maestro, car);
    end;
    for i:=1 to dimF do begin 
        close(vec_detalles[i]);
    end;
    close(maestro);
end;

procedure imprimir_maestro(var maestro:arch_maestro);
var 
    car:carencias;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(maestro, car);
        writeln(car.codigo_provincia, '|', car.codigo_localidad, '|', car.viviendas[5]);
    end;
    close(maestro);
end;

var 
    maestro:arch_maestro;
    detalles:vector_detalles;
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