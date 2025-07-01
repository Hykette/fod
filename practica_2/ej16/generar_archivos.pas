program generar_archivos;

uses sysutils, types;

procedure generar_detalles(var detalles:vector_detalle);
var     
    i, j, k, l:longint;
    veces:integer;
    venta:ventas;
begin 
    for i:=1 to dimF do begin 
        rewrite(detalles[i]);
        for j:=1 to 20 do begin 
            venta.fecha := j;
            for k:=1 to 20 do begin 
                venta.codigo_seminario := k;
                veces := random(5) + 1;
                for l:=1 to veces do begin 
                    venta.ejemplares_vendidos := random(10);
                    write(detalles[i], venta);
                end;
            end;
        end;
        close(detalles[i]);
    end;
end;

procedure generar_maestro(var maestro:arch_maestro);
var 
    i, j:longint;
    emision:emisiones;
begin 
    rewrite(maestro);
    for i:=1 to 20 do begin 
        emision.fecha := i;
        for j:=1 to 20 do begin 
            emision.codigo_seminario := j;
            emision.nombre_seminario := generar_string();
            emision.descripcion := generar_string();
            emision.precio := (random(10000) + (1 / (random(10) + 1)));
            emision.total_ejemplares := random(100000);
            emision.ejemplares_vendidos := 0;
            write(maestro, emision);
        end;
    end;
    close(maestro);
end;

procedure imprimir_maestro(var maestro:arch_maestro);
var 
    emision:emisiones;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(maestro, emision);
        writeln(emision.fecha, '|', emision.codigo_seminario, '|', emision.ejemplares_vendidos);
    end;
    close(maestro);
end;

procedure imprimir_detalles(var detalles:vector_detalle);
var 
    venta:ventas;
    i:longint;
begin 
    for i:=1 to dimF do begin 
        reset(detalles[i]);
        while (not eof(detalles[i])) do begin 
            read(detalles[i], venta);
            writeln(venta.fecha, '|', venta.codigo_seminario, '|', venta.ejemplares_vendidos);
        end;
        close(detalles[i]);
    end;
end;

var 
    maestro:arch_maestro;
    detalles:vector_detalle;
    path, nombre_fisico:string;
    i:integer;
begin 
    path := './detalles/detalle';
    assign(maestro, 'maestro.dat');
    for i:=1 to dimF do begin 
        nombre_fisico := path + IntToStr(i) + '.dat';
        assign(detalles[i], nombre_fisico);
    end;
    generar_detalles(detalles);
    generar_maestro(maestro);
    imprimir_maestro(maestro);
    imprimir_detalles(detalles);
end.
    

            