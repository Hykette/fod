program e3;
uses Sysutils, crt;

type 
    empleado = record
        num_empleado: integer;
        apellido: string;
        nombre: string;
        edad: integer;
        dni: Longint;
    end;

    archivo_empleados = File of empleado;

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
procedure generar_empleado(var empleado:empleado);
begin 
    with empleado do begin
        num_empleado := Random(1000) + 1;              
        nombre := generar_string();        
        apellido := generar_string();      
        edad := Random(60) + 25;                       
        dni := Random(90000000) + 10000000; //se puede cambiar por readln()
    end;
end;

// genera el archivo con 10 empleados con el nombre logico
procedure generar_archivo(var nombre_logico:archivo_empleados);
var 
i:integer; 
emp:empleado;
begin 
    rewrite(nombre_logico);
    for i:=1 to 10 do begin 
        generar_empleado(emp);
        write(nombre_logico, emp);
    end;
    close(nombre_logico);
end;

// imprime los empleados
procedure imprimir_empleado(empleado:empleado);
begin 
    with empleado do begin 
        writeln('=======================================================');
        writeln('numero empleado: ', num_empleado);
        writeln('nombre: ', nombre);
        writeln('apellido: ', apellido);
        writeln('edad: ', edad);
        writeln('dni: ', dni);
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

procedure menu(var eleccion:integer);
begin 
    while ((eleccion < 1) or (eleccion > 3)) do begin // mientras no se ingrese 1,2 o 3
        writeln('Elegir accion: ');
        writeln('1: listar empleados en base a un nombre o apellido');
        writeln('2: listar a todos los empleados');
        writeln('3: listar a los empleados con una edad mayor a 70');
        readln(eleccion);
    end;
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

var 
    nombre_fisico:string;
    nombre_logico:archivo_empleados;
    eleccion:integer;
begin 
    TextColor(GREEN);
    eleccion := -1;
    nombre_fisico := 'empleados.dat'; //se puede cambiar por readln
    assign(nombre_logico, nombre_fisico);
    
    if (not FileExists(nombre_fisico)) then generar_archivo(nombre_logico);

    menu(eleccion);
    case eleccion of
        1: buscar_empleado(nombre_logico);
        2: imprimir_archivo(nombre_logico);
        3: mayor_70(nombre_logico);
        else writeln('.');
    end;
    read(eleccion);
end.

