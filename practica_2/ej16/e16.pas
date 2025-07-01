program e16;

uses types, sysutils;

function registro_minimo(vec_ventas:vector_ventas):integer;
var 
    i, fecha_minimo, seminario_minimo:integer;
    indice:integer;
begin 
    fecha_minimo := valor_alto;
    seminario_minimo := valor_alto;
    indice := 1;
    for i:=1 to dimF do begin 
        if ((vec_ventas[i].fecha < fecha_minimo) or 
        ((vec_ventas[i].fecha = fecha_minimo) and (vec_ventas[i].codigo_seminario < seminario_minimo))) then begin 
            fecha_minimo := vec_ventas[i].fecha;
            seminario_minimo := vec_ventas[i].codigo_seminario;
            indice := i;
        end;
    end;
    registro_minimo := indice;
end;

procedure minimo(var detalles:vector_detalle; var vec_ventas:vector_ventas; var min:ventas);
var 
    i:integer;
begin
    i := registro_minimo(vec_ventas);
    min := vec_ventas[i];
    leer_detalle(detalles[i], vec_ventas[i]);
end;

procedure actualizar_e_informar(var maestro:arch_maestro; var detalles:vector_detalle);
var 
    ventas_menor:longint; 
    ventas_mayor:longint;
    indice_mayor:integer;
    indice_menor:integer;
    emision:emisiones;
    i:integer;
    vec_ventas:vector_ventas;
    min:ventas;
begin 
    ventas_menor := valor_alto;
    ventas_mayor := valor_bajo;
    indice_mayor := -1;
    indice_menor := -1;

    for i:=1 to dimF do begin 
        reset(detalles[i]);
        leer_detalle(detalles[i], vec_ventas[i]);
    end;

    reset(maestro);
    leer_maestro(maestro, emision);
    minimo(detalles, vec_ventas, min);

    while ((min.fecha <> valor_alto) or (emision.fecha <> valor_alto)) do begin 
        
        while ((min.fecha <> emision.fecha) and (emision.total_ejemplares = 0) and (emision.fecha <> valor_alto)) do begin 
            if (emision.ejemplares_vendidos > ventas_mayor) then begin 
                indice_mayor := filepos(maestro) - 1;
                ventas_mayor := emision.ejemplares_vendidos;
            end;
            if (emision.ejemplares_vendidos < ventas_menor) then begin 
                indice_menor := filepos(maestro) - 1;
                ventas_menor := emision.ejemplares_vendidos;
            end;
            leer_maestro(maestro, emision);
            
        end;

        while ((min.fecha <> valor_alto) and (min.fecha = emision.fecha)) do begin 
            while ((min.fecha = emision.fecha) and (min.codigo_seminario = emision.codigo_seminario)) do begin 
                emision.ejemplares_vendidos := emision.ejemplares_vendidos + min.ejemplares_vendidos;
                emision.total_ejemplares := emision.total_ejemplares - min.ejemplares_vendidos;
                minimo(detalles, vec_ventas, min);
            end;

            if (emision.ejemplares_vendidos > ventas_mayor) then begin 
                indice_mayor := filepos(maestro) - 1;
                ventas_mayor := emision.ejemplares_vendidos;
            end;
            if (emision.ejemplares_vendidos < ventas_menor) then begin 
                indice_menor := filepos(maestro) - 1;
                ventas_menor := emision.ejemplares_vendidos;
            end;
            seek(maestro, filepos(maestro) - 1);
            write(maestro, emision);
            leer_maestro(maestro, emision);
        end;

    end;

    if (indice_mayor > -1) then begin 
        seek(maestro, indice_mayor);
        read(maestro, emision);
        writeln('El que tuvo mayor ventas fue: ', emision.fecha, '|', emision.codigo_seminario ,'| Con ' , ventas_mayor, ' ventas');
    end;
    if (indice_menor > -1) then begin 
        seek(maestro, indice_menor);
        read(maestro, emision);
        writeln('El que tuvo menor ventas fue: ', emision.fecha, '|', emision.codigo_seminario ,'| Con ' , ventas_menor, ' ventas');
    end;

    for i:=1 to dimF do begin 
        close(detalles[i]);
    end;
    close(maestro);

end;

procedure imprimir_maestro(var maestro:arch_maestro);
var 
    emision:emisiones;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(maestro, emision);
        writeln(emision.fecha, '|', emision.codigo_seminario, '|', emision.total_ejemplares);
    end;
    close(maestro);
end;

var 
    maestro:arch_maestro;
    detalles:vector_detalle;
    i:integer;
    path, nombre_fisico:string;
begin 
    path:= './detalles/detalle';
    for i:=1 to dimF do begin 
        nombre_fisico := path + IntToStr(i) + '.dat';
        assign(detalles[i], nombre_fisico);
    end;
    assign(maestro, 'maestro.dat');

    actualizar_e_informar(maestro, detalles);
    //imprimir_maestro(maestro);
end.