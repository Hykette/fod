program generar_archivos;

uses types;

procedure generar_archivos(var arch1:arch_ventas; var arch2:arch_ventas; var maestro:arch_vuelos); 
var 
    venta:ventas;
    vuelo:vuelos;
    i, j, k, l, veces:integer;
begin 
    rewrite(arch1);
    rewrite(arch2);
    rewrite(maestro);
    for i:=1 to 2 do begin 
        venta.destino := i;
        vuelo.destino := i;
        for j:=1 to 2 do begin 
            venta.fecha := j;
            vuelo.fecha := j;
            for k:=1 to 2 do begin 
                venta.hora := k;
                vuelo.hora := k;
                vuelo.asientos_disponibles := 10000;
                write(maestro, vuelo);
                veces := random(5) + 1; 
                for l:=1 to veces do begin 
                    venta.cantidad_comprados := random(10) + 1;
                    write(arch1, venta);
                end;
                veces := random(5) + 1;
                for l:=1 to veces do begin 
                    venta.cantidad_comprados := random(10) + 1;
                    write(arch2, venta);
                end;
            end;
        end;
    end;
    close(arch1);
    close(arch2);
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

procedure imprimir_detalles(var arch1:arch_ventas; var arch2:arch_ventas);
var 
    venta:ventas;
begin 
    reset(arch1);
    while (not eof(arch1)) do begin 
        read(arch1, venta);
        writeln(venta.destino, '|', venta.fecha, '|', venta.hora, '|', venta.cantidad_comprados);
    end;
    close(arch1);
    writeln();
    writeln();
    reset(arch2);
    while (not eof(arch2)) do begin 
        read(arch2, venta);
        writeln(venta.destino, '|');
    end;    
    close(arch2);
end;

var
    maestro:arch_vuelos;
    det1:arch_ventas;
    det2:arch_ventas;
begin 
    assign(det1, 'det1.dat');
    assign(det2, 'det2.dat');
    assign(maestro, 'maestro.dat');
    generar_archivos(det1, det2, maestro);
    imprimir_maestro(maestro);
    writeln('=============================');
    imprimir_detalles(det1, det2);
end.