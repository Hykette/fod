unit types;

interface 

const 
    valor_alto = 9999;
    dimF = 10;
    cepas_totales = 5;
type

    casos = record
        codigo_localidad:integer;
        codigo_cepa:integer;
        casos_activos:longint;
        casos_nuevos:longint;
        recuperados:longint;
        fallecidos:longint;
    end;
    resumen = record
        codigo_localidad:integer;
        codigo_cepa:integer;
        nombre_localidad:string;
        nombre_cepa:string;
        casos_activos:longint;
        casos_nuevos:longint;
        recuperados:longint;
        fallecidos:longint;
    end;

    arch_maestro = file of resumen;
    arch_detalle = file of casos;
    vector_detalles = array[1..dimF] of arch_detalle;
    vector_casos = array[1..dimF] of casos;

    procedure leerD(var detalle:arch_detalle; var caso:casos);
    procedure leerM(var maestro:arch_maestro; var res:resumen);
    function generar_string():string;

implementation 
    procedure leerD(var detalle:arch_detalle; var caso:casos);
    begin 
        if (eof(detalle)) then caso.codigo_localidad := valor_alto
        else read(detalle, caso);
    end;
    procedure leerM(var maestro:arch_maestro; var res:resumen);
    begin 
        if (eof(maestro)) then res.codigo_localidad := valor_alto
        else read(maestro, res);
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