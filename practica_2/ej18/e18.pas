program e18;

uses types;

procedure informar(var maestro:arch_maestro; var arch_informe:text);
var 
    caso:casos;
    info:informe;
begin
    rewrite(arch_informe);
    reset(maestro);
    leer_maestro(maestro, caso);
    while (caso.codigo_localidad <> valor_alto) do begin 
        //info como aux
        info.codigo_localidad := caso.codigo_localidad;
        info.casos_localidad := 0;
        info.nombre_localidad := caso.nombre_localidad;
        writeln('Localidad: ', info.codigo_localidad);
        while (caso.codigo_localidad = info.codigo_localidad) do begin 
            info.codigo_municipio := caso.codigo_municipio;
            info.casos_municipio := 0;
            info.nombre_municipio := caso.nombre_municipio;
            writeln('   Municipio: ', info.codigo_municipio);
            while ((caso.codigo_localidad = info.codigo_localidad) and (caso.codigo_municipio = info.codigo_municipio)) do begin 
                info.codigo_hospital := caso.codigo_hospital;
                info.casos_hospital := 0;
                //no hace falta el nombre del hospital en el txt
                while ((caso.codigo_localidad = info.codigo_localidad) and (caso.codigo_municipio = info.codigo_municipio) and (caso.codigo_hospital = info.codigo_hospital)) do begin 
                    info.casos_hospital := info.casos_hospital + caso.casos_positivos;
                    leer_maestro(maestro, caso);
                end;
                writeln('        Hospital:', info.codigo_hospital, '        Casos: ', info.casos_hospital);
                info.casos_municipio := info.casos_municipio + info.casos_hospital;
                
            end;
            info.casos_localidad := info.casos_localidad + info.casos_municipio;
            writeln('   Cantidad casos Municipio: ', info.casos_municipio);
            if (info.casos_municipio > 1500) then writeln(arch_informe, info.nombre_localidad, ' ', info.nombre_municipio, ' ', info.casos_municipio);
        end;

        writeln('Cantidad casos localidad: ', info.casos_localidad);
    end;
    close(arch_informe);
    close(maestro);
end;

var 
    maestro:arch_maestro;
    arch_informe:text;
begin 
    assign(maestro, 'maestro.dat');
    assign(arch_informe, 'informe.txt');
    informar(maestro, arch_informe);
end.