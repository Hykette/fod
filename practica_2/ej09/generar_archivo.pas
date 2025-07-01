program generar_archivo;

uses types, sysutils;

procedure generar_archivo(var arch:archivo_cliente);
var
    i, j, k, l, veces:integer;
    cli:cliente;
begin 
    rewrite(arch);

    for i:=1 to dimF do begin 
        cli.codigo := i;
        
        for j:=1 to 10 do begin //10 años
            cli.anio := j;

            for k:=1 to 12 do begin //meses
                cli.mes := k;
                veces := random(5) + 1; 
                //compras en el mismo mes
                for l:=1 to veces do begin 
                    cli.dia := random(28) + 1;
                    cli.nombre := generar_string();
                    cli.apellido := generar_string();
                    cli.venta := random(1000) + (1 / (random(100) + 1)) + 100;
                    write(arch, cli);
                end;
            end;
        end;
    end;
    close(arch);
end;

procedure imprimir_archivo(var arch:archivo_cliente);
var 
    cli:cliente;
    codigo:integer;
    monto:real;
begin 
    reset(arch);
    leer_archivo(arch, cli);

    while (cli.codigo <> valor_alto) do begin 
        codigo := cli.codigo;
        monto := 0;
        writeln('codigo: ', codigo);
        while (codigo = cli.codigo) do begin 
            monto := monto + cli.venta;
            leer_archivo(arch, cli);
            
            write(cli.venta:0:2, '|');
        end;
        writeln();
        writeln(monto:0:2);
        writeln();
    end;

    close(arch);
end;

var
    archivo:archivo_cliente;
begin 
    assign(archivo, 'clientes.dat');
    generar_archivo(archivo);
    imprimir_archivo(archivo);
end.
