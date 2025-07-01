program e4;

uses types, sysutils;

function registro_minimo(ven:vector_ventas):integer;
var 
    i:integer;
    indice:integer;
    minimo:integer;
begin 
    minimo := valor_alto;
    indice := 1;
    for i:=1 to dimF do begin 
        if (ven[i].codigo <= minimo) then begin 
            indice := i;
            minimo := ven[i].codigo;
        end;
    end;
    registro_minimo := indice;
end;

procedure minimo(var vector_detalles:detalles; var ven:vector_ventas; var min:ventas);
var 
    i:integer;
begin 
    i := registro_minimo(ven);
    min := ven[i];
    leerD(vector_detalles[i], ven[i]);
end;


procedure actualizar_maestro(var maestro:arch_maestro; var vector_detalles:detalles; var informe:Text);
var 
    ven:vector_ventas;
    prod:producto;
    min:ventas;
    i:integer;
begin

    for i:=1 to dimF do begin 
        reset(vector_detalles[i]);
        leerD(vector_detalles[i], ven[i]);
    end;

    reset(maestro);
    rewrite(informe);

    leerM(maestro, prod);
    minimo(vector_detalles, ven, min);

    while (min.codigo <> valor_alto) do begin 

        while (prod.codigo <> min.codigo) do leerM(maestro, prod);

        while (prod.codigo = min.codigo) do begin 
            prod.stock_disponible := prod.stock_disponible - min.cantidad;
            minimo(vector_detalles, ven, min);
        end;

        seek(maestro, filePos(maestro) - 1);
        write(maestro, prod);

        if (prod.stock_disponible < prod.stock_minimo) then begin 
            with prod do begin 
                write(informe, precio:0:2, ' ', stock_disponible, ' ', descripcion, ' ');
                writeln(informe);
            end;
        end;

    end;

    close(maestro);
    close(informe);
    
    for i:=1 to dimF do begin 
        close(vector_detalles[i]);
    end;
end;

procedure imprimir_maestro(var maestro:arch_maestro);
var 
    prod:producto;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(maestro, prod);
        writeln(prod.codigo, '|', prod.stock_disponible, '|');
    end;
    close(maestro);
end;

var 
    maestro:arch_maestro;
    informe:Text;

    vector_detalles:detalles;

    path:string;
    nombre_fisico:string;
    i:integer;
begin   
    path := './detalles/detalle'; //i.dat
    assign(maestro, 'maestro.dat');
    assign(informe, 'informe.txt');
    //assign 
    for i:=1 to dimF do begin 
        nombre_fisico := path + IntToStr(i) + '.dat';
        assign(vector_detalles[i], nombre_fisico);
    end;
    actualizar_maestro(maestro, vector_detalles, informe);
    imprimir_maestro(maestro);
end.