{Crear un archivo de registros no ordenados de celulares y cargarlo con datos
ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
correspondientes a los celulares deben contener: código de celular, nombre,
descripción, marca, precio, stock mínimo y stock disponible
Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
stock mínimo}

program e5;
uses types, sysutils;

procedure menu(var eleccion:integer);forward;
procedure pasar_txt_a_binario(var txt:archivo_txt; var arch_cel:archivo_celulares);forward;
procedure listar_stock_menor_al_minimo(var arch_cel:archivo_celulares); forward;
procedure buscar_descripcion(var arch_cel:archivo_celulares);forward; //tiene que ser cadena dentro de descripcion
procedure exportar_a_txt(var arch_cel:archivo_celulares; var txt:archivo_txt);forward;

procedure imprimir_binario(var arch_cel:archivo_celulares; nombre_arch:string);forward;


procedure main();
var 
    fisico_celulares:string;
    fisico_txt:string;
    fisico_txt2:string;

    txt:archivo_txt;
    txt2:archivo_txt;
    arch_cel:archivo_celulares;
    eleccion:integer;
begin 
    fisico_celulares := 'celulares.dat';
    fisico_txt := 'celulares.txt';
    fisico_txt2 := 'otro.txt';

    if (not fileexists(fisico_txt)) then begin 
        writeln('No existe el archivo: "celulares.txt"');
        exit();
    end;

    assign(txt, fisico_txt);
    assign(arch_cel, fisico_celulares);
    assign(txt2, fisico_txt2);

    menu(eleccion);
    while (eleccion <> 0) do begin 
        case eleccion of
            1: pasar_txt_a_binario(txt, arch_cel);
            2: listar_stock_menor_al_minimo(arch_cel);
            3: buscar_descripcion(arch_cel);
            4: exportar_a_txt(arch_cel, txt2);
            10: imprimir_binario(arch_cel, fisico_celulares);
            else writeln('El numero ingresado no se encuentra dentro del menu');
        end;
        menu(eleccion);
    end;
end;


procedure menu(var eleccion:integer);
begin 
    writeln('Elegir una opcion:');
    writeln('1: Crear archivo binario');
    writeln('2: Listar en pantalla los celulares con menos stock del stock minimo');
    writeln('3: Buscar celular por descripcion');
    writeln('4: Exportar archivo a texto');
    writeln('10: visualizar el archivo');
    writeln('0: terminar el programa');
    readln(eleccion);
end;

procedure exportar_a_txt(var arch_cel:archivo_celulares; var txt:archivo_txt);
var 
    cel:celular;

begin 
    reset(arch_cel);
    rewrite(txt);
    while(not eof(arch_cel)) do begin 
        read(arch_cel, cel);
        with cel do begin
            writeln(txt, codigo, ' ', precio:0:2, marca);
            writeln(txt, stock_disponible, ' ', stock_minimo, descripcion);
            writeln(txt, nombre);
        end;
    end;
    close(arch_cel);
    close(txt);
end;
    

procedure listar_stock_menor_al_minimo(var arch_cel:archivo_celulares); 
var
    cel:celular;
begin 
    reset(arch_cel);
    while (not eof(arch_cel)) do begin 
        read(arch_cel, cel);
        if (cel.stock_disponible < cel.stock_minimo) then writeln('stock menor al minimo: ', cel.codigo);
    end;
    close(arch_cel);
end;

procedure buscar_descripcion(var arch_cel:archivo_celulares);
var 
    cel:celular;
    descripcion:string;
begin 
    writeln('descripcion a buscar: ');
    readln(descripcion);
    reset(arch_cel);

    while (not eof(arch_cel)) do begin
        read(arch_cel, cel);
        if (pos(descripcion, cel.descripcion) > 0) then writeln('celular con misma descripcion: ', cel.codigo);
    end;
    
    close(arch_cel);  
end;

procedure pasar_txt_a_binario(var txt:archivo_txt; var arch_cel:archivo_celulares);
var 
    cel:celular;
begin 
    reset(txt);
    rewrite(arch_cel);
    while(not EOF(txt)) do begin 
    //asumo que si no es EOF hay 7 lineas a leer, no lee bien cuando se separa por espacio " "
        with cel do begin
            readln(txt, codigo, precio, marca);
            readln(txt, stock_disponible, stock_minimo, descripcion);
            readln(txt, nombre);
        end;
        write(arch_cel, cel);
    end;
    close(txt);
    close(arch_cel);
end;

procedure imprimir_binario(var arch_cel:archivo_celulares; nombre_arch:string);
var 
    cel:celular;
begin 
    if (not FileExists(nombre_arch)) then begin 
        writeln('El archivo binario todavia no se creo');
        exit();
    end;
    reset(arch_cel);
    while (not eof(arch_cel)) do begin 
        read(arch_cel, cel);
        writeln(cel.precio:0:2);
    end;
end;


begin 
    main();
end.