{
Una  empresa  posee un archivo con información de los ingresos percibidos por diferentes 
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado, 
nombre  y  monto  de  la  comisión.  La  información  del  archivo  se  encuentra  ordenada  por 
código  de  empleado  y  cada  empleado puede aparecer más de una vez en el archivo de 
comisiones.  
Realice  un  procedimiento  que  reciba  el archivo anteriormente descrito y lo compacte. En 
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una 
única vez con el valor total de sus comisiones. 
NOTA:  No  se  conoce  a  priori  la  cantidad  de  empleados.  Además,  el  archivo  debe  ser 
recorrido una única vez

registro ingreso de empleados 
codigo, nombre, monto de comision. ordenado por codigo de empleado y cada empleado puede aparecer mas de una vez

generar un 'maestro' a partir de un archivo de comisiones.
}
program e1;
uses types;

procedure compactar(var archD:arch_comisiones; var archM:arch_resumen_comisiones);
var 
    com: comision;
    aux: comision;
    suma: real;
begin 
    reset(archD);
    rewrite(archM);
    leer(archD, com);
    while (com.codigo <> valor_alto) do begin 
        aux := com; 
        suma := 0;
        while (com.codigo = aux.codigo) do begin 
            suma := suma + com.monto;
            leer(archD, com);
        end;
        aux.monto := suma;
        write(archM, aux);
    end;
    close(archD);
    close(archM);
end;

procedure imprimir_archivoM(var archM: arch_resumen_comisiones);
var 
    com: comision;
begin 
    reset(archM);
    while (not eof(archM)) do begin 
        read(archM, com);
        writeln(com.codigo, ' ', 'Total comisiones: ', com.monto:0:2);
    end;
    close(archM);
end;

procedure imprimir_archivoD(var archD: arch_comisiones);
var 
    com: comision;
    aux: integer;
begin 
    reset(archD);
    leer(archD, com);
    if (com.codigo <> valor_alto) then begin 
        aux := com.codigo;
        writeln(com.nombre, ' ', com.codigo, ':');
        write('Valor comisiones: ');
        while ((com.codigo <> valor_alto) and (com.codigo = aux)) do begin 
            write(com.monto:0:2, '|');
            leer(archD, com);
        end;
        writeln();
    end;
    close(archD);
end;

var 
    archD:arch_comisiones;
    archM:arch_resumen_comisiones;
begin 
    assign(archD, 'comisiones.dat');
    assign(archM, 'resumen_comisiones.dat');
    compactar(archD, archM);
    imprimir_archivoD(archD);
    imprimir_archivoM(archM);
end.