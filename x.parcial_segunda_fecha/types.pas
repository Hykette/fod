unit types;

interface 

const 
    valor_alto = 32767;
    valor_bajo = -32768;
    cant_detalles = 12;
    equipos_totales = 30;

type
    
    equipo = record
        codigo: integer;
        nombre: string;
        jugados: integer;
        ganados: integer;
        empatados: integer;
        perdidos: integer;
        puntos: integer;
    end;

    partido = record
        codigo: integer;
        fecha: integer;
        puntos: integer; //3=W 1=D 0=L
        cod_rival: integer;
    end;

    equipo_maximo = record
        nombre:string;
        puntos_temporada:integer;
    end;

    // Archivos
    arch_maestro = file of equipo;
    arch_detalle = file of partido;

    vector_detalles = array[1..cant_detalles] of arch_detalle;
    vector_registros = array[1..cant_detalles] of partido;

    procedure leer_maestro(var maestro:arch_maestro; var registro:equipo);
    procedure leer_detalle(var detalle:arch_detalle; var registro:partido);
    function generar_string():string;

implementation 

    procedure leer_maestro(var maestro:arch_maestro; var registro:equipo);
    begin 
        if (eof(maestro)) then registro.codigo := valor_alto 
        else read(maestro, registro);
    end;

    procedure leer_detalle(var detalle:arch_detalle; var registro:partido);
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