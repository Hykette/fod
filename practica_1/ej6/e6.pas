program e5;
uses parte_del_e5, sysutils;

procedure menu(var eleccion: Integer); forward;
procedure exportar_sin_stock(var arch_cel:archivo_celulares; var txt:archivo_txt; nombre_arch:string);forward;
procedure modificar_stock(var arch_cel:archivo_celulares; nombre_arch:string); forward;
procedure agregar_celulares(var arch_cel:archivo_celulares; var txt:archivo_txt); forward;
procedure actualizar_txt_original(var arch_cel:archivo_celulares; var txt:archivo_txt);forward;

procedure main();
var 
    eleccion:integer;
    fisico_txt_carga:string; // origen, "celulares.txt"
    fisico_txt_exportar:string; // "otro.txt"
    fisico_txt_sin_stock:string; // SinStock.txt
    fisico_celulares:string; //celulares.dat

    txt_carga, txt_exportar, txt_sin_stock:archivo_txt;

    arch_celulares:archivo_celulares;

begin 
    fisico_txt_carga := 'celulares.txt'; // origen, "celulares.txt"
    if (not fileExists(fisico_txt_carga)) then begin 
        writeln('No hay archivo de carga');
        exit;
    end;
    
    fisico_txt_exportar := 'otro.txt'; // "otro.txt"
    fisico_txt_sin_stock := 'SinStock.txt'; // SinStock.txt
    fisico_celulares := 'celulares.dat';

    assign(txt_carga, fisico_txt_carga);
    assign(txt_exportar, fisico_txt_exportar);
    assign(txt_sin_stock, fisico_txt_sin_stock);
    assign(arch_celulares, fisico_celulares);

    menu(eleccion);
    while (eleccion <> 0) do begin 
        case eleccion of
            1: pasar_txt_a_binario(txt_carga, arch_celulares);
            2: listar_stock_menor_al_minimo(arch_celulares);
            3: buscar_descripcion(arch_celulares);
            4: exportar_a_txt(arch_celulares, txt_exportar);
            5: agregar_celulares(arch_celulares, txt_carga);
            6: modificar_stock(arch_celulares, fisico_celulares); 
            7: exportar_sin_stock(arch_celulares, txt_sin_stock, fisico_celulares);
            8: actualizar_txt_original(arch_celulares, txt_carga);
            10: imprimir_binario(arch_celulares, fisico_celulares);
            else writeln('El numero ingresado no se encuentra dentro del menu');
        end;
        menu(eleccion);
    end;
end;

procedure actualizar_txt_original(var arch_cel:archivo_celulares; var txt:archivo_txt);
var 
    cel:celular;
begin 
    reset(arch_cel);
    rewrite(txt);
    while (not eof(arch_cel)) do begin
        read(arch_cel, cel);
        escribir_en_txt(txt, cel);
    end;
    close(arch_cel);
    close(txt);
end;

procedure menu(var eleccion:integer);
begin 
    writeln('Elegir una opcion:');
    writeln('1: Crear archivo binario');
    writeln('2: Listar en pantalla los celulares con menos stock del stock minimo');
    writeln('3: Buscar celular por descripcion');
    writeln('4: Exportar archivo a texto');
    writeln('5: Agregar celulares'); 
    writeln('6: Modificar el stock de un celular');
    writeln('7: Exportar txt los celulares que no tengan stock');
    writeln('8: Actualizar archivo origen');
    writeln('10: visualizar el archivo');
    writeln('0: terminar el programa');
    readln(eleccion);
end;

procedure agregar_celulares(var arch_cel:archivo_celulares; var txt:archivo_txt); 
var 
    cel:celular;
    i:integer;
begin 
    reset(arch_cel);
    seek(arch_cel, filesize(arch_cel));
    for i := 1 to 3 do begin 
        crear_celular(cel); // aca estaria bueno chequear si no se repite
        write(arch_cel, cel);
    end;
    close(arch_cel);

    writeln('Guardar celulares? si(1) no(2)');
    readln(i);
    while ((i < 1) or (i > 2)) do begin 
        writeln('Guardar celulares? si(1) no(2)');
        readln(i);
    end;
    if (i = 1) then exportar_a_txt(arch_cel, txt); //esto abre y cierra los archivos
end;

procedure modificar_stock(var arch_cel:archivo_celulares; nombre_arch:string); 
var 
    cel:celular;
    nombre:string;
    nuevo_stock:longint;
begin
    // modificar stock de celulares
    if (not fileExists(nombre_arch)) then begin 
        writeln('No existe el archivo');
        exit;
    end;

    writeln('nombre del celular: ');
    readln(nombre);
    writeln('nuevo stock disponible: ');
    readln(nuevo_stock);

    reset(arch_cel);


    while (not eof(arch_cel)) do begin 
        read(arch_cel, cel);
        if (cel.nombre = nombre) then begin 
            cel.stock_disponible := nuevo_stock;
            seek(arch_cel, FilePos(arch_cel) - 1);
            write(arch_cel, cel);
            close(arch_cel);
            exit;
        end;
    end;
    close(arch_cel);
    writeln('No se encontro el celular');
end;

procedure exportar_sin_stock(var arch_cel:archivo_celulares; var txt:archivo_txt; nombre_arch:string);
var 
    cel:celular;
begin 
    if (not fileExists(nombre_arch)) then begin
        writeln('No existe el archivo de celulares');
        exit;
    end;
    reset(arch_cel);
    rewrite(txt);
    while (not eof(arch_cel)) do begin
        read(arch_cel, cel);
        if (cel.stock_disponible = 0) then escribir_en_txt(txt, cel);
    end;
    close(arch_cel);
    close(txt);
end;


begin 
    main();
end.