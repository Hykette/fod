{Agregar al menú del programa del ejercicio 3, opciones para:
 a. Añadir uno o más empleados al final del archivo con sus datos ingresados por
 teclado. Tener en cuenta que no se debe agregar al archivo un empleado con
 un número de empleado ya registrado (control de unicidad).
 b. Modificar la edad de un empleado dado.
 c. Exportar el contenido del archivo a un archivo de texto llamado
 “todos_empleados.txt”.
 d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
 que no tengan cargado el DNI (DNI en 00).
NOTA: Las búsquedas deben realizarse por número de empleado.}
program e4;
uses parte_del_e3, crt, SysUtils;

type
    texto = TextFile;


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
    writeln('0: cerrar');
    readln(eleccion);
end;

var 
    eleccion:integer;

    nombre_fisico_binario:string;
    nombre_fisico_txt:string;
    nombre_fisico_txt_dni:string;

    archivo_binario:archivo_empleados;
    archivo_txt:texto;
    archivo_txt_dni:texto;

begin 
    TextColor(GREEN);
    randomize;
    eleccion := -1;
    nombre_fisico_binario := 'empleados.dat'; //se puede cambiar por readln
    nombre_fisico_txt := 'todos_empleados.txt';
    nombre_fisico_txt_dni := 'faltaDNIEmpleado.txt';
    
    assign(archivo_binario, nombre_fisico_binario);
    assign(archivo_txt, nombre_fisico_txt);
    assign(archivo_txt_dni, nombre_fisico_txt_dni);
    
    if (not FileExists(nombre_fisico_binario)) then generar_archivo(archivo_binario);

    menu(eleccion);
    while (eleccion <> 0) do begin 
        case eleccion of
            1: buscar_empleado(archivo_binario);
            2: imprimir_archivo(archivo_binario);
            3: mayor_70(archivo_binario);
            4: agregar_empleado(archivo_binario);
            5: leer_y_modificar(archivo_binario);
            6: pasar_a_archivo_txt(archivo_txt, archivo_binario, nombre_fisico_txt);
            7: pasar_sin_dni_txt(archivo_txt_dni, archivo_binario, nombre_fisico_txt_dni);
            else writeln('esa eleccion no esta en el menu');
        end;
        menu(eleccion);
    end;
end. 