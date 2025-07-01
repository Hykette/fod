program e14;

uses types;

procedure minimo(var det1, det2:arch_ventas; var venta_1, venta_2:ventas; var min:ventas);
begin 
    if (venta_1.destino < venta_2.destino) or 
       ((venta_1.destino = venta_2.destino) and (venta_1.fecha < venta_2.fecha)) or 
       ((venta_1.destino = venta_2.destino) and (venta_1.fecha = venta_2.fecha) and (venta_1.hora < venta_2.hora)) then 
    begin 
        min := venta_1;
        leer_venta(det1, venta_1);
    end else begin 
        min := venta_2;
        leer_venta(det2, venta_2);
    end;
end;

procedure actualizar_e_informar(var maestro:arch_vuelos; var det1,det2:arch_ventas; x:integer);
var 
    venta_1:ventas;
    venta_2:ventas;
    vuelo:vuelos;
    min:ventas;
    aux:vuelos;
begin 
    reset(det1);
    reset(det2);
    reset(maestro);
    leer_venta(det1, venta_1);
    leer_venta(det2, venta_2);

    minimo(det1, det2, venta_1, venta_2, min);
    leer_maestro(maestro, vuelo);
    
    while ((min.destino <> valor_alto) and (vuelo.destino <> valor_alto)) do begin 

        aux := vuelo;
        while ((vuelo.destino = aux.destino) and (vuelo.fecha = aux.fecha) and (vuelo.hora = aux.hora) and (vuelo.destino <> min.destino)) do begin 
            if (vuelo.asientos_disponibles < x) then writeln('asientos disponibles < ', x, ' ', vuelo.destino, '|', vuelo.fecha, '|', vuelo.hora);
            leer_maestro(maestro, vuelo);
        end;

        while ((vuelo.destino <> valor_alto) and (vuelo.destino = min.destino) and (vuelo.fecha = min.fecha) and (vuelo.hora = min.hora)) do begin 
            vuelo.asientos_disponibles := vuelo.asientos_disponibles - min.cantidad_comprados;
            minimo(det1,det2, venta_1, venta_2, min);
        end;
        if (vuelo.asientos_disponibles < x) then writeln('asientos disponibles < ', x, ' ', vuelo.destino, '|', vuelo.fecha, '|', vuelo.hora, ': ', vuelo.asientos_disponibles);

        seek(maestro, filepos(maestro) - 1);
        write(maestro, vuelo);
        leer_maestro(maestro, vuelo);
    end;
    
    close(det1);
    close(det2);
    close(maestro);
end;

procedure imprimir_maestro(var maestro:arch_vuelos);
var 
    vuelo:vuelos;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(maestro, vuelo);
        writeln('destino: ', vuelo.destino, '|', vuelo.fecha, '|', vuelo.hora, '|', vuelo.asientos_disponibles);
    end;
    close(maestro);
end;

var 
    maestro:arch_vuelos;
    det1, det2:arch_ventas;
    x:integer;
begin 
    assign(det1, 'det1.dat');
    assign(det2, 'det2.dat');
    assign(maestro, 'maestro.dat');
    x := 9990;
    actualizar_e_informar(maestro, det1, det2, x);
    imprimir_maestro(maestro);
end.



