program e3;
uses types;
// hay otra forma creo
procedure minimo(var det1,det2:arch_censo; var cen1,cen2,min:censo);
begin 
    if (cen1.provincia <= cen2.provincia) then begin 
        min := cen1;
        leerD(det1, cen1);
    end else begin 
        min := cen2;
        leerD(det2, cen2);
    end;
end;

procedure actualizar_maestro(var maestro:arch_total; var det1, det2: arch_censo);
var     
    total:total_alfabetizados;
    cen1,cen2,min:censo;
begin 
    reset(det1);
    reset(det2);
    reset(maestro);

    leerM(maestro, total);
    
    read(det1, cen1);
    read(det2, cen2);
    minimo(det1,det2, cen1,cen2, min);

    while (min.provincia <> valor_alto) do begin
        while (total.provincia <> min.provincia) do leerM(maestro, total);
        
        while (min.provincia = total.provincia) do begin
            total.alfabetizados := total.alfabetizados + min.alfabetizados;
            total.total_encuestados := total.total_encuestados + min.cantidad_encuestados;
            minimo(det1,det2, cen1,cen2, min);
        end;

        seek(maestro, filepos(maestro) - 1);
        write(maestro, total);
    end;

    close(det1);
    close(det2);
    close(maestro);
end;

procedure imprimirM(var maestro: arch_total);
var 
    total:total_alfabetizados;
begin 
    reset(maestro);
    while (not eof(maestro)) do begin 
        read(maestro, total);
        writeln(total.provincia, ' ', total.alfabetizados);
    end;
    close(maestro);
end;

var 
    maestro:arch_total;
    det1, det2:arch_censo;
begin
    assign(maestro, 'total_argentina.dat');
    assign(det1, 'censo1.dat');
    assign(det2, 'censo2.dat');
    actualizar_maestro(maestro, det1, det2);
    imprimirM(maestro);
end.