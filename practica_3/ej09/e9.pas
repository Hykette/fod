program e9;

uses types;

function suma_cant(var detalle:arch_detalle; cod:integer):integer;
var 
    venta:ventas;
    total:integer;
begin 
    total := 0;
    reset(detalle);

    while (not eof(detalle)) do begin 
        read(detalle, venta);
        if (venta.codigo = cod) then total := total + venta.cantidad;
    end;

    close(detalle);
    suma_cant := total;
end;

function una_aparicion(var detalle:arch_detalle; cod:integer):integer;
var 
    venta:ventas;
    total:integer;
begin 
    total := 0;
    reset(detalle);

    leer_detalle(detalle, venta);
    while ((venta.codigo <> valor_alto) and (venta.codigo <> cod)) do leer_detalle(detalle, venta);

    close(detalle);

    if (venta.codigo = cod) then total := total + venta.cantidad;

    una_aparicion := total;
end;


procedure actualizar_maestro(var maestro:arch_maestro; var detalle:arch_detalle);
var 
    producto:productos;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(maestro, producto);
        
        producto.stock_actual := producto.stock_actual - suma_cant(detalle, producto.codigo);

        seek(maestro, filepos(maestro) - 1);
        write(maestro, producto);
    end;
    close(maestro);
end;


var 
    maestro:arch_maestro;
    detalle:arch_detalle;
begin 
    assign(maestro, 'maestro.dat');
    assign(detalle, 'detalle.dat');
    actualizar_maestro(maestro, detalle);
    imprimir_maestro(maestro);
end.