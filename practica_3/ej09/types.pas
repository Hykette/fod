unit types;

interface 

const 
    valor_alto = 9999;

type 

    productos = record
        codigo:integer;
        nombre:string;
        precio:real;
        stock_actual:integer;
        stock_minimo:integer;
    end;
    
    ventas = record
        codigo:integer;
        cantidad:integer;
    end;

    arch_maestro = file of productos;
    arch_detalle = file of ventas;

    procedure leer_maestro(var maestro:arch_maestro; var producto:productos);
    procedure leer_detalle(var detalle:arch_detalle; var venta:ventas);
    function generar_string():string;
    procedure imprimir_maestro(var maestro:arch_maestro);
    procedure imprimir_detalle(var detalle:arch_detalle);

implementation 

    procedure imprimir_maestro(var maestro:arch_maestro);
    var 
        producto:productos;
    begin 
        reset(maestro);
        while (not eof(maestro)) do begin 
            read(maestro, producto);
            write(producto.codigo, '|', producto.stock_actual, '|  ');
        end;
        close(maestro);
        writeln();
    end;

    procedure imprimir_detalle(var detalle:arch_detalle);
    var 
        venta:ventas;
    begin 
        reset(detalle);
        while (not eof(detalle)) do begin 
            read(detalle, venta);
            write(venta.codigo, '|', venta.cantidad, '|  ');
        end;
        close(detalle);
        writeln();
    end;

    procedure leer_maestro(var maestro:arch_maestro; var producto:productos);
    begin 
        if (eof(maestro)) then producto.codigo := valor_alto
        else read(maestro, producto);
    end;

    procedure leer_detalle(var detalle:arch_detalle; var venta:ventas);
    begin 
        if (eof(detalle)) then venta.codigo := valor_alto
        else read(detalle, venta);
    end;

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

end.