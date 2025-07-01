program e2;

uses types;

procedure baja_logica(var maestro:arch_maestro);
var 
    aux_string:string;
    num:longint;
    caracteristica:string;
    asistente:asistentes;
begin 
    caracteristica := '@';
    reset(maestro);
    while ((not eof(maestro))) do begin 
        read(maestro, asistente);
        if (asistente.id < 1000) then begin 
            aux_string := asistente.apellido;
            asistente.apellido := caracteristica + aux_string; 
            seek(maestro, filepos(maestro) - 1);
            write(maestro, asistente);
        end;
    end;
    close(maestro);
end;

procedure imprimir_maestro(var maestro:arch_maestro);
var 
    asistente:asistentes;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(maestro, asistente);
        if (asistente.apellido[1] = '@') then write('@', '|') 
        else write(asistente.id, '|');
    end;
    close(maestro);
end;

var 
    maestro:arch_maestro;
begin 
    assign(maestro, 'maestro.dat');
    baja_logica(maestro);
    imprimir_maestro(maestro);
end.