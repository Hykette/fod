unit types;

interface 
const 
    valor_alto = 9999;
    dimF = 2; //cantidad de clientes
type 
    cliente = record 
        codigo:integer;
        nombre:string;
        apellido:string;
        anio:integer;
        mes:integer;
        dia:integer;
        venta:real;
    end;
    //ordenado por cliente, anio, mes
    informe  = record 
        codigo:integer;
        anio:integer;
        mes:integer;
        nombre:string;
        apellido:string;
        total_mensual:real;
        total_anual:real;
    end;
    
    archivo_cliente = file of cliente;
    function generar_string():string;
    procedure leer_archivo(var arch:archivo_cliente; var cli:cliente);

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

    procedure leer_archivo(var arch:archivo_cliente; var cli:cliente);
    begin 
        if (eof(arch)) then cli.codigo := valor_alto
        else read(arch, cli);
    end;
end.
{    tenga  en  cuenta  que  puede  haber  meses  en  los  que  los  clientes  no  realizaron 
compras. No es necesario que informe tales meses en el reporte.}
{
 cliente (cod cliente, nombre y apellido), año, 
mes, día y monto de la venta. 

El orden del archivo está dado por: cod cliente, año y mes. 
}