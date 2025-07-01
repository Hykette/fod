program generar_archivos;

uses types;

var 
    i:integer;
    maestro:archivo_empleados;
begin 
    assign(maestro, 'maestro.dat');
    generar_archivo(maestro);
    imprimir_archivo(maestro);
end.