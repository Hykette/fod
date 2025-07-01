{Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
 creado en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y el
 promedio de los números ingresados. El nombre del archivo a procesar debe ser
 proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
 contenido del archivo en pantalla}
program e2;
uses SysUtils;
type 
    archivo_nums = file of integer;

procedure procesar_archivo(var nombre_logico:archivo_nums);
var
    i:integer;
    cantidad_mayor_1500:integer;
    sum:longint;
    promedio:real;
begin 
    sum := 0; cantidad_mayor_1500 := 0;
    reset(nombre_logico);
    while (not EOF(nombre_logico)) do begin 
        read(nombre_logico, i);
        if (i < 1500) then inc(cantidad_mayor_1500); 
        sum := sum + i;        
    end;

    promedio := sum / filesize(nombre_logico);
    writeln('numeros mayores a 1500 = ', cantidad_mayor_1500);
    writeln('el promedio de los numeros en el archivo es ', promedio:0:2);
    close(nombre_logico);
end;

var 
    nombre_fisico:string;
    nombre_logico:archivo_nums;
begin 
    writeln('nombre del archivo:');
    readln(nombre_fisico);
    if (not fileExists(nombre_fisico)) then writeln('no existe eso') else 
    begin 
        assign(nombre_logico, nombre_fisico);
        procesar_archivo(nombre_logico);
    end;
end.
