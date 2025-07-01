{4. Agregar al menú del programa del ejercicio 3, opciones para:
 a. Añadir uno o más empleados al final del archivo con sus datos ingresados por
 teclado. Tener en cuenta que no se debe agregar al archivo un empleado con
 un número de empleado ya registrado (control de unicidad).
 b. Modificar la edad de un empleado dado.
 c. Exportar el contenido del archivo a un archivo de texto llamado
 “todos_empleados.txt”.
 d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
 que no tengan cargado el DNI (DNI en 00).
NOTA: Las búsquedas deben realizarse por número de empleado.}
unit parte_del_e3;
interface

type 
    empleado = record
        num_empleado: integer;
        apellido: string;
        nombre: string;
        edad: integer;
        dni: Longint;
    end;

    archivo_empleados = File of empleado;


function generar_string():string;
procedure generar_empleado(var empleado:empleado);
procedure generar_archivo(var nombre_logico:archivo_empleados);
procedure imprimir_empleado(empleado:empleado);
procedure imprimir_archivo(var nombre_logico:archivo_empleados);
procedure buscar_empleado(var nombre_logico:archivo_empleados);
procedure mayor_70(var nombre_logico:archivo_empleados);



implementation
uses Sysutils, crt;

// genera un nomnbre y apellido random como "dawldkja" 
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

// randomiza los campos del empleado
// se puede cambiar por readln()
procedure generar_empleado(var empleado:empleado);
begin 
    with empleado do begin
        num_empleado := Random(1000) + 1;              
        nombre := generar_string();        
        apellido := generar_string();      
        edad := Random(60) + 25;        
        // para chequear esta en 00               
        dni := 00 // Random(90000000) + 10000000; 
    end;
end;

// genera el archivo con 10 empleados con el nombre logico
procedure generar_archivo(var nombre_logico:archivo_empleados);
var 
i:integer; 
emp:empleado;
begin 
    rewrite(nombre_logico);
    for i:=1 to 3 do begin 
        generar_empleado(emp);
        write(nombre_logico, emp);
    end;
    close(nombre_logico);
end;

// imprime los empleados
procedure imprimir_empleado(empleado:empleado);
begin 
    with empleado do begin 
        writeln('=============================================================');
        writeln('numero empleado: ', num_empleado);
        writeln('edad: ', edad);
        {writeln('nombre: ', nombre);
        writeln('apellido: ', apellido);
        
        writeln('dni: ', dni);}
    end;
end;

// imprime los empleados del archivo
procedure imprimir_archivo(var nombre_logico:archivo_empleados);
var 
emp: empleado;
begin 
    reset(nombre_logico);
    while (not EOF(nombre_logico)) do begin 
        read(nombre_logico, emp);
        imprimir_empleado(emp);
    end;
    close(nombre_logico);
end;

procedure buscar_empleado(var nombre_logico:archivo_empleados);
var 
    emp:empleado; 
    nombre:string;
begin 
    writeln('nombre o apellido del empleado a buscar: ');  
    readln(nombre);
    reset(nombre_logico);   
    while not eof(nombre_logico) do begin 
        read(nombre_logico, emp);
        if ((emp.nombre = nombre) or (emp.apellido = nombre)) then imprimir_empleado(emp);
    end;
    close(nombre_logico);
end;

procedure mayor_70(var nombre_logico:archivo_empleados);
var
    emp:empleado;
begin 
    reset(nombre_logico);
    while not eof(nombre_logico) do begin 
        read(nombre_logico, emp);
        if (emp.edad > 70) then imprimir_empleado(emp);
    end;
    close(nombre_logico);
end;
END.