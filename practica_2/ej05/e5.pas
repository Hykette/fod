program e5;

uses types, sysutils;

function registro_minimo(vec_logs:vector_logs):integer;
var
    i:integer;
    minimo_codigo:integer;
    minimo_fecha:integer;
    indice:integer;
begin 
    minimo_codigo := valor_alto;
    minimo_fecha := valor_alto;
    
    for i:=1 to dimF do begin 
        if ((vec_logs[i].codigo < minimo_codigo) or 
        ((vec_logs[i].codigo = minimo_codigo) and (vec_logs[i].fecha < minimo_fecha))) then begin 
            minimo_codigo := vec_logs[i].codigo;
            minimo_fecha := vec_logs[i].fecha;
            indice := i;
        end;
    end;
    
    registro_minimo := indice;
end;

procedure minimo(var vector_detalles:detalles; var vec_logs:vector_logs; var min:logins);
var 
    i:integer;
begin 
    i := registro_minimo(vec_logs);
    min := vec_logs[i];
    leerD(vector_detalles[i], vec_logs[i]);
end;

procedure leer_detalles(var vec_detalles:detalles; var vec_logs:vector_logs);
var 
    i:integer;
begin 
    for i:=1 to dimF do begin 
        reset(vec_detalles[i]);
        leerD(vec_detalles[i], vec_logs[i]);
    end;
end;
procedure cerrar_detalles(var vec_detalles:detalles);
var 
    i:integer;
begin 
    for i:=1 to dimF do begin 
        close(vec_detalles[i]);
    end;
end;
procedure merge(var maestro:arch_maestro; var vec_detalles:detalles);
var 
    res:resumen;
    logs:vector_logs;
    min:logins;
begin 
    rewrite(maestro);
    leer_detalles(vec_detalles, logs);

    minimo(vec_detalles, logs, min);

    while (min.codigo <> valor_alto) do begin 
        res.codigo := min.codigo;
        while ((min.codigo = res.codigo) and (min.codigo <> valor_alto)) do begin 

            res.fecha := min.fecha;
            while ((res.fecha = min.fecha) and (res.codigo = min.codigo)) do begin 
                res.tiempo_total := res.tiempo_total + min.tiempo_sesion;
                
                minimo(vec_detalles, logs, min);
            end;
            write(maestro, res);
        end;
    end;
    close(maestro);
    cerrar_detalles(vec_detalles);
end;
procedure imprimir_maestro(var maestro:arch_maestro);
var
    res:resumen; aux:integer;
begin 
    reset(maestro);
    leerM(maestro, res);
    while (res.codigo <> valor_alto) do begin 
        with res do begin 
            aux := codigo;
            writeln('codigo: ', codigo);
            while ((aux = codigo) and (res.codigo <> valor_alto)) do begin 
                write('|', fecha, '| Tiempo total: ', tiempo_total:0:2, '|');
                leerM(maestro, res);
            end;
            writeln();
        end;
    end;
    close(maestro);
end;

var 
    maestro:arch_maestro;
    vec_detalles:detalles;
    path_detalle:string;
    nombre_fisico_detalle:string;
    i:integer;
begin
    assign(maestro, './var/log/maestro.dat');
    path_detalle := './var/detalles/detalle'; // + i.dat
    for i:=1 to dimF do begin 
        nombre_fisico_detalle := path_detalle + IntToStr(i) + '.dat';
        assign(vec_detalles[i], nombre_fisico_detalle);
    end;
    merge(maestro, vec_detalles);
    imprimir_maestro(maestro);
end.