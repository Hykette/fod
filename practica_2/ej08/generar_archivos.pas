program generar_archivos;

uses sysutils, types;

procedure generar_maestro(var maestro:arch_maestro);
var
    i:integer;
    prov:provincia;
begin 
    rewrite(maestro);
    for i:=1 to 24 do begin //provincias
        with prov do begin  
            codigo_provincia := i; 
            nombre := generar_string();
            habitantes := random(1000000) + 500000;
            //kilos_historicos := random(8000) + 1000;
            kilos_historicos := 0;
        end;
        write(maestro, prov);
    end;
    close(maestro);
end;
        
procedure generar_detalles(var detalles:vec_detalles);
var
    i, j, k, veces:integer;
    consumo:consumos;
begin
    for i:=1 to dimF do begin 
        rewrite(detalles[i]);
        for j:=1 to 24 do begin
            consumo.codigo_provincia := j;
            veces := random(5) + 1;
            for k:=1 to veces do begin 
                consumo.kilos := random(1000) + 100;
                write(detalles[i], consumo);
            end;
        end;
        close(detalles[i]);
    end;
end;

function registro_minimo(vec_consumos:vector_consumos):integer;
var 
    i:integer;
    minimo:integer;
    indice:integer;
begin
    minimo := valor_alto;
    for i:=1 to dimF do begin 
        if (vec_consumos[i].codigo_provincia <= minimo) then begin 
            minimo := vec_consumos[i].codigo_provincia;
            indice := i;
        end;
    end;
    registro_minimo := indice;
end;

procedure minimo(var detalles:vec_detalles; var vec_consumos:vector_consumos; var min:consumos);
var 
    i:integer;
begin 
    i := registro_minimo(vec_consumos);
    min := vec_consumos[i];
    leerD(detalles[i], vec_consumos[i]);
end;

procedure imprimir_detalles(var detalles:vec_detalles);
var 
    i:integer;
    vec_consumos:vector_consumos;
    aux:consumos;
    min:consumos;
begin 
    for i:=1 to dimF do begin 
        reset(detalles[i]);
        leerD(detalles[i], vec_consumos[i]);
    end;

    minimo(detalles, vec_consumos, min);

    while (min.codigo_provincia <> valor_alto) do begin 

        aux := min;
        writeln('provincia: ', min.codigo_provincia);
        write(' kilos: |');
        while (min.codigo_provincia = aux.codigo_provincia) do begin 
            write(min.kilos, '|');
            minimo(detalles, vec_consumos, min);
        end;
        writeln();
        writeln();
    end;

    for i:=1 to dimF do begin 
        close(detalles[i]);
    end;
end;

var 
    detalles:vec_detalles;
    maestro:arch_maestro;
    i:integer;
    path, nombre_fisico:string;
begin 
    path := './detalles/detalle';
    for i:=1 to dimF do begin 
        nombre_fisico := path + IntToStr(i) + '.dat';
        assign(detalles[i], nombre_fisico);
    end;
    assign(maestro, 'maestro.dat');
    generar_detalles(detalles);
    generar_maestro(maestro);
    imprimir_detalles(detalles);
end.
            
