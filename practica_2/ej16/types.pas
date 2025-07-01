unit types;

interface 

const 
    valor_alto = 9999;
    valor_bajo = -9999;
    // dimF hace que haya dimF archivos
    dimF = 100;
type 
    emisiones = record
        fecha:longint;
        codigo_seminario:integer;
        nombre_seminario:string;
        descripcion:string;
        precio:real;
        total_ejemplares:longint;
        ejemplares_vendidos:longint;
    end;

    ventas = record
        fecha:longint;
        codigo_seminario:longint;
        ejemplares_vendidos:longint;
    end;

    arch_maestro = file of emisiones;
    arch_detalle = file of ventas;
    vector_detalle = array [1..dimF] of arch_detalle;
    vector_ventas = array [1..dimF] of ventas;
    // ordenado por fecha y codigo_seminario
    // actualizar e informar fecha y seminarios con mas y con menos ventas
    function generar_string():string;
    procedure leer_maestro(var maestro:arch_maestro; var registro:emisiones);
    procedure leer_detalle(var detalle:arch_detalle; var registro:ventas);

implementation

    procedure leer_maestro(var maestro:arch_maestro; var registro:emisiones);
    begin 
        if (eof(maestro)) then registro.fecha := valor_alto
        else read(maestro, registro);
    end;
    procedure leer_detalle(var detalle:arch_detalle; var registro:ventas);
    begin 
        if (eof(detalle)) then registro.fecha := valor_alto
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

