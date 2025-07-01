program e7;
uses types, sysutils;
procedure txt_a_binario(var arch_nov:archivo_novelas; var txt:archivo_txt; nombre_txt:string);forward;
procedure agregar_novela(var arch_nov:archivo_novelas; var txt:archivo_txt; nombre_arch:string);forward;
procedure modificar_novela(var arch_nov:archivo_novelas; var txt:archivo_txt; nombre_arch:string);forward;
procedure menu(var eleccion:integer);forward;
procedure imprimir_archivo(var arch_nov:archivo_novelas; nombre_arch:string);forward;

procedure main();
var 
    fisico_novela:string;
    fisico_txt:string;

    arch_novela:archivo_novelas;
    txt_novela:archivo_txt;

    eleccion:integer;
begin 
    fisico_novela := 'novelas.dat';
    fisico_txt := 'novelas.txt';
    assign(arch_novela, fisico_novela);
    assign(txt_novela, fisico_txt);
    menu(eleccion);
    while (eleccion <> 0) do begin 
        case eleccion of 
            1:  txt_a_binario(arch_novela, txt_novela, fisico_txt);
            2:  agregar_novela(arch_novela, txt_novela, fisico_novela);
            3:  modificar_novela(arch_novela, txt_novela, fisico_novela);
            4:  imprimir_archivo(arch_novela, fisico_novela);
            0: writeln('');
        end;
        menu(eleccion);
    end;
end;

procedure menu(var eleccion:integer);
begin 
    writeln('Elegir una opcion: ');
    writeln('1: Abrir el archivo en binario');
    writeln('2: Agregar una novela');
    writeln('3: Modificar algun campo de una novela');
    writeln('4: Visualizar el archivo');
    writeln('0: Terminar programa');
    readln(eleccion);
end;

procedure imprimir_archivo(var arch_nov:archivo_novelas; nombre_arch:string);
var
    nov:novela;
begin 
    if (not fileexists(nombre_arch)) then begin 
        writeln('No existe el archivo binario todavia');
        exit;
    end;
    reset(arch_nov);
    while (not eof(arch_nov)) do begin 
        read(arch_nov, nov);
        writeln('Nombre: ', nov.nombre, ' precio: ', nov.precio:0:2);
    end;
    close(arch_nov);
end;

//actualiza cualquier valor de la novela pedido, buscando por nombre
procedure modificar_novela(var arch_nov:archivo_novelas; var txt:archivo_txt; nombre_arch:string);
var
    nombre:string;
    eleccion:integer;
    nov:novela;
begin 
    if (not fileexists(nombre_arch)) then begin 
        writeln('no existe el binario :c');
        exit;
    end;

    writeln('nombre de novela a modificar: ');
    readln(nombre);

    reset(arch_nov);
    while (not eof(arch_nov)) do begin 
        read(arch_nov, nov);
        if (nov.nombre = nombre) then begin 
            seek(arch_nov, filepos(arch_nov) -1);

            writeln('Campo a modificar de la novela:');
            writeln('1: codigo');
            writeln('2: precio');
            writeln('3: genero');
            writeln('4: nombre');

            readln(eleccion);
            if ((eleccion > 0) and (eleccion < 5)) then writeln('Nuevo valor:');
            case eleccion of 
                1: readln(nov.codigo); 
                2: readln(nov.precio);
                3: readln(nov.genero);
                4: readln(nov.nombre);
                else writeln('opcion inexistente');
            end;
            write(arch_nov, nov);

            close(arch_nov);
            reset(arch_nov);
            rewrite(txt);
            // Guarda si o si 
            while (not eof(arch_nov)) do begin 
                read(arch_nov, nov);
                with nov do begin 
                    writeln(txt, codigo, ' ', precio:0:2, ' ', genero);
                    writeln(txt, nombre);
                end;
            end;
            close(arch_nov);
            close(txt);
            exit;
        end;
    end;
    close(arch_nov);
    writeln('No se encontro el libro :c');
end;
    

procedure agregar_novela(var arch_nov:archivo_novelas; var txt:archivo_txt; nombre_arch:string);
// guarda en el txt automaticamente
var 
    i:integer;
    nov:novela;
begin 
    if (not fileExists(nombre_arch)) then begin 
        writeln('No existe el archivo');
        exit;
    end;
    reset(arch_nov);
    append(txt);
    seek(arch_nov, filesize(arch_nov));
    for i := 1 to 2 do begin 
        crear_novela(nov);
        write(arch_nov, nov);
        with nov do begin 
            writeln(txt, codigo, ' ', precio:0:2, ' ', genero);
            writeln(txt, nombre);
        end;
    end;
end;

// crea binario a partir del txt
procedure txt_a_binario(var arch_nov:archivo_novelas; var txt:archivo_txt; nombre_txt:string);
var
    nov:novela;
begin 
    if (not fileexists(nombre_txt)) then begin 
        writeln('no hay archivo origen');
        exit;
    end;

    rewrite(arch_nov);
    reset(txt);

    while (not eof(txt)) do begin 
        with nov do begin
            readln(txt, codigo, precio, genero);
            readln(txt, nombre);
        end;
        write(arch_nov, nov);
    end;

    close(arch_nov);
    close(txt);
end;

begin 
    main();
end.