program generar_archivos;

uses types, sysutils;

function generar_string():string;
const
    caracteres = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
    i, longitud: integer; aux: string;

begin
    aux := '';
    longitud := 5;
    for i := 1 to longitud do begin
        aux := aux + caracteres[Random(52) + 1]; 
    end;
    generar_string := aux;
end;

procedure generar_archivoD(var detalle:arch_detalle);
var 
    ven:ventas;
    i, j:integer;
    veces:integer;
begin 
    rewrite(detalle);
    with ven do begin 
        for i:=1 to 20 do begin 
            codigo := i;
            veces := random(5) + 1;
            for j:=1 to veces do begin 
                cantidad := random(10) + 1;
                write(detalle, ven);
            end;
        end;
    end;
    close(detalle);
end;

procedure generar_detalles(var vector:detalles);
var 
    i:integer;
begin   
    for i:=1 to dimF do begin 
        generar_archivoD(vector[i]);
    end;
end;

procedure generar_archivoM(var maestro:arch_maestro);
var 
    i:integer;
    prod:producto;
begin 
    rewrite(maestro);
    with prod do begin 
        for i:=1 to 20 do begin 
            codigo := i;
            nombre := generar_string();
            descripcion := generar_string();
            stock_disponible := random(500) + 1250;
            stock_minimo := random(500) + 500;
            precio := random(500) + (1 / (random(10) + 1));
            write(maestro, prod);
        end;
    end;
    close(maestro);
end;

procedure imprimir_maestro(var maestro:arch_maestro);
var 
    prod:producto;
begin  
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(maestro, prod);
        write('codigo: ', prod.codigo, '|', prod.stock_disponible, '|');
    end;
    writeln();
    close(maestro);
end;

procedure imprimir_detalle(var detalle:arch_detalle);
var 
    ven:ventas;
begin 
    reset(detalle);
    while (not eof(detalle)) do begin 
        read(detalle, ven);
        write('codigo: ', ven.codigo, '|');
    end;
    close(detalle);
end;

//quizas hay una mejor manera de imprimir esto con un procedure minimo()
procedure imprimir_detalles(var vector:detalles);
var 
    i:integer;
begin 
    for i:=1 to dimF do begin 
        imprimir_detalle(vector[i]);
    end;
    writeln();
end;

var 
    vec_detalles:detalles;
    maestro:arch_maestro;
    path, nombre_fisico: string;
    i:integer;
begin 
    path := './detalles/detalle'; //i.dat
    for i:=1 to dimF do begin 
        nombre_fisico := path + IntToStr(i) + '.dat';
        assign(vec_detalles[i], nombre_fisico);
    end;
    assign(maestro, 'maestro.dat');

    generar_detalles(vec_detalles);
    generar_archivoM(maestro);
    imprimir_detalles(vec_detalles);
    imprimir_maestro(maestro);
end.

