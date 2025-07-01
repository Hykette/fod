unit types;

{
Se deberá tener en cuenta las siguientes aclaraciones: 
●  El año sobre el cual realizará el informe de accesos debe leerse desde el teclado. 
●  El año puede no existir en el archivo, en tal caso, debe informarse en pantalla “año 
no encontrado”. 
●  Debe definir las estructuras de datos necesarias.  
●  El recorrido del archivo debe realizarse una única vez procesando sólo la información 
necesaria.

Se debe realizar un procedimiento que genere un informe en pantalla, para ello se indicará 
el año calendario sobre el cual debe realizar el informe. El mismo debe respetar el formato 
mostrado a continuación: 
}

interface 

const 
    valor_alto = 9999;

type
    accesos = record
        anio:integer;
        mes:integer;
        dia:integer;
        id:integer;
        tiempo:real;
    end;
    //orden: anio, mes, dia, id
    //informe de un anio especifico
    informe = record
        anio:integer;
        mes:integer;
        dia:integer;
        id:integer;
        tiempo_anio:real;
        tiempo_dia:real;
        tiempo_mes:real;
    end;

    archivo = file of accesos;
    procedure leer_archivo(var arch:archivo; var acceso:accesos);

implementation
    procedure leer_archivo(var arch:archivo; var acceso:accesos);
    begin 
        if (eof(arch)) then acceso.anio := valor_alto
        else read(arch, acceso);
    end;
end.
        