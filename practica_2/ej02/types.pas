{Maestro: codigo, nombre, precio, stock_actual, stock_minimo;
Detalle: codigo, cantidad de unidades vendidas}
unit types;

interface

const 
    valor_alto = 9999;
type
    producto = record
        nombre: string;
        codigo: integer;
        stock_actual: integer;
        stock_minimo: integer;
        precio: real;
    end;
    
    ventas = record
        codigo: integer;
        cantidad: integer;
    end;

    arch_stock = file of producto;
    arch_ventas = file of ventas;
    txt = file of text;

    procedure leerD(var archD: arch_ventas; var ven:ventas);
    procedure leerM(var archM: arch_stock; var prod:producto);

implementation

procedure leerD(var archD: arch_ventas; var ven:ventas);
begin 
    if (eof(archD)) then ven.codigo := valor_alto
    else read(archD, ven);
end;

procedure leerM(var archM: arch_stock; var prod:producto);
begin 
    if (eof(archM)) then prod.codigo := valor_alto
    else read(archM, prod);
end;
        


end.