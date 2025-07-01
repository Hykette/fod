program generar_archivo;
uses types;
procedure generar_archivo(var arch:archivo);
var 
    acceso:accesos; 
    i, j, k, l:integer;
begin 
    rewrite(arch);
    for i:=1 to 6 do begin 
        acceso.anio := i + 2020;
        for j:=1 to 12 do begin 
            acceso.mes := j;
            for k:=1 to 30 do begin 
                acceso.dia := k;
                for l:=1 to 10 do begin
                    acceso.id := l;
                    acceso.tiempo := random(23) + (1 / (random(10) + 1));
                    write(arch, acceso);
                end;
            end;
        end;
    end;
    close(arch);
end;

procedure imprimir_archivo(var arch:archivo);
var 
    acceso:accesos;
begin 
    reset(arch);
    while (not eof(arch)) do begin 
        read(arch, acceso);
        writeln(acceso.anio, '|', acceso.mes, '|', acceso.dia, '|', acceso.id);
    end;
    close(arch);
end;

var 
    arch:archivo;
begin 
    assign(arch, 'archivo.dat');
    generar_archivo(arch);
    imprimir_archivo(arch);
end.
    