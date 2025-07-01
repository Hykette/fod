program generar_archivos;
uses types;

function generar_string():string;
const
    caracteres = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
    i, longitud: integer; aux: string;
begin
    aux := '';
    longitud := 5;
    for i := 1 to longitud do begin
        aux := aux + caracteres[Random(52) + 1]; 
    end;
    generar_string := aux;
end;

{Maestro: codigo, nombre, precio, stock_actual, stock_minimo;
Detalle: codigo, cantidad de unidades vendidas}

procedure generar_detalle(var archD:arch_ventas);
var 
    ven:ventas;
    i, j, veces:integer;
begin 
    rewrite(archD);
    with ven do begin 
        for i:=1 to 10 do begin 
            codigo := i;
            cantidad := random(3) + 1;
            veces := random(5) + 1;
            for j:=1 to veces do begin 
                write(archD, ven);
                cantidad := random(3) + 1;
            end;
        end;
    end;
    close(archD);
end;

procedure generar_maestro(var archM: arch_stock);
var 
    prod: producto;
    i: integer;
begin 
    rewrite(archM);
    with prod do begin 
        for i:=1 to 20 do begin
            codigo := i;
            nombre := generar_string();
            precio := random(10000) + (1 / (random(10) + 1));
            stock_minimo := 100;
            stock_actual := 100 + random(100);
            write(archM, prod);
        end;
    end;
    close(archM);
end;
procedure imprimirD(var archD:arch_ventas);
var 
    ven:ventas;
    aux:integer;
begin 
    reset(archD);
    leerD(archD, ven);
    while (ven.codigo <> valor_alto) do begin 
        aux := ven.codigo;
        writeln('codigo: ', ven.codigo, ' cantidad: ');
        while (ven.codigo = aux) do begin 
            write(ven.cantidad, '|');
            leerD(archD, ven);
        end;
        writeln();
    end;
    close(archD);
end;

procedure imprimirM(var archM:arch_stock);
var 
    prod:producto;
begin
    reset(archM);
    while (not eof(archM)) do begin 
        read(archM, prod);
        writeln(prod.codigo, ' ', prod.stock_actual);
    end;
    close(archM);
end;

var 
    maestro: arch_stock;
    detalle: arch_ventas;
begin 
    assign(detalle, 'ventas.dat');
    assign(maestro, 'stock.dat');
    generar_maestro(maestro);
    generar_detalle(detalle);
    imprimirM(maestro);
    imprimirD(detalle);
end.

{Maestro: codigo, nombre, precio, stock_actual, stock_minimo;
Detalle: codigo, cantidad de unidades vendidas}