unit types;

interface

type
    novela = record
        codigo:Longint;
        precio:double;
        genero:string;
        nombre:string;
    end;
    
    archivo_txt = TextFile;
    archivo_novelas = File of novela;

procedure crear_novela(var nov:novela);
function generar_string():string;

implementation

procedure crear_novela(var nov:novela);
begin 
    with nov do begin 
        codigo := random(82376) + 1;
        precio := random(100000) + 1 + (1 / (random(99) + 1));
        genero := generar_string();
        nombre := generar_string();
    end;
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