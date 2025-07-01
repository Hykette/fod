unit types;

interface
const
    valor_alto = 9999;
    dimF = 10; //cantidad de mesas

type
    mesas = record
        codigo_provincia:integer;
        codigo_localidad:integer;
        numero:integer;
        votos:longint;
    end;
    
    informes = record
        codigo_provincia:integer;
        codigo_localidad:integer;
        total_localidad:longint;
        total_provincia:longint;
        total:longint;
    end;

    arch_mesa = file of mesas;
    vector_archivo = array[1..dimF] of arch_mesa;
    vec_mesas = array[1..dimF] of mesas;
    // ordenado por provincia y localidad

    function generar_string():string;
    procedure leer_archivo(var arch:arch_mesa; var mesa:mesas);

implementation

    procedure leer_archivo(var arch:arch_mesa; var mesa:mesas);
    begin 
        if (eof(arch)) then mesa.codigo_provincia := valor_alto
        else read(arch, mesa);
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