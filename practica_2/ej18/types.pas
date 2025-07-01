unit types;

interface 

const 
    valor_alto = 9999;
type 

    casos = record
        codigo_localidad:integer;
        codigo_municipio:integer;
        codigo_hospital:integer;
        nombre_localidad:string;
        nombre_municipio:string;
        nombre_hospital:string;
        fecha:integer;
        casos_positivos:longint;
    end;
    // localidad, municipio, hospital

    informe = record
        //aux
        codigo_localidad:integer;
        codigo_municipio:integer;
        codigo_hospital:integer;
        //suma
        casos_localidad:longint;
        casos_municipio:longint;
        casos_hospital:longint;
        //txt
        nombre_localidad:string;
        nombre_municipio:string;
        // + municipio que ya esta
    end;
    //si los casos superan 1500 (municipio)

    arch_maestro = file of casos;

    function generar_string():string;
    procedure leer_maestro(var maestro:arch_maestro; var registro:casos);

implementation

    procedure leer_maestro(var maestro:arch_maestro; var registro:casos);
    begin 
        if (eof(maestro)) then registro.codigo_localidad := valor_alto 
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