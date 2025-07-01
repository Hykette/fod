program generar_archivos;

uses types, sysutils;

procedure generar_archivos(var vec_detalles:vector_detalles);
var 
    caso:casos;
    i, j, k:integer;
    veces:integer;
begin 
    for i:=1 to dimF do begin 
        rewrite(vec_detalles[i]);
        caso.codigo_localidad := i;

        for j:=1 to cepas_totales do begin 
            caso.codigo_cepa := j;
            veces := random(10) + 1; //veces por cepa
            with caso do begin
                for k:=1 to veces do begin 
                    casos_activos := random(1000) + 1000;
                    casos_nuevos := random(1000) + 100;
                    recuperados := random(500) + 100;
                    fallecidos := random(500) + 100;
                    write(vec_detalles[i], caso);
                end;

            end;
        end;

        close(vec_detalles[i]);
    end;
end;

procedure generar_maestro(var maestro:arch_maestro);
var 
    res:resumen;
    i, j:integer;
begin 
    rewrite(maestro);
    with res do begin 
        for i:=1 to dimF do begin 
            res.codigo_localidad := i;
            res.nombre_localidad := generar_string();
            for j:=1 to cepas_totales do begin
                res.codigo_cepa := j;
                res.nombre_cepa := generar_string();
                casos_activos := 0;
                casos_nuevos := 0;
                recuperados := 0;
                fallecidos := 0;
                write(maestro, res);
            end;
        end;
    end;
    close(maestro);
end;

procedure imprimir_maestro(var maestro:arch_maestro);
var 
    res:resumen;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(maestro, res);
        write(res.codigo_localidad, ' ', res.codigo_cepa, '| ');
    end;
    close(maestro);
end;


function registro_minimo(var vec_casos:vector_casos):integer;
var 
    i:integer;
    localidad_minimo:integer;
    cepa_minimo:integer;
    indice:integer;
begin 
    localidad_minimo := valor_alto;
    cepa_minimo := valor_alto;
    for i:=1 to dimF do begin 
        if ((vec_casos[i].codigo_localidad < localidad_Minimo) or 
        ((vec_casos[i].codigo_localidad = localidad_minimo) and (vec_casos[i].codigo_cepa < cepa_minimo))) then begin 

            localidad_minimo := vec_casos[i].codigo_localidad;
            cepa_minimo := vec_casos[i].codigo_cepa;
            indice := i;
        end;
    end;
    registro_minimo := indice;
end;
procedure minimo(var vec_detalles:vector_detalles; var vec_casos:vector_casos; var min:casos);
var 
    i:integer;
begin 
    i := registro_minimo(vec_casos);
    min := vec_casos[i];
    leerD(vec_detalles[i], vec_casos[i]);
end;

procedure imprimir_detalles(var vec_detalles:vector_detalles);
var 
    min:casos;
    vec_casos:vector_casos;
    i:integer;
    aux:casos;
begin 
    for i:=1 to dimF do begin 
        reset(vec_detalles[i]);
        leerD(vec_detalles[i], vec_casos[i]);
    end;
    minimo(vec_detalles, vec_casos, min);

    while (min.codigo_localidad <> valor_alto) do begin 
        aux.codigo_localidad := min.codigo_localidad;
        writeln('localidad: ', aux.codigo_localidad);

        while (min.codigo_localidad = aux.codigo_localidad) do begin 
            aux.codigo_cepa := min.codigo_cepa;
            write('cepa:', aux.codigo_cepa, ' |');
            while ((min.codigo_localidad = aux.codigo_localidad) and (min.codigo_cepa = aux.codigo_cepa)) do begin 
                write(min.casos_activos, ' |');
                minimo(vec_detalles, vec_casos, min);
            end;
            writeln();
        end;
        writeln();
        writeln();
    end;
    for i:=1 to dimF do begin 
        close(vec_detalles[i]);
    end;
end;

procedure generar_detalles_vacios(var vec_detalles:vector_detalles);
var 
    i:integer;
begin 
    for i:=1 to dimF do begin   
        rewrite(vec_detalles[i]);
        close(vec_detalles[i]);
    end;
end;

var
    detalles:vector_detalles;
    path:string;
    nombre_fisico:string;
    i:integer;
    maestro:arch_maestro;
begin 
    assign(maestro, 'maestro.dat');
    path := './detalles/detalle'; //i.dat
    for i:=1 to dimF do begin 
        nombre_fisico := path + IntToStr(i) + '.dat';
        assign(detalles[i], nombre_fisico);
    end;

    generar_archivos(detalles);

    //generar_detalles_vacios(detalles);
    generar_maestro(maestro);
    
    imprimir_detalles(detalles);
    imprimir_maestro(maestro);
end.