unit types;

interface

type 
    celular = record
        codigo:longint;
        nombre:string;
        descripcion:string;
        marca:string;
        
        precio:double;
        stock_minimo:longint;
        stock_disponible:longint;
    end;

    archivo_celulares = file of celular;
    archivo_txt = TextFile;


implementation 
end.
