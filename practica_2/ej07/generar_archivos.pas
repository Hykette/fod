program generar_archivos;

uses types, sysutils;

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

procedure generar_cursada(var cursada:cursadas);
begin 
    with cursada do begin 
        anio_cursada := random(10) + 2025;
        resultado := random(2) = 1;
    end;
end;

procedure generar_final(var final:finales);
begin 
    with final do begin 
        fecha := random(12) + 1;
        nota := random(10) + 1;
    end;
end;

// Con esta logica todas las cursadas son libres, puede aprobar la 10 sin haber aprobado de la 1 a la 9       
procedure generar_detalles(var detalle_cursada:arch_cursadas; var detalle_final:arch_finales);
var
    cursada:cursadas;
    final:finales;
    i, j, k, veces:integer;
begin 
    rewrite(detalle_final);
    rewrite(detalle_cursada);

    for i:=1 to 10 do begin //alumno
        cursada.codigo_alumno := i;
        final.codigo_alumno := i;
        
        for j:=1 to 10 do begin //materia
            cursada.codigo_materia := j;
            final.codigo_materia := j;
            generar_cursada(cursada);
            generar_final(final);
            write(detalle_cursada, cursada);
            write(detalle_final, final);
            veces := random(10) + 1;
            for k:=1 to veces do begin 
                if ((cursada.resultado) and (final.nota >= 4)) then break 
                else if (not cursada.resultado) then begin 
                    generar_cursada(cursada);
                    write(detalle_cursada, cursada);
                end else begin 
                    generar_final(final);
                    write(detalle_final, final);
                    if ((final.nota >= 4) and (not cursada.resultado)) then begin 
                        cursada.resultado := true;
                        write(detalle_cursada, cursada);
                    end;
                end;
            end;
        end;
    end;
    close(detalle_final);
    close(detalle_cursada);
end;

procedure imprimir_cursadas(var detalle_cursada:arch_cursadas);
var 
    cursada:cursadas;
begin 
    reset(detalle_cursada);
    while (not eof(detalle_cursada)) do begin 
        read(detalle_cursada, cursada);
        write(cursada.codigo_alumno, '|',cursada.codigo_materia, '|', cursada.resultado, '  |');
    end;
    close(detalle_cursada);
    writeln();
end;
procedure imprimir_finales(var detalle_final:arch_finales);
var 
    final:finales;
begin 
    reset(detalle_final);
    while (not eof(detalle_final)) do begin 
        read(detalle_final, final);
        write(final.codigo_alumno, '|', final.codigo_materia, '|', final.nota, ' |');
    end;
    close(detalle_final);
    writeln();
end;
procedure generar_maestro(var maestro:arch_maestro);
var     
    i:integer;
    al:alumno;
begin 
    rewrite(maestro);
    for i:=1 to 10 do begin 
        with al do begin 
            codigo_alumno := i;
            cursadas_aprobadas := 0;
            finales_aprobados := 0;
            apellido := generar_string();
            nombre := generar_string();
        end;
        write(maestro, al);
    end;
    close(maestro);
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
    detalle_cursada:arch_cursadas;
    detalle_final:arch_finales;
    maestro:arch_maestro;
begin 
    assign(maestro, 'maestro.dat');
    assign(detalle_cursada, 'detalle_cursadas.dat');
    assign(detalle_final, 'detalle_finales.dat');
    generar_detalles(detalle_cursada, detalle_final);
    imprimir_cursadas(detalle_cursada);
    writeln();
    imprimir_finales(detalle_final);
    generar_maestro(maestro);
    writeln();
    imprimir_maestro(maestro);
end.


            
                


