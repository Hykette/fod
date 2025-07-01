program generar_txt;
uses types;

procedure crear_txt(var txt:archivo_txt);forward;
procedure escribir_en_txt(var txt:archivo_txt; var celu:celular);forward;
procedure crear_celular(var celu:celular);forward;
function generar_string():string;forward;

procedure main();
var 
    nombre_fisico_txt:string;
    txt:archivo_txt;
begin 
    nombre_fisico_txt:='celulares.txt';
    assign(txt, nombre_fisico_txt);
    crear_txt(txt);
end;

procedure crear_txt(var txt:archivo_txt);
var 
    celu:celular; i:integer;
begin 
    rewrite(txt);
    for i:=0 to 10 do begin
        crear_celular(celu);
        escribir_en_txt(txt, celu);
    end;
    close(txt);
end;

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

// crea un celular desde 0
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

begin 
    randomize;
    main();
end.