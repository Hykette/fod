program generar_txt;
uses types;

procedure crear_archivo_novela(var txt:archivo_txt);forward;

procedure main();
var
    fisico_novelas:string;
    txt_novelas:archivo_txt;
begin
    fisico_novelas := 'novelas.txt';
    assign(txt_novelas, fisico_novelas);
    crear_archivo_novela(txt_novelas);
end;

procedure crear_archivo_novela(var txt:archivo_txt);
var 
    nov:novela; i:integer;
begin 
    rewrite(txt); //codigo, precio, genero, nombre
    for i := 1 to 4 do begin 
        crear_novela(nov);
        with nov do begin 
            writeln(txt, codigo, ' ', precio:0:2, ' ', genero);
            writeln(txt, nombre);
        end;
    end;
    close(txt);
end;

begin 
    main();
end.