{
Suponga que trabaja en una oficina donde está montada una  LAN (red local). La misma fue 
construida  sobre  una  topología  de  red  que  conecta  5  máquinas  entre  sí  y  todas  las 
máquinas  se  conectan  con  un  servidor  central.  Semanalmente  cada  máquina  genera un 
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por 
cuánto  tiempo  estuvo  abierta.  Cada  archivo  detalle  contiene  los  siguientes  campos: 
cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos 
detalle  y  genere  un  archivo  maestro  con  los  siguientes  datos:  cod_usuario,  fecha, 
tiempo_total_de_sesiones_abiertas.
}

// es un merge semanal
unit types;
//5 en total
interface

const
    dimF = 5;
    valor_alto = 9999;
type
    logins = record
        codigo:integer;
        fecha:integer;
        tiempo_sesion:real;
    end;

    resumen = record
        codigo:integer;
        fecha:integer;
        tiempo_total:real;
    end;

    arch_detalle = file of logins;

    arch_maestro = file of resumen;

    detalles = array [1..dimF] of arch_detalle;

    vector_logs = array [1..dimF] of logins;

    procedure leerD(var detalle:arch_detalle; var registro:logins);
    procedure leerM(var maestro:arch_maestro; var registro:resumen);
    
implementation

    procedure leerD(var detalle:arch_detalle; var registro:logins);
    begin 
        if (eof(detalle)) then registro.codigo := valor_alto
        else read(detalle, registro);
    end;
    procedure leerM(var maestro:arch_maestro; var registro:resumen);
    begin 
        if(eof(maestro)) then registro.codigo := valor_alto
        else read(maestro, registro);
    end;
    
end.

