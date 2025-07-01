unit types;

interface 

const 
    dimF = 10;
    valor_alto = 9999;
    valor_bajo = -9999;
type    
    motos = record
        codigo:integer;
        nombre:string;
        descripcion:string;
        modelo:string;
        marca:string;
        stock_actual:integer;
    end;

    ventas = record 
        codigo:integer;
        precio:real;
        fecha:integer;
    end;
    //actualizar stock del maestro desde 10 detalles de ventas
    //informar moto mas vendida

    arch_maestro = file of motos;
    arch_detalle = file of ventas;
    vector_detalle = array [1..dimF] of arch_detalle;
    vector_ventas = array [1..dimF] of ventas;

    function generar_string():string;
    procedure leer_maestro(var maestro:arch_maestro; var registro:motos);
    procedure leer_detalle(var detalle:arch_detalle; var registro:ventas);

implementation

    procedure leer_maestro(var maestro:arch_maestro; var registro:motos);
    begin 
        if (eof(maestro)) then registro.codigo := valor_alto
        else read(maestro, registro);
    end;
    procedure leer_detalle(var detalle:arch_detalle; var registro:ventas);
    begin 
        if (eof(detalle)) then registro.codigo := valor_alto
        else read(detalle, registro);
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