program e1;

uses types, sysutils, crt;

{
Modificar  el  ejercicio  4  de  la  práctica  1  (programa  de  gestión  de  empleados), 
agregándole una opción para realizar bajas copiando el último registro del archivo en 
la posición del registro a borrar y luego truncando el archivo en la posición del último 
registro de forma tal de evitar duplicados.
}
procedure baja(var maestro:archivo_empleados);
var 
    aux:empleado; indice, num_empleado:integer; 
begin 
    writeln('Numero de empleado a eliminar: ');
    readln(num_empleado);
    if (num_empleado < 0) then exit();

    reset(maestro);
    leer_empleado(maestro, aux);
    while ((aux.num_empleado <> valor_alto) and (num_empleado <> aux.num_empleado)) do begin 
        leer_empleado(maestro, aux);
    end;
    if (aux.num_empleado = num_empleado) then begin 
        // guarda el indice y lee el ultimo registro
        indice := filepos(maestro) - 1;
        seek(maestro, filesize(maestro) - 1);
        read(maestro, aux);

        // vuelve al indice a escribir el ultimo registro
        seek(maestro, indice);
        write(maestro, aux);

        // va al ultimo registro y escribe EOF
        seek(maestro, filesize(maestro) - 1);
        truncate(maestro);
    end else begin 
        writeln('no se encontro el empleado con el numero: ', num_empleado);
    end;
    close(maestro);
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
            0: exit();
            1: buscar_empleado(archivo_binario);
            2: imprimir_archivo(archivo_binario);
            3: mayor_70(archivo_binario);
            4: agregar_empleado(archivo_binario);
            5: leer_y_modificar(archivo_binario);
            6: pasar_a_archivo_txt(archivo_txt, archivo_binario, nombre_fisico_txt);
            7: pasar_sin_dni_txt(archivo_txt_dni, archivo_binario, nombre_fisico_txt_dni);
            8: baja(archivo_binario);
            else writeln('esa eleccion no esta en el menu');
        end;
        menu(eleccion);
    end;
end. 