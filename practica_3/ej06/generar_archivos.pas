program generar_archivos;

uses types;

procedure generar_prendas_y_obsoletas(var maestro:arch_prendas; var detalle:arch_obsoletas);
var 
    prenda:prendas;
    obsoleta:obsoletas;
    i:integer;
begin 
    rewrite(maestro);
    rewrite(detalle);
    prenda.codigo := 0;
    prenda.descripcion:= '';
    prenda.colores := '';
    prenda.tipo := '';
    prenda.stock := 0;
    prenda.precio_unitario := 0;
    write(maestro, prenda);
    for i:=1 to 40 do begin
        prenda.codigo := i;
        if (random(100) < 30) then begin 
            obsoleta.codigo := i;
            write(detalle, obsoleta);
        end;
        prenda.descripcion := generar_string();
        prenda.colores := generar_string();
        prenda.tipo := generar_string();
        prenda.stock := 50 + random(100);
        prenda.precio_unitario := random(10000) + (1 / (random(10) + 1));
        write(maestro, prenda);
    end;
    close(maestro);
    close(detalle);
end;

procedure imprimir_prendas(var maestro:arch_prendas);
var 
    prenda:prendas;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(maestro, prenda);
        write(prenda.codigo, '|');
    end;
    close(maestro);
end;
procedure imprimir_obsoletas(var detalle:arch_obsoletas);
var 
    obsoleta:obsoletas;
begin 
    reset(detalle);
    while (not eof(detalle)) do begin 
        read(detalle, obsoleta);
        write(obsoleta.codigo, '|');
    end;
    close(detalle);
end;

var 
    maestro:arch_prendas;
    detalle:arch_obsoletas;
begin 
    assign(maestro, 'maestro.dat');
    assign(detalle, 'detalle.dat');
    generar_prendas_y_obsoletas(maestro, detalle);
    imprimir_prendas(maestro);
    writeln();
    imprimir_obsoletas(detalle);
end.
