unit parte_del_e5;


interface
type 
    celular = record
        codigo:longint;
        nombre:string;
        descripcion:string;
        marca:string;
        
        precio:double;
        stock_minimo:longint;
        stock_disponible:longint;
    end;

    archivo_celulares = file of celular;
    archivo_txt = TextFile;


procedure pasar_txt_a_binario(var txt:archivo_txt; var arch_cel:archivo_celulares);
procedure listar_stock_menor_al_minimo(var arch_cel:archivo_celulares); 
procedure buscar_descripcion(var arch_cel:archivo_celulares); //tiene que ser cadena dentro de descripcion
procedure exportar_a_txt(var arch_cel:archivo_celulares; var txt:archivo_txt);
function generar_string():string;
procedure crear_celular(var celu:celular);
procedure escribir_en_txt(var txt:archivo_txt; var celu:celular);

procedure imprimir_binario(var arch_cel:archivo_celulares; nombre_arch:string);


implementation
uses sysutils;

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

procedure crear_celular(var celu:celular);
begin  
    with celu do begin 
        codigo := random(892331) + 1;
        nombre := generar_string();
        descripcion := generar_string();
        marca := generar_string();
        precio := random(100000) + 1 + (1 / (random(100) + 1));
        stock_minimo := random(1000) + 6000;
        stock_disponible := random(12000) + 1; //num bajo para probar
    end;
end;

procedure escribir_en_txt(var txt:archivo_txt; var celu:celular);
begin 
    //buscar codigo creado para ver si se puede agregar
    // orden para el txt: codigo, precio,marca \n stock, stock minimo, descripcion \n nombre
    with celu do begin
        writeln(txt, codigo, ' ', precio:0:2, ' ', marca); 
        writeln(txt, stock_disponible, ' ', stock_minimo, ' ', descripcion);
        writeln(txt, nombre);
    end;
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

end.