program e3;

uses types, sysutils;

procedure eliminar_novela(var maestro:arch_maestro);
var 
    nov:novela;
    aux:novela;
    id:integer;

    indice:integer;

begin 
    reset(maestro);
    writeln('id de novela a eliminar:');
    readln(id);
    
    leer_maestro(maestro, nov);
    while ((nov.id <> valor_alto) and (nov.id <> id)) do leer_maestro(maestro, nov);
    
    if ((nov.id = id) and (not borrado(nov.genero[1]))) then begin 
        writeln('encontrado');
        // guarda el indice y va al maestro
        indice := filepos(maestro) -1;
        // borra logicamente y guarda el indice
        seek(maestro, 0);
        read(maestro, aux);

        // intercambia los indices de la cabecera y el nuevo registro
        if (indice_de(aux.genero) > -1) then nov.genero := IntToStr(indice_de(aux.genero)) + '@' + nov.genero
        else nov.genero :=  '@' + nov.genero;

        nuevo_indice(aux.genero, indice);

        // escribe ambos registros modificados en el maestro
        seek(maestro, 0);
        write(maestro, aux);
        seek(maestro, indice);
        write(maestro, nov);

    end else 
        writeln('No se pudo encontrar la novela con esa id');

    close(maestro);
end;

procedure agregar_novela(var maestro:arch_maestro);
var 
    nov:novela;
    recorrer:integer;
    aux:novela;
begin 
    reset(maestro);
    nueva_novela(maestro, nov);
    read(maestro, aux);

    recorrer := indice_de(aux.genero);
    writeln(recorrer);
    if (recorrer = -1) then begin 
        // si no hay lista entonces escribe al final
        seek(maestro, filesize(maestro));
        write(maestro, nov);
    end else begin 

        seek(maestro, recorrer);
        read(maestro, aux);
        recorrer := indice_de(aux.genero);
        writeln(recorrer);
        // haya mas o no, tiene que escribirlo ahi
        seek(maestro, filepos(maestro) - 1);
        write(maestro, nov);

        // para perservar el dato del resto del registro
        seek(maestro, 0);
        read(maestro, aux);
        if (recorrer = -1) then aux.genero := '@' else aux.genero := IntToStr(recorrer) + '@';
        seek(maestro, 0);
        write(maestro, aux);
    end;
    close(maestro);
end;

procedure imprimir_novelas(var maestro:arch_maestro);
var 
    nov:novela;
begin 
    //el primer regsitro necesita un trato especial
    reset(maestro);
    while (not eof(maestro)) do begin
        read(maestro, nov);
        if (not borrado(nov.genero[1])) then writeln(nov.id, '|', nov.genero);
    end;
    close(maestro);
end;

procedure pasar_txt(var maestro:arch_maestro; var txt:text);
var 
    nov:novela;
begin 
    reset(maestro);
    rewrite(txt);
    while (not eof(maestro)) do begin 
        read(maestro, nov);
        writeln(txt, nov.id, ' ', nov.genero);
    end;
    close(maestro);
    close(txt);
end;

procedure modificar_novela(var maestro:arch_maestro);
var 
    nov:novela;
    id:integer;
begin 
    reset(maestro);
    leer_maestro(maestro, nov);
    writeln('id de novela a modificar:' );
    readln(id);
    while ((not borrado(nov.genero[1])) and (nov.id <> id) and (nov.id <> valor_alto)) do leer_maestro(maestro, nov);

    if ((not borrado(nov.genero[1])) and (nov.id = id)) then begin 
        writeln('dato a modificar: 1[genero] 2[nombre] 3[duracion] 4[director] 5[precio]');
        readln(id);
        case id of 
            1: readln(nov.genero);
            2: readln(nov.nombre);
            3: readln(nov.duracion);
            4: readln(nov.director);
            5: readln(nov.precio);
            else writeln('opcion no detectada');
        end;

        seek(maestro, filepos(maestro) - 1);
        write(maestro, nov);

    end else writeln('novela no encontrada');

    close(maestro);
end;


var 
    maestro:arch_maestro;
    eleccion:integer;
    txt:text;
begin 
    assign(maestro, 'maestro.dat');
    assign(txt, 'novelas.txt');
    menu(eleccion);
    while (eleccion <> 0) do begin 
        case eleccion of 
            1: agregar_novela(maestro);
            2: modificar_novela(maestro);
            3: eliminar_novela(maestro);
            4: pasar_txt(maestro, txt);
            5: imprimir_novelas(maestro);
            0: exit();
            else writeln('Esa eleccion no esta en el menu');
        end;
        menu(eleccion);
    end;
end.
        

