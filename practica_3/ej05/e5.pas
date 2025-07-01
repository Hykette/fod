program e5;

uses types;

procedure borrar_flor(var maestro:arch_maestro; f:flor);
var 
    aux:flor;
    indice:integer;
begin 
    reset(maestro);
    leer_maestro(maestro, aux);
    while ((aux.codigo <> valor_alto) and (((aux.codigo <> f.codigo) or (aux.nombre <> f.nombre)))) do leer_maestro(maestro, aux); 

    if ((aux.codigo = f.codigo) and (aux.nombre = f.nombre)) then begin 
        indice := filepos(maestro) - 1;
        seek(maestro, 0);
        read(maestro, aux);
        f.codigo := aux.codigo;
        aux.codigo := indice * -1;
        seek(maestro, 0);
        write(maestro, aux);
        seek(maestro, indice);
        write(maestro, f);
    end else writeln('flor no encontrada');
    close(maestro);
end;

var 
    maestro:arch_maestro;
    eleccion:integer;
    f:flor;
begin 
    
    assign(maestro, 'maestro.dat');
    writeln('1.borrar 2.agregar 3.imprimir 4.listar_existentes 5.borrar flor especifica 0.cerrar');
    readln(eleccion);
    while (eleccion <> 0) do begin 
        case eleccion of 
            1: borrar_registro(maestro);
            2: agregar_flor(maestro);
            3: imprimir_maestro(maestro);
            4: imprimir_maestro_sin_borrados(maestro);
            5:  begin 
                    writeln('codigo de la flor y nombre');
                    readln(f.codigo);
                    readln(f.nombre);
                    borrar_flor(maestro, f);
                end;
            0: exit();
            else writeln('?');
        end;
        writeln('1.borrar 2.agregar 3.imprimir 4.listar_existentes 5.borrar flor especifica 0.cerrar');
        readln(eleccion);
    end;
end.