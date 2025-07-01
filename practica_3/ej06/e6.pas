program e6;

uses types, sysutils;

procedure eliminar_registro(var maestro:arch_prendas; id:integer);
var 
    prenda:prendas;
    aux:prendas;
    indice:integer;
begin
    seek(maestro, 1);
    leer_prendas(maestro, prenda);
    while ((prenda.codigo <> valor_alto) and (prenda.codigo <> id)) do leer_prendas(maestro, prenda);
    if (prenda.codigo = id) then begin 
        indice := filepos(maestro) - 1;

        seek(maestro, 0);
        read(maestro, aux);

        prenda.stock := aux.stock;
        aux.stock := indice * -1;

        seek(maestro, 0);
        write(maestro, aux);
        seek(maestro, indice);
        write(maestro, prenda);
    end else writeln(' no encontrado');
end;


procedure actualizar_prendas(var maestro:arch_prendas; var detalle:arch_obsoletas);
var 
    obsoleta:obsoletas;
begin 
    reset(maestro);
    reset(detalle);
    while (not eof(detalle)) do begin 
        read(detalle, obsoleta);
        eliminar_registro(maestro, obsoleta.codigo);
    end;
    close(maestro);
    close(detalle);
end;

procedure imprimir_contenido(var maestro:arch_prendas);
var 
    prenda:prendas;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(maestro, prenda);
        write(prenda.codigo, '|', prenda.stock, '|  ');
    end;
    close(maestro);
end;

procedure imprimir_maestro(var maestro:arch_prendas);
var 
    prenda:prendas;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin
        read(maestro, prenda);
        if (not borrado(prenda.stock)) then write(prenda.codigo, '|');
    end;
    close(maestro);
end;

procedure pasar_maestro(var maestro:arch_prendas; var nuevo:arch_prendas);
var 
    prenda:prendas;
begin 
    reset(maestro);
    rewrite(nuevo);
    if (not eof(maestro)) then begin 
        read(maestro, prenda);
        prenda.stock := 0;
        write(nuevo, prenda);
    end;
    while (not eof(maestro)) do begin 
        read(maestro, prenda);
        if (not borrado(prenda.stock)) then write(nuevo, prenda);
    end;
    close(nuevo);
    close(maestro);
end;

var 
    maestro:arch_prendas;
    detalle:arch_obsoletas;
    nuevo_maestro:arch_prendas;
begin 
    assign(maestro, 'maestro.dat');
    assign(detalle, 'detalle.dat');
    assign(nuevo_maestro, 'nuevo.dat');
    actualizar_prendas(maestro, detalle);
    pasar_maestro(maestro, nuevo_maestro);

    erase(maestro);
    RenameFile('nuevo.dat', 'maestro.dat');
    
    imprimir_contenido(maestro);
end.
