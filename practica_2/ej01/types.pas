unit types;

interface 

const 
valor_alto = 9999;
type 
    comision = record 
        codigo: integer;
        nombre: string;
        monto: real;
    end;

    arch_comisiones = file of comision;

    arch_resumen_comisiones = file of comision;

procedure leer(var arch:arch_comisiones; var com:comision);

implementation 


procedure leer(var arch:arch_comisiones; var com:comision);
begin 
    if (not eof(arch)) then read(arch, com) 
    else com.codigo := valor_alto;
end;

end.

//codigo, nombre, monto de comision. ordenado por codigo de empleado y cada empleado puede aparecer mas de una vez