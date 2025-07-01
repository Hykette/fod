unit types;

{
Una cadena de tiendas de indumentaria posee un archivo maestro no ordenado con 
la información correspondiente a las prendas que se encuentran a la venta. De cada 
prenda  se  registra:  cod_prenda,  descripción,  colores,  tipo_prenda,  stock  y 
precio_unitario.
}

interface 
const 
    valor_alto = 9999;
type
    prendas = record
        codigo:integer;
        descripcion:string;
        colores:string;
        tipo:string;
        // stock como indice
        stock:longint;
        precio_unitario:real;
    end;

    obsoletas = record
        codigo:integer;
    end;

    arch_prendas = file of prendas;
    arch_obsoletas = file of obsoletas;

    procedure leer_prendas(var arch:arch_prendas; var prenda:prendas);
    procedure leer_obsoletas(var arch:arch_obsoletas; var obsoleta:obsoletas);
    function generar_string():string;
    function borrado(n:integer):boolean;
    
implementation 

    procedure leer_prendas(var arch:arch_prendas; var prenda:prendas);
    begin 
        if (eof(arch)) then prenda.codigo := valor_alto
        else read(arch, prenda);
    end;

    procedure leer_obsoletas(var arch:arch_obsoletas; var obsoleta:obsoletas);
    begin 
        if (eof(arch)) then obsoleta.codigo := valor_alto
        else read(arch, obsoleta);
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