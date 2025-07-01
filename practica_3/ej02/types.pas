unit types;

interface 

const 
    valor_alto = 9999;
    cant_empleados = 600;
type 
    asistentes = record
        id:longint;
        //apellido para bajas logicas
        apellido:string;
        nombre:string;
        email:string;
        telefono:longint;
        dni:longint;
    end;

    arch_maestro = file of asistentes;

    procedure leer_maestro(var maestro:arch_maestro; var asistente:asistentes);
    function generar_string():string;

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

    procedure leer_maestro(var maestro:arch_maestro; var asistente:asistentes);
    begin 
        if (eof(maestro)) then asistente.id := valor_alto
        else read(maestro, asistente);
    end;

end.
