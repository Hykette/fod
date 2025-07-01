program e2;
uses types;

procedure actualizar_maestro(var maestro: arch_stock; var detalle: arch_ventas);
var 
    ven: ventas;
    prod: producto;
begin 
    reset(maestro);
    reset(detalle);

    leerD(detalle, ven);
    leerM(maestro, prod); //es lo mismo que con un read en este caso 

    while (ven.codigo <> valor_alto) do begin 
        while (prod.codigo <> ven.codigo) do leerM(maestro, prod);
        while (prod.codigo = ven.codigo) do begin 
            prod.stock_actual := prod.stock_actual - ven.cantidad;
            leerD(detalle, ven);
        end;
        seek(maestro, filepos(maestro) - 1);
        write(maestro, prod);
    end;

    close(maestro);
    close(detalle);
end;

procedure imprimir_maestro(var arch:arch_stock);
var 
    prod:producto;
begin 
    reset(arch);
    while (not eof(arch)) do begin 
        read(arch, prod);
        writeln(prod.codigo, ' ', ' stock_actual: ', prod.stock_actual);
    end;
    close(arch);
end;

var 
    maestro:arch_stock;
    detalle:arch_ventas;
    texto:txt;
begin 
    assign(maestro, 'stock.dat');
    assign(detalle, 'ventas.dat');
    actualizar_maestro(maestro, detalle);
    imprimir_maestro(maestro);
end.
