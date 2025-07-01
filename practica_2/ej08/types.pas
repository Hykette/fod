unit types;

interface

const 
    valor_alto = 999;
    dimF = 16;

type
    provincia = record
        codigo_provincia:integer;
        nombre:string;
        habitantes:longint;
        kilos_historicos:longint;
    end;
    consumos = record
        codigo_provincia:integer;
        kilos:integer;
    end;

    arch_maestro = file of provincia;
    arch_detalle = file of consumos;

    vec_detalles = array[1..dimF] of arch_detalle;
    vector_consumos = array[1..dimF] of consumos;

    //ambos ordenados por provincia y puede aparecer varias veces
    // y en archivos diferentes
    function generar_string():string;
    procedure leerD(var detalle:arch_detalle; var consumo:consumos);
    procedure leerM(var maestro:arch_maestro; var prov:provincia);
    
implementation

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

    procedure leerD(var detalle:arch_detalle; var consumo:consumos);
    begin
        if (eof(detalle)) then consumo.codigo_provincia := valor_alto 
        else read(detalle, consumo);
    end;
    procedure leerM(var maestro:arch_maestro; var prov:provincia);
    begin 
        if (eof(maestro)) then prov.codigo_provincia := valor_alto
        else read(maestro, prov);
    end;

end.