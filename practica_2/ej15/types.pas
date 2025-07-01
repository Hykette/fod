unit types;

interface

const 
    valor_alto = 9999;
    dimF = 10;
type

    carencias = record
        codigo_provincia:integer;
        codigo_localidad:integer;
        nombre_provincia:string;
        nombre_localidad:string;
        viviendas: array [1..5] of integer;
        
    end;

    obras = record
        codigo_provincia:integer;
        codigo_localidad:integer;
        nombre_provincia:string;
        nombre_localidad:string;
        obras: array [1..5] of integer;
    end;
    // luz, agua, gas, sanitarios, vivienda

    arch_maestro = file of carencias;
    arch_detalle = file of obras;
    vector_detalles = array[1..dimF] of arch_detalle;
    vector_obras = array[1..dimF] of obras;

    function generar_string():string;
    procedure leer_detalle(var detalle:arch_detalle; var registro:obras);
    procedure leer_maestro(var maestro:arch_maestro; var registro:carencias);

implementation

    procedure leer_detalle(var detalle:arch_detalle; var registro:obras);
    begin 
        if (eof(detalle)) then registro.codigo_provincia := valor_alto
        else read(detalle, registro);
    end;

    procedure leer_maestro(var maestro:arch_maestro; var registro:carencias);
    begin 
        if (eof(maestro)) then registro.codigo_provincia := valor_alto
        else read(maestro, registro);
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
{
El orden pedido deberia ser: luz, gas, chapa, agua, sanitarios y luz, construidas, agua, gas sanitarios. pero para que sea mas facil hago 
luz, agua, gas, sanitarios, vivienda
}