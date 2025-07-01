program e10;
uses crt, sysutils, types;

function registro_minimo(vector_mesas:vec_mesas):integer;
var 
    i:integer;
    minimo_provincia:integer;
    minimo_localidad:integer;
    indice:integer;
begin 
    indice := 1; 
    minimo_provincia:=valor_alto;
    minimo_localidad:=valor_alto;
    for i:=1 to dimF do begin 
        if ((vector_mesas[i].codigo_provincia < minimo_provincia) or (

            (vector_mesas[i].codigo_provincia = minimo_provincia) and
            (vector_mesas[i].codigo_localidad < minimo_localidad)
        )) then begin 
            minimo_provincia := vector_mesas[i].codigo_provincia;
            minimo_localidad := vector_mesas[i].codigo_localidad;
            indice := i;
        end;
    end;
    registro_minimo := indice;
end;

procedure minimo(var archivos:vector_archivo; var vector_mesas:vec_mesas; var min:mesas);
var 
    i:integer;
begin 
    i := registro_minimo(vector_mesas);
    min := vector_mesas[i];
    leer_archivo(archivos[i], vector_mesas[i]);
end;


procedure informe_archivo(var archivos:vector_archivo);
var
    min:mesas;
    i:integer;
    informe:informes;
    vector_mesas:vec_mesas;
begin 
    for i:=1 to dimF do begin 
        reset(archivos[i]);
        leer_archivo(archivos[i], vector_mesas[i]);
    end;
    minimo(archivos, vector_mesas, min);
    informe.total := 0;
    while (min.codigo_provincia <> valor_alto) do begin 

        informe.codigo_provincia := min.codigo_provincia;
        informe.total_provincia := 0;
        writeln('Provincia: ', informe.codigo_provincia);
        writeln('Codigo localidad               |             Total De Votos');

        while ((min.codigo_provincia <> valor_alto) and (informe.codigo_provincia = min.codigo_provincia)) do begin 
            informe.codigo_localidad := min.codigo_localidad;
            informe.total_localidad := 0;
            write(informe.codigo_localidad, '                                            ');
            
            while ((min.codigo_provincia <> valor_alto) and 
            (min.codigo_provincia = informe.codigo_provincia) and 
            (min.codigo_localidad = informe.codigo_localidad)) do begin 

                informe.total_localidad := informe.total_localidad + min.votos;
                minimo(archivos, vector_mesas, min);

            end;
            write(informe.total_localidad); writeln();
            informe.total_provincia := informe.total_provincia + informe.total_localidad;

        end;
        writeln('Total de votos de la provincia: ', informe.total_provincia);
        informe.total := informe.total + informe.total_provincia;

    end;
    writeln(); writeln();
    writeln('Total de votos:           ', informe.total);

    for i:=1 to dimF do begin 
        close(archivos[i]);
    end;

end;

var 
    archivos:vector_archivo;
    i:integer;
    path, nombre_fisico:string;
begin 
    path := './detalles/detalle';
    for i:=1 to dimF do begin 
        nombre_fisico := path + IntToStr(i) + '.dat';
        assign(archivos[i], nombre_fisico);
    end;
    informe_archivo(archivos);
end.


