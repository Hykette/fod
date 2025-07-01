unit types;

interface
const 
    valor_alto = 9999;
type 
    empleado = record
        num_empleado: integer;
        apellido: string;
        nombre: string;
        edad: integer;
        dni: Longint;
    end;

    archivo_empleados = File of empleado;
    texto = TextFile;

function generar_string():string;
procedure generar_empleado(var empleado:empleado);
procedure generar_archivo(var nombre_logico:archivo_empleados);
procedure imprimir_empleado(empleado:empleado);
procedure imprimir_archivo(var nombre_logico:archivo_empleados);
procedure buscar_empleado(var nombre_logico:archivo_empleados);
procedure mayor_70(var nombre_logico:archivo_empleados);

procedure escribir_archivo_txt(var archivo_txt:texto; emp:empleado);
procedure pasar_sin_dni_txt(var archivo_txt:texto; var archivo_binario:archivo_empleados; nombre_fisico_txt:string);
procedure pasar_a_archivo_txt(var archivo_txt:texto; var archivo_binario:archivo_empleados; nombre_fisico_txt:string);
procedure test_empleado(var archivo_binario:archivo_empleados; var emp:empleado);
procedure buscar_agregar(var archivo_binario:archivo_empleados; nuevo_emp:empleado);
procedure agregar_empleado(var archivo_binario:archivo_empleados);
function modificar_empleado(var numero_empleado:integer; var edad:integer;var archivo_binario:archivo_empleados):boolean;
procedure leer_y_modificar(var archivo_binario:archivo_empleados);
procedure menu(var eleccion:integer);

procedure leer_empleado(var maestro:archivo_empleados; var registro:empleado);

implementation
uses Sysutils, crt;

procedure leer_empleado(var maestro:archivo_empleados; var registro:empleado);
begin 
    if (eof(maestro)) then registro.num_empleado := valor_alto
    else read(maestro, registro);
end;

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

//============================================ejercicio4=====================================================

procedure escribir_archivo_txt(var archivo_txt:texto; emp:empleado);
begin 
    with emp do begin 
        write(archivo_txt,
        'numero empleado: ', num_empleado,
        '|', 'nombre: ', nombre,
        '|', 'apellido: ', apellido,
        '|', 'edad: ', edad,
        '|', 'dni: ', dni);
    end;
    writeln(archivo_txt);
end;

// es lo mismo que pasar archivo a texto pero con un if 
procedure pasar_sin_dni_txt(var archivo_txt:texto; var archivo_binario:archivo_empleados; nombre_fisico_txt:string);
var 
    emp:empleado; 
    indice:integer;
    aux:string;
begin 
    indice := 0;
    // si el archivo ya existe, entonces cuento la cantidad de lineas/empleados que hay
    if (FileExists(nombre_fisico_txt)) then begin 
        reset(archivo_txt);
        while (not EOF(archivo_txt)) do begin 
            readln(archivo_txt,aux);
            inc(indice);
        end;

        // ya conte las lineas y lo cierro para abrirlo en modo append que agrega al final
        close(archivo_txt);
        append(archivo_txt);

    end else rewrite(archivo_txt);
    reset(archivo_binario);
    seek(archivo_binario, indice);

    // quizas esta mal porque dice "00" en vez de "0" asi que quizas deba ser un string
    while (not eof(archivo_binario)) do begin 
        read(archivo_binario, emp);
        if(emp.dni = 00) then begin
            escribir_archivo_txt(archivo_txt, emp);
        end;
    end;

    close(archivo_binario);
    close(archivo_txt);
end;

procedure pasar_a_archivo_txt(var archivo_txt:texto; var archivo_binario:archivo_empleados; nombre_fisico_txt:string);
var 
    emp:empleado; 
    indice:integer;
    aux:string;
begin 
    indice := 0;
    // si el archivo ya existe, entonces cuento la cantidad de lineas/empleados que hay
    if (FileExists(nombre_fisico_txt)) then begin 
        reset(archivo_txt);
        while (not EOF(archivo_txt)) do begin 
            readln(archivo_txt,aux);
            inc(indice);
        end;

        // ya conte las lineas y lo cierro para abrirlo en modo append que agrega al final
        close(archivo_txt);
        append(archivo_txt);

    end else rewrite(archivo_txt);

    //al empezar el programa crea el archivo binario asi que es bastante seguro que exista
    reset(archivo_binario);
    //la cantidad de lineas es uno mas que la cantidad de indices. 
    //asi que me puedo encontrar con EOF
    seek(archivo_binario, indice);

    // lee empleados del binario y los pasa al txt
    while (not eof(archivo_binario)) do begin 
        read(archivo_binario, emp);
        escribir_archivo_txt(archivo_txt, emp);
    end;

    close(archivo_binario);
    close(archivo_txt);
end;

// agarro un empleado a la mitad para chequear el agregar_empleado
procedure test_empleado(var archivo_binario:archivo_empleados; var emp:empleado);
begin 
    reset(archivo_binario);
    seek(archivo_binario, filesize(archivo_binario) div 2);
    read(archivo_binario, emp);
    close(archivo_binario);
end;

// se fija si el numero de empleado esta repetido y si no lo esta lo agrega
procedure buscar_agregar(var archivo_binario:archivo_empleados; nuevo_emp:empleado);
var 
    emp:empleado;
begin 
    reset(archivo_binario);
    while (not eof(archivo_binario)) do begin
        read(archivo_binario, emp);
        if (nuevo_emp.num_empleado = emp.num_empleado) then begin
            writeln('numero de empleado repetido');
            exit();
        end;
    end;
    write(archivo_binario, nuevo_emp);
    close(archivo_binario);
end;

procedure agregar_empleado(var archivo_binario:archivo_empleados);
var 
    emp:empleado;
    i:integer;
begin
    test_empleado(archivo_binario, emp);
    writeln('agregar empleados, escribir en el apellido "fin" para terminar');
    //leer_empleado() o modificar generar_empleado() para que ingrese por teclado
    buscar_agregar(archivo_binario, emp);
    for i := 1 to 10 do begin //while emp.apellido<>'fin'
        generar_empleado(emp);
        buscar_agregar(archivo_binario, emp);
    end;
end;

function modificar_empleado(var numero_empleado:integer; var edad:integer;var archivo_binario:archivo_empleados):boolean;
var 
    emp:empleado;
begin 
    reset(archivo_binario);
    while not eof(archivo_binario) do begin   
        read(archivo_binario, emp);
        if (emp.num_empleado = numero_empleado) then begin 
            // Se mueve un indice atras
            seek(archivo_binario, (filepos(archivo_binario) - 1));
            emp.edad := edad;
            // Escribe el nuevo empleado
            write(archivo_binario, emp);
            // Se va de la funcion
            exit(True);
        end;
    end;
    close(archivo_binario);
    exit(false);
end;    

procedure leer_y_modificar(var archivo_binario:archivo_empleados);
var 
    edad, num:integer;
begin 
    writeln('ingresar el numero de empleado: ');
    readln(num);
    writeln('ingresar la nueva edad'); //suponiendo que no sea un inc
    readln(edad);
    if (modificar_empleado(num, edad, archivo_binario)) then writeln('Se modifico el empleado correctamente')
    else writeln('No se pudo encontrar al empleado');
end;


procedure menu(var eleccion:integer);
begin 
    writeln('Elegir accion: ');
    writeln('1: listar empleados en base a un nombre o apellido');
    writeln('2: listar a todos los empleados');
    writeln('3: listar a los empleados con una edad mayor a 70');
    writeln('4: Agregar empleados'); 
    writeln('5: Modificar la edad de un empleado');
    writeln('6: Exportar el contenido del archivo a "todos_empleados.txt"');
    writeln('7: Exportar a "faltaDNIEmpleado.txt" a los empleados que no tengan dni cargado');
    writeln('8: Baja fisica con num empleado');
    writeln('0: cerrar');
    readln(eleccion);
end;

END.
