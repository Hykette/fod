program e13;

uses types;

// esta re mal esto, creo que es mas facil preguntar en cada registro si hay que actualizarlo o no y si no escribir en el txt
procedure actualizar_e_informar(var arch_mov:arch_movimientos; var arch_cor:arch_correos; var txt:text);
var 
    movs:movimientos;
    correo:correos;
begin 
    reset(arch_mov);
    reset(arch_cor);
    rewrite(txt);
    leer_correo(arch_cor, correo);
    leer_movimientos(arch_mov, movs);

    while ((movs.id <> valor_alto) or (correo.id <> valor_alto)) do begin 

        while ((movs.id <> valor_alto) and (movs.id <> correo.id)) do begin 
            writeln(txt, movs.id, '          ', movs.cant_mails_enviados);
            leer_movimientos(arch_mov, movs);
        end;

        while ((correo.id <> valor_alto) and (correo.id = movs.id)) do begin 
            inc(movs.cant_mails_enviados);
            leer_correo(arch_cor, correo);
        end;

        // aca escribe otra vez el txt
        if (movs.id <> valor_alto) then begin 
            seek(arch_mov, filepos(arch_mov) - 1);
            write(arch_mov, movs);
            writeln(txt, movs.id, '          ', movs.cant_mails_enviados);
            leer_movimientos(arch_mov, movs);
        end;

    end;

    close(arch_cor);
    close(arch_mov);
    close(txt);
end;

procedure imprimir_movimientos(var arch:arch_movimientos);
var 
    mov:movimientos;
begin 
    reset(arch);
    while (not eof(arch)) do begin 
        read(arch, mov);
        writeln(mov.id, '|', mov.cant_mails_enviados);
    end;
    close(arch);
end;

var 
    movs: arch_movimientos;
    cor: arch_correos;
    txt: text;
begin 
    assign(movs, './var/log/logmail.dat');
    assign(txt, './var/log/logmail.txt');
    assign(cor, './var/mails/mails.dat');
    actualizar_e_informar(movs, cor, txt);
    imprimir_movimientos(movs);
end.