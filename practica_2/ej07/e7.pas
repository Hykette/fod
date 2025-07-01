program e7;

uses types, sysutils;

procedure leerM(var maestro:arch_maestro; var al:alumno);
begin 
    if (eof(maestro)) then al.codigo_alumno := valor_alto
    else read(maestro, al);
end;
procedure leer_cursada(var det1:arch_cursadas; var cursada:cursadas);
begin 
    if (eof(det1)) then cursada.codigo_alumno := valor_alto
    else read(det1, cursada);
end;
procedure leer_final(var det2:arch_finales; var final:finales);
begin 
    if (eof(det2)) then final.codigo_alumno := valor_alto
    else read(det2, final);
end;

function minimo(var det1:arch_cursadas; var det2:arch_finales; var cursada:cursadas; var final:finales):integer;
begin 
    if (cursada.codigo_alumno <= final.codigo_alumno) then begin 
        minimo := cursada.codigo_alumno;
        leer_cursada(det1, cursada);
    end else begin 
        minimo := final.codigo_alumno;
        leer_final(det2, final);
    end;
end;

procedure actualizar_maestro(var maestro:arch_maestro; var det1:arch_cursadas; var det2:arch_finales);
var 
    final:finales;
    cursada:cursadas;
    al:alumno;
    min:integer;
begin 
    reset(maestro);
    reset(det1);
    reset(det2);

    leerM(maestro, al);
    leer_cursada(det1, cursada);
    leer_final(det2, final);
    
    min := minimo(det1, det2, cursada, final);

    while (min <> valor_alto) do begin 

        while (al.codigo_alumno <> min) do leerM(maestro, al);

        while (cursada.codigo_alumno = al.codigo_alumno) do begin 
            if (cursada.resultado) then inc(al.cursadas_aprobadas);
            leer_cursada(det1, cursada);
        end;

        while (final.codigo_alumno = al.codigo_alumno) do begin 
            if (final.nota > 3) then inc(al.finales_aprobados);
            leer_final(det2, final);
        end;

        seek(maestro, filepos(maestro) - 1);
        write(maestro, al);

        min := minimo(det1, det2, cursada, final);

    end;

    close(maestro);
    close(det1);
    close(det2);
end;

procedure imprimir_maestro(var maestro:arch_maestro);
var 
    al:alumno;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(maestro, al);
        write(al.codigo_alumno, '|', al.cursadas_aprobadas, '|', al.finales_aprobados, '|');
    end;
    close(maestro);
end;

var 
    maestro:arch_maestro;
    det1:arch_cursadas;
    det2:arch_finales;
begin 
    assign(maestro, 'maestro.dat');
    assign(det1, 'detalle_cursadas.dat');
    assign(det2, 'detalle_finales.dat');
    
    actualizar_maestro(maestro, det1, det2);
    imprimir_maestro(maestro);
    //rewrite(maestro);
    //close(maestro);
end.