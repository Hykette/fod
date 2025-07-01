program generar_archivos;

uses types;

type 
    provincias = array[1..24] of string;

procedure generar_archivoD(var archD:arch_censo; vector:provincias);
var 
    cen:censo;
    i, j:integer;
    veces:integer;
begin 
    rewrite(archD);
    with cen do begin 
        // provincia
        for i:=1 to 24 do begin 
            provincia := vector[i];
            veces := random(5) + 1;
            // localidad
            for j:=1 to veces do begin
                codigo := random(100);
                alfabetizados := random(50);
                cantidad_encuestados := random(50) + 1;
                write(archD, cen);
            end;
        end;
    end;
    close(archD);
end;
// meter todas las provincias y hacer un random por localidad

procedure generar_archivoM(var archM:arch_total; vector:provincias);
var 
    total:total_alfabetizados;
    i:integer;
begin 
    rewrite(archM);
    with total do begin 
        for i:=1 to 24 do begin 
            provincia := vector[i];
            alfabetizados := 0;
            total_encuestados := 0;
            write(archM, total);
        end;
    end;
    close(archM);
end;


procedure iniciar_arreglo(var vector:provincias);
begin 
    vector[1] := 'Buenos Aires';
    vector[2] := 'Catamarca';
    vector[3] := 'Chaco';
    vector[4] := 'Chubut';
    vector[5] := 'Ciudad Autonoma de Buenos Aires';
    vector[6] := 'Cordoba';
    vector[7] := 'Corrientes';
    vector[8] := 'Entre Rios';
    vector[9] := 'Formosa';
    vector[10] := 'Jujuy';
    vector[11] := 'La Pampa';
    vector[12] := 'La Rioja';
    vector[13] := 'Mendoza';
    vector[14] := 'Misiones';
    vector[15] := 'Neuquen';
    vector[16] := 'Rio Negro';
    vector[17] := 'Salta';
    vector[18] := 'San Juan';
    vector[19] := 'San Luis';
    vector[20] := 'Santa Cruz';
    vector[21] := 'Santa Fe';
    vector[22] := 'Santiago del Estero';
    vector[23] := 'Tierra del Fuego';
    vector[24] := 'Tucuman';
end;

procedure imprimir_maestro(var archM:arch_total);
var 
    total:total_alfabetizados;
begin 
    reset(archM);
    while (not eof(archM)) do begin 
        read(archM, total);
        write(total.alfabetizados, ' |');
    end;
    close(archM);
end;

procedure imprimir_detalle(var det1:arch_censo; var det2:arch_censo);
var 
    cen1:censo;
    cen2:censo;
begin 
    reset(det1);
    reset(det2);
    read(det1, cen1);
    read(det2, cen2);
    write('Buenos Aires: ');
    while(cen1.provincia = 'Buenos Aires') do begin 
        write(cen1.alfabetizados, '|');
        read(det1, cen1);
    end;
    while(cen2.provincia = 'Buenos Aires') do begin
        write(cen2.alfabetizados, '|');
        read(det2, cen2);
    end;
    writeln();
    close(det1);
    close(det2);
end;

var
    maestro:arch_total;
    detalle1, detalle2:arch_censo;
    prov:provincias;
begin
    randomize;
    iniciar_arreglo(prov);
    assign(detalle1, 'censo1.dat');
    assign(detalle2, 'censo2.dat');
    assign(maestro, 'total_argentina.dat');
    generar_archivoD(detalle1, prov);
    generar_archivoD(detalle2, prov);
    generar_archivoM(maestro, prov);
    imprimir_detalle(detalle1, detalle2);
    imprimir_maestro(maestro);
end.
