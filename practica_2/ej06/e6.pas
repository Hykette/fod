program e6;

uses sysutils, types;

function registro_minimo(vec_casos:vector_casos):integer;
var 
    i:integer;
    localidad_minimo:integer;
    cepa_minimo:integer;
    indice:integer;
begin 
    //no hay problema con no inicializar el indice porque va a buscar uno valor_alto y fecha minimo
    cepa_minimo := valor_alto;
    localidad_minimo := valor_alto;
    for i:=1 to dimF do begin 
        if ((vec_casos[i].codigo_localidad < localidad_minimo) or 
        ((vec_casos[i].codigo_localidad = localidad_minimo) and (vec_casos[i].codigo_cepa <= cepa_minimo))) then begin 
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
    i:= registro_minimo(vec_casos);
    min := vec_casos[i];
    leerD(vec_detalles[i], vec_casos[i]);
end;

procedure cerrar_archivos(var maestro:arch_maestro; var vec_detalles:vector_detalles);
var 
    i:integer;
begin 
    close(maestro);
    for i:=1 to dimF do begin   
        close(vec_detalles[i]);
    end;
end;

procedure actualizar_maestro (var maestro:arch_maestro; var vec_detalles:vector_detalles);
var 
    i:integer;
    vec_casos:vector_casos;
    min:casos;
    res:resumen;
    cantidad:integer;
    casos_activos:longint;
    codigo:integer;
begin 
    cantidad := 0;
    casos_activos := 0;
    for i:=1 to dimF do begin 
        reset(vec_detalles[i]);
        leerD(vec_detalles[i], vec_casos[i]);
    end;
    reset(maestro);

    minimo(vec_detalles, vec_casos, min);
    leerM(maestro, res);

    while ((min.codigo_localidad <> valor_alto) or (res.codigo_localidad <> valor_alto)) do begin 

        while ((res.codigo_localidad <> min.codigo_localidad) and (res.codigo_localidad <> valor_alto)) do begin 
            codigo := res.codigo_localidad; 
            casos_activos := 0;

            while ((res.codigo_localidad = codigo) and (res.codigo_localidad <> valor_alto)) do begin 
                casos_activos := casos_activos + res.casos_activos;
                leerM(maestro, res);
            end;

            if (casos_activos > 50) then inc(cantidad);
        end;

        casos_activos := 0;
        codigo := res.codigo_localidad;

        while ((min.codigo_localidad = codigo) and (res.codigo_localidad = codigo) and (res.codigo_localidad <> valor_alto)) do begin 

            while ((res.codigo_localidad = min.codigo_localidad) and (res.codigo_localidad = codigo) and (min.codigo_cepa = res.codigo_cepa)) do begin  
                res.casos_activos := res.casos_activos + min.casos_activos; //no se resta?
                res.casos_nuevos := res.casos_nuevos + min.casos_nuevos;
                res.fallecidos := res.fallecidos + min.fallecidos;
                res.recuperados := res.recuperados + min.recuperados;
                minimo(vec_detalles, vec_casos, min);
            end;
            
            casos_activos := casos_activos + res.casos_activos;
            
            seek(maestro, filePos(maestro) - 1);
            write(maestro, res);
            leerM(maestro, res);

        end;
        

        if (casos_activos > 50) then inc(cantidad);

    end;

    writeln('Cantidad de provincias con mas de 50 casos activos: ', cantidad);
    cerrar_archivos(maestro, vec_detalles);
end;

procedure imprimir_maestro(var maestro:arch_maestro);
var 
    res:resumen;
    aux:integer;
begin 
    reset(maestro);
    leerM(maestro, res);
    while (res.codigo_localidad <> valor_alto) do begin
        aux := res.codigo_localidad;
        write('Localidad: ', res.codigo_localidad);
        while (res.codigo_localidad = aux) do begin 
            write('cepa: ', res.codigo_cepa, '| Total casos_activos: ', res.casos_activos, '| ');
            leerM(maestro, res);
        end;
    end;
    close(maestro);
end;

var 
    maestro:arch_maestro;
    detalles:vector_detalles;
    path:string;
    nombre_fisico:string;
    i:integer;
begin 
    path := './detalles/detalle';
    for i:=1 to dimF do begin 
        nombre_fisico := path + IntToStr(i) + '.dat';
        assign(detalles[i], nombre_fisico);
    end;
    assign(maestro, 'maestro.dat'); 
    actualizar_maestro(maestro, detalles);
    imprimir_maestro(maestro);
end.