program e4;

uses types;

procedure borrar_registro(var maestro:arch_maestro);
var
    f:flor;
    aux:flor;
    id:integer;
    indice:integer;
begin 
    // hacer como en el agregar
    writeln('id flor a borrar');
    readln(id);

    reset(maestro);
    leer_maestro(maestro, f);
    while ((f.codigo <> valor_alto) and (f.codigo <> id)) do leer_maestro(maestro, f);
    if (f.codigo = id) then begin  
        // guarda el indice y va al maestro
        indice := filepos(maestro) -1;
        seek(maestro, 0);
        read(maestro, aux);
        
        // intercambia los codigos(indices) entre el maestro y el nuevo registro a borrar
        f.codigo := aux.codigo;
        aux.codigo := indice * -1;

        // escribe en la cabecera el nuevo indice
        seek(maestro, 0);
        write(maestro, aux);

        //vuelve al indice a borrar logicamente
        seek(maestro, indice);
        write(maestro, f);
        
    end else writeln('no encontrada');
    close(maestro);
end;

procedure agregar_flor(var maestro:arch_maestro);
var 
    nueva_flor, f:flor;
    recorrer:integer;
begin 
    nueva_flor.codigo := random(100) + 1;
    nueva_flor.nombre := generar_string();
    reset(maestro);
    read(maestro, f);
    if (f.codigo >= 0) then begin 
        seek(maestro, filesize(maestro));
        write(maestro, nueva_flor); 
    end else begin 
        recorrer := f.codigo * -1;
        seek(maestro, recorrer);
        read(maestro, f);
        seek(maestro, filepos(maestro) - 1);

        write(maestro, nueva_flor);
        f.nombre := '';
        if (f.codigo > 0) then f.codigo := 0;

        seek(maestro, 0);
        write(maestro, f);
    end;
    close(maestro);
end;

procedure imprimir_maestro(var maestro:arch_maestro);
var 
    f:flor;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(maestro, f);
        write(f.codigo, '|');
    end;
    close(maestro);
    writeln();
end;

procedure imprimir_maestro_sin_borrados(var maestro:arch_maestro);
var 
    f:flor;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(Maestro, f);
        if (not borrado(f.codigo)) then write(f.codigo, '|');
    end;
    writeln();
    close(maestro);
end;

var 
    maestro:arch_maestro;
    eleccion:integer;
begin 
    assign(maestro, 'maestro.dat');
    writeln('1.borrar 2.agregar 3.imprimir 4.listar_existentes 0.cerrar');
    readln(eleccion);
    while (eleccion <> 0) do begin 
        case eleccion of 
            1: borrar_registro(maestro);
            2: agregar_flor(maestro);
            3: imprimir_maestro(maestro);
            4: imprimir_maestro_sin_borrados(maestro);
            0: exit();
            else writeln('?');
        end;
        writeln('1.borrar 2.agregar 3.imprimir 4.listar_existentes 0.cerrar');
        readln(eleccion);
    end;
end.