unit types;

interface 
const
    valor_alto = 9999;
type

    alumno = record 
        codigo_alumno:integer;
        apellido:string;
        nombre:string;
        cursadas_aprobadas:integer;
        finales_aprobados:integer;
    end;

    cursadas = record
        codigo_alumno:integer;
        codigo_materia:integer;
        anio_cursada:integer;
        resultado:boolean;
    end;

    finales = record 
        codigo_alumno:integer;
        codigo_materia:integer;
        fecha:integer;
        nota:integer;
    end;
    
    arch_finales = file of finales;
    arch_cursadas = file of cursadas;
    //ambos ordenados por codigo_alumno y materia
    // y pueden contener 0, 1 o más registros por alumno 
    arch_maestro = file of alumno;

implementation 

end.
