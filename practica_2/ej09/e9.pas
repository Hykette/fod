program e9;

uses types;

procedure informar(var archivo:archivo_cliente);
var 
    cli:cliente;
    info:informe;
begin 
    reset(archivo);
    leer_archivo(archivo, cli);
    while (cli.codigo <> valor_alto) do begin 
        info.codigo := cli.codigo;
        info.nombre := cli.nombre;
        info.apellido := cli.apellido;
        writeln('Codigo cliente: ', info.codigo);

        while (cli.codigo = info.codigo) do begin 
            info.anio := cli.anio;
            info.total_anual := 0;

            while ((cli.codigo = info.codigo) and (cli.anio = info.anio)) do begin 
                info.mes := cli.mes;
                info.total_mensual := 0;

                while ((cli.codigo = info.codigo) and (cli.anio = info.anio) and (cli.mes = info.mes)) do begin 
                    info.total_mensual := info.total_mensual + cli.venta;
                    leer_archivo(archivo, cli);
                end;

                if (info.monto_mensual > 0) then writeln('Monto Mensual: ', info.total_mensual:0:2);

                info.total_anual := info.total_anual + info.total_mensual;

            end;
            writeln('Monto anual: ', info.total_anual:0:2);
        
        end;

    end;
    close(archivo);
end;

var 
    arch:archivo_cliente;
begin 
    assign(arch, 'clientes.dat');
    informar(arch);
end.


