program generar_archivo;

uses types, sysutils;

procedure generar_archivo(var detalles:vector_archivo);
var 
    i, j, k, veces: integer;
    mesa:mesas;
begin 
    
    for i:=1 to dimF do begin 
        mesa.codigo_provincia := i; // 24 en realidad pero bueno
        rewrite(detalles[i]);
        for j:=1 to dimF do begin 
            mesa.codigo_localidad := j;
            veces := random(5) + 1;
            for k:=1 to veces do begin 
                mesa.numero := random(10) + 1;
                mesa.votos := random(100) + 10;
                write(detalles[i], mesa);
            end;
        end;
        close(detalles[i]);
    end;
end;

function registro_minimo(var vec_registros:vec_mesas):integer;
var
    i:integer;
    indice:integer;
    provincia_minimo:integer;
    localidad_minimo:integer;
begin 
    provincia_minimo := valor_alto;
    localidad_minimo := valor_alto;
    indice := 1;
    for i:=1 to dimF do begin 
        if ((vec_registros[i].codigo_provincia < provincia_minimo) or 
        ((vec_registros[i].codigo_provincia = provincia_minimo) and (vec_registros[i].codigo_localidad <= localidad_minimo))) then begin 
            provincia_minimo := vec_registros[i].codigo_provincia;
            localidad_minimo := vec_registros[i].codigo_localidad;
            indice := i;
        end;
    end;
    registro_minimo := indice;
end;

procedure minimo(var archivos:vector_archivo; var vec_registros:vec_mesas; var min:mesas);
var 
    i:integer;
begin 
    i:= registro_minimo(vec_registros);
    min := vec_registros[i];
    leer_archivo(archivos[i], vec_registros[i]);
end;

procedure imprimir_archivo(var detalles:vector_archivo);
var 
    vec_mesa:vec_mesas;
    i:integer;
    aux:integer;
    min:mesas;
begin 
    for i:=1 to dimF do begin  
        reset(detalles[i]);
        leer_archivo(detalles[i], vec_mesa[i]);
    end;
    minimo(detalles, vec_mesa, min);

    while (min.codigo_provincia <> valor_alto) do begin 
        writeln('codigo: ', min.codigo_provincia, ' localidad: ', min.codigo_localidad);
        aux := min.codigo_localidad;

        while ((min.codigo_localidad = aux) and (min.codigo_provincia <> valor_alto)) do begin 
            write('votos: ', min.votos, '| ');
            minimo(detalles, vec_mesa, min);
        end;
    end;

    for i:=1 to dimF do begin 
        close(detalles[i]);
    end;
end;

var 
    vector_archivos:vector_archivo;
    i:integer;
    path, nombre_fisico:string;
begin 
    path := './detalles/detalle';
    for i:=1 to dimF do begin 
        nombre_fisico := path + IntToStr(i) + '.dat';
        assign(vector_archivos[i], nombre_fisico);
    end;
    generar_archivo(vector_archivos);
    imprimir_archivo(vector_archivos);
end.