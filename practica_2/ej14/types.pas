unit types;

interface 

const 
    valor_alto = 9999;

type
    vuelos = record
        destino:integer; 
        fecha:integer;
        hora:integer;
        asientos_disponibles:integer;
    end;
    // ambos ordenados por destino, fecha y hora
    ventas = record 
        destino:integer;
        fecha:integer;
        hora:integer;
        cantidad_comprados:integer;
    end;

    arch_ventas = file of ventas;
    arch_vuelos = file of vuelos;

    procedure leer_venta(var arch:arch_ventas; var venta:ventas);
    procedure leer_maestro(var arch:arch_vuelos; var vuelo:vuelos);
    
implementation
    procedure leer_maestro(var arch:arch_vuelos; var vuelo:vuelos);
    begin 
        if (eof(arch)) then vuelo.destino := valor_alto 
        else read(arch, vuelo);
    end;

    procedure leer_venta(var arch:arch_ventas; var venta:ventas);
    begin 
        if (eof(arch)) then venta.destino := valor_alto
        else read(arch, venta);
    end;

end.