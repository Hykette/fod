{renombrar algunas variables, no se entiende nada}
unit types;

interface

const 

valor_alto = 'zzz';

type 
    total_alfabetizados = record 
        provincia: string;
        alfabetizados: integer;
        total_encuestados: integer;
    end;

    censo = record 
        provincia: string;
        codigo: integer;
        alfabetizados: integer;
        cantidad_encuestados: integer;
    end;

    arch_total = file of total_alfabetizados;

    arch_censo = file of censo;

    procedure leerD(var archD:arch_censo; var cen:censo);
    procedure leerM(var archM:arch_total; var total:total_alfabetizados);

implementation 

procedure leerD(var archD:arch_censo; var cen:censo);
begin 
    if (eof(archD)) then cen.provincia := valor_alto
    else read(archD, cen);
end;

procedure leerM(var archM:arch_total; var total:total_alfabetizados);
begin 
    if (eof(archM)) then total.provincia := valor_alto
    else read(archM, total);
end;

end.
