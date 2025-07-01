program e7;

uses types;

procedure truncar_varias(var maestro:arch_maestro);
var
    ave:aves;
    aux:aves;
    indice:integer;
begin 
    reset(maestro);
    leer_maestro(maestro, ave); //cabecera
    leer_maestro(maestro, ave);

    while (ave.codigo <> valor_alto) do begin 

        if (borrado(ave)) then begin 
            indice := filepos(maestro) - 1;
            seek(maestro, filesize(maestro) - 1);
            read(maestro, aux);
            seek(maestro, filepos(maestro) -1);
            truncate(maestro);

            if (borrado(aux)) then seek(maestro, filepos(maestro) - 1) 
            else begin 
                seek(maestro, indice);
                write(maestro, aux);
            end;
        end;
        leer_maestro(maestro, ave); 
    end;
    
    close(maestro);
end;

procedure truncar_una(var maestro:arch_maestro);
var 
    ave:aves;
    aux:aves;
    indice:integer;
    pos:integer;
begin 
    reset(maestro);
    pos := filesize(maestro) - 1;
    read(maestro, ave);

    if (ave.codigo = 0) then exit();

    while ((ave.codigo < 0) and (pos > 0)) do begin
        seek(maestro, (ave.codigo) * -1);
        indice := filepos(maestro);
        read(maestro, ave);
        
        //busca con cual reemplazarlo
        seek(maestro, pos);
        read(maestro, aux); 
           
        while ((aux.codigo <= 0) and (pos <> 0) and (pos >= indice)) do begin 
            //mientras los que estan en pos esten borrados y no llege a la cabecera
            dec(pos);
            seek(maestro, pos);
            read(maestro, aux);
        end;
        
        if (pos > indice) then begin 

            seek(maestro, filepos(maestro) -1);
            write(maestro, ave);

            seek(maestro, indice);
            write(maestro, aux);

        end;
    end;
    
    seek(maestro, (pos + 1));
    truncate(maestro);

    seek(maestro, 0);
    read(maestro, ave);
    ave.codigo := 0;
    seek(maestro, 0);
    write(maestro, ave);
    close(maestro);

    writeln('ULTIMO INDICE TERMINO SIENDO:', pos);
end;

{else seek(maestro, 0) truncate(maestro)}
procedure eliminar_ave(var maestro:arch_maestro);
var 
    ave:aves;
    aux:aves;
    indice:integer;
    id:integer;
begin 
    writeln('codigo del ave extinta del todo:');
    readln(id);
    reset(maestro);
    leer_maestro(maestro, ave);

    while ((ave.codigo <> valor_alto) and (ave.codigo <> id)) do leer_maestro(maestro, ave);

    if (ave.codigo = id) then begin 
        indice := filepos(maestro) - 1;
        seek(maestro, 0);
        read(maestro, aux);

        ave.codigo := aux.codigo;
        aux.codigo := indice * -1;
        
        seek(maestro, 0);
        write(maestro, aux);
        seek(maestro, indice);
        write(maestro, ave);
    
    end else writeln('quizas ya esta extinta');

    close(maestro);
end;

var 
    maestro:arch_maestro;
    eleccion:integer;
begin 
    assign(maestro, 'maestro.dat');
    writeln('0.terminar 1.eliminar 2.imprimir 3.truncar'); //truncar_varias(maestro);
    read(eleccion);
    while (eleccion <> 0) do begin 
        case eleccion of 
            1: eliminar_ave(maestro);
            2: imprimir_aves(maestro);
            3: truncar_una(maestro);
            0:exit();
            else writeln('?');
        end;
        writeln('0.terminar 1.eliminar 2.imprimir 3.truncar');
        read(eleccion);
    end;
    imprimir_aves(maestro);
end.
