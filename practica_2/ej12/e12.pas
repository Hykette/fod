program e12;

uses types;

procedure informar(var arch:archivo; var anio_x:integer);
var 
    acceso:accesos;
    info:informe;
begin 
    reset(arch);
    leer_archivo(arch, acceso);
    info.tiempo_anio := 0;
    info.anio := anio_x;
    
    while ((acceso.anio <> anio_x) and (acceso.anio <> valor_alto)) do leer_archivo(arch, acceso);
    if (acceso.anio = info.anio) then writeln('Año: ', info.anio) else writeln('Año no encontrado');
    while (info.anio = acceso.anio) do begin 
        
        info.mes := acceso.mes;
        info.tiempo_mes := 0;
        writeln('   Mes: ', info.mes);
        while ((info.anio = acceso.anio) and (info.mes = acceso.mes)) do begin 
            info.dia := acceso.dia;
            info.tiempo_dia := 0;
            writeln('       dia: ', info.dia);
            while ((info.anio = acceso.anio) and (info.mes = acceso.mes) and (info.dia = acceso.dia)) do begin 
                info.id := acceso.id;
                write('            id Usuario:', info.id);
                while ((info.anio = acceso.anio) and (info.mes = acceso.mes) and (info.dia = acceso.dia) and (info.id = acceso.id)) do begin 
                    info.tiempo_dia := info.tiempo_dia + acceso.tiempo;
                    writeln('    ', acceso.tiempo:0:2);
                    leer_archivo(arch, acceso);
                end;
            end;
            info.tiempo_mes := info.tiempo_mes + info.tiempo_dia;
            writeln('======================================');
            writeln('        Tiempo total del dia: ', info.tiempo_dia:0:2);
        end;
        info.tiempo_anio := info.tiempo_anio + info.tiempo_mes;
        writeln('   Tiempo total del mes: ', info.tiempo_mes:0:2);
    end;
    if (info.tiempo_anio > 0) then writeln('Tiempo Total Año: ', info.tiempo_anio:0:2);

    close(arch);
end;

var 
    arch:archivo; i:integer;
begin 
    i := 2026;
    assign(arch, 'archivo.dat');
    informar(arch, i);
end.
