program e17;

uses types, sysutils;

function registro_minimo(vec_ventas:vector_ventas):integer;
var 
    i, indice:integer;
    codigo_minimo:integer;
begin 
    codigo_minimo := valor_alto;
    indice := 1;
    for i:=1 to dimF do begin 
        if (vec_ventas[i].codigo < codigo_minimo) then begin 
            codigo_minimo := vec_ventas[i].codigo;
            indice := i;
        end;
    end;
    registro_minimo := indice;
end;

procedure minimo(var detalles:vector_detalle; var vec_ventas:vector_ventas; var min:ventas);
var 
    i:integer;
begin 
    i := registro_minimo(vec_ventas);
    min := vec_ventas[i];
    leer_detalle(detalles[i], vec_ventas[i]);
end;

procedure actualizar_e_informar(var maestro:arch_maestro; var detalles:vector_detalle);
var 
    vec_ventas:vector_ventas;
    min:ventas;
    moto:motos;
    i:integer;
    aux_venta:integer; 
    cantidad_vendidas:integer;
    indice:integer;
begin 
    cantidad_vendidas := valor_bajo;
    indice := -1;
    for i:=1 to dimF do begin 
        reset(detalles[i]);
        leer_detalle(detalles[i], vec_ventas[i]);
    end;
    reset(maestro);
    leer_maestro(maestro, moto);
    minimo(detalles, vec_ventas, min);

    while (min.codigo <> valor_alto) do begin 
        while (min.codigo <> moto.codigo) do leer_maestro(maestro, moto);
        aux_venta := 0;

        while ((min.codigo = moto.codigo) and (min.codigo <> valor_alto)) do begin 
            inc(aux_venta);
            dec(moto.stock_actual);
            minimo(detalles, vec_ventas, min);
        end;

        seek(maestro, filepos(maestro) - 1);
        write(maestro, moto);
        if (aux_venta > cantidad_vendidas) then begin 
            indice := filepos(maestro) - 1;
            cantidad_vendidas := aux_venta;
        end;

        leer_maestro(maestro, moto);
    end;

    if (indice > -1) then begin 
        seek(maestro, indice);
        read(maestro, moto);
        writeln('la moto mas vendida fue la moto: ', moto.codigo, ' con ', cantidad_vendidas);
    end;

    for i:=1 to dimF do begin 
        close(detalles[i]);
    end;
    close(maestro);
end;

var 
    maestro:arch_maestro;
    detalles:vector_detalle;
    i:integer;
    path, nombre_fisico:string;
begin 
    path := './detalles/detalle';
    for i:=1 to dimF do begin 
        nombre_fisico := path + IntToStr(i) + '.dat';
        assign(detalles[i], nombre_fisico);
    end;
    assign(maestro, 'maestro.dat');
    actualizar_e_informar(maestro, detalles);
end.
