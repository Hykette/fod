program generar_archivos;

uses types, sysutils;

procedure generar_detalles(var detalles:vector_detalle);
var 
    i, j, k, veces:integer;
    venta:ventas;
begin 
    for i:=1 to dimF do begin 
        rewrite(detalles[i]);
        for j := 1 to 10 do begin
            venta.codigo := j;
            //diferente precio por venta pero fue
            venta.precio := random(10000) + (1 / (random(10) + 1));
            veces := random(6) + 1;
            for k := 1 to veces do begin 
                venta.fecha := random(10);
                write(detalles[i], venta);
            end;
        end;
        close(detalles[i]);
    end;
end;

procedure generar_maestro(var maestro:arch_maestro);
var 
    i:integer;
    moto:motos;
begin 
    rewrite(maestro);
    for i:=1 to 10 do begin 
        moto.codigo := i;
        moto.nombre := generar_string();
        moto.descripcion := generar_string();
        moto.modelo := generar_string();
        moto.marca := generar_string();
        moto.stock_actual := 1000;
        write(maestro, moto);
    end;
    close(maestro);
end;

procedure imprimir_detalles(var detalles:vector_detalle);
var 
    venta:ventas;
    i:integer;
begin 
    for i:= 1 to dimF do begin 
        reset(detalles[i]);
        while (not eof(detalles[i])) do begin 
            read(detalles[i], venta);
            if (venta.codigo = 1) then writeln(venta.codigo, '|', venta.precio:0:2, '|', venta.fecha);
        end;
        close(detalles[i]);
    end;
end;
procedure imprimir_maestro(var maestro:arch_maestro);
var 
    moto:motos;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(maestro, moto);
        writeln(moto.codigo, '|', moto.stock_actual);
    end;
    close(maestro);
end;

var
    detalles:vector_detalle;
    maestro:arch_maestro;
    i:integer;
    path:string;
    nombre_fisico:string;
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
    imprimir_maestro(maestro);
end.
