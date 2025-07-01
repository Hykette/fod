unit types;

interface 
const
    valor_alto = 9999;
    dimF = 10;
type 

    maestro = record
        partida_nacimiento:longint;
        nombre:string;
        apellido:string;
        direcion: array[1..5] of integer; 
        // calle, nro, piso depto, ciudad;
        matricula_medico:integer;
        nombre_madre:string;
        apellido_madre:string;
        dni_madre:longint;
        nombre_padre:string;
        apellido_padre:string;
        dni_padre:longint;
        fallecio:boolean;
        matricula_medico_deceso:integer;
        fecha:integer;
        hora:integer;
        lugar:string;
    end;
    
    nacimientos = record
        partida_nacimiento:longint;
        nombre:string;
        apellido:string;
        direcion: array[1..5] of integer; 
        // calle, nro, piso depto, ciudad;
        matricula_medico:integer;
        nombre_madre:string;
        apellido_madre:string;
        dni_madre:longint;
        nombre_padre:string;
        apellido_padre:string;
        dni_padre:longint;
    end;

    fallecimientos = record
        partida_nacimiento:longint;
        dni:longint;
        nombre:string;
        apellido:string;
        matricula_medico:integer;
        fecha:integer;
        hora:integer;
        lugar:string;
    end;

    archivo_fallecimientos = file of fallecimientos;
    archivo_nacimientos = file of nacimientos;
    archivo_maestro = file of maestro;

    vector_detalle_fallecimientos = array [1..dimF] of archivo_fallecimientos;
    vector_detalle_nacimientos = array [1..dimF] of archivo_nacimientos;

    vector_fallecimientos = array [1..dimF] of fallecimientos;
    vector_nacimientos = array [1..dimF] of nacimientos;

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

end.

    {
    Todos los archivos están ordenados por nro partida de nacimiento que es única. Tenga 
    en  cuenta  que  no  necesariamente  va  a  fallecer  en  el  distrito  donde  nació  la  persona  y 
    además puede no haber fallecido 
    }
