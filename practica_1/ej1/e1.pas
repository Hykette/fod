{Realizar un algoritmo que cree un archivo de numeros enteros no ordenados y permita
 incorporar datos al archivo. Los numeros son ingresados desde teclado. La carga finaliza
 cuando se ingresa el numero 30000, que no debe incorporarse al archivo. El nombre del
 archivo debe ser proporcionado por el usuario desde teclado.}
program e1;
uses SysUtils;
type 
    archivo_nums = file of integer;

procedure escribir_archivo(var nombre_logico:archivo_nums);
var 
    i:integer;
begin 
    writeln('escrbir numeros, 5000 para terminar');
    readln(i);
    rewrite(nombre_logico);
    while (i <> 5000) do 
    begin 
        write(nombre_logico, i);
        readln(i);
    end;
    close(nombre_logico);
end;

var 
nombre_logico:archivo_nums;
nombre_fisico:string;
i,numero:integer;
begin 
    nombre_fisico := 'datos.dat';
    assign(nombre_logico, nombre_fisico);
    escribir_archivo(nombre_logico)
end.
