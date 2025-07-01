program generar_archivos;

uses types;

procedure generar_maestro_detalle(var maestro:arch_maestro; var detalle:arch_detalle);
var     
    i, j, veces:integer;
    producto:productos;
    venta:ventas;
begin 
    rewrite(maestro);
    rewrite(detalle);
    for i:=1 to 20 do begin 
        producto.codigo := i;
        venta.codigo := i;
        producto.nombre := generar_string();
        producto.precio := random(1000) + (1 / (random(100) + 1));
        producto.stock_actual := random(200) + 20;
        producto.stock_minimo := random(100) + 100;
        write(maestro, producto);
        veces := random(5);
        for j:=1 to veces do begin 
            venta.cantidad := random(10) + 1;
            write(detalle, venta);
        end;
    end;
    close(maestro);
    close(detalle);
end;

var 
    maestro:arch_maestro;
    detalle:arch_detalle;
begin 
    assign(maestro, 'maestro.dat');
    assign(detalle, 'detalle.dat');
    generar_maestro_detalle(maestro, detalle);
    imprimir_maestro(maestro);
    imprimir_detalle(detalle);
end.

