unit types;

interface 

const
    valor_alto = 9999;

type 
    flor = record
        nombre: string[45];
        codigo:integer;
    end;
      
    arch_maestro = file of flor;

    {Abre  el  archivo  y  agrega  una  flor,  recibida  como  parámetro 
    manteniendo la política descrita anteriormente}

    procedure leer_maestro(var maestro:arch_maestro; var f:flor);
    function generar_string():string;
    function borrado(n:integer):boolean;
    
implementation

    procedure leer_maestro(var maestro:arch_maestro; var f:flor);
    begin 
        if(eof(maestro)) then f.codigo := valor_alto
        else read(maestro, f);
    end;

    function borrado(n:integer):boolean;
    begin 
        borrado := (n <= 0);
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
    