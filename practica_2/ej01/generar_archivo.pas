program generar_archivo;

uses types;

function generar_string():string;
const
    caracteres = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
    i, longitud: integer; aux: string;

begin
    aux := '';
    longitud := 5;
    for i := 1 to longitud do begin
        aux := aux + caracteres[Random(52) + 1]; 
    end;
    generar_string := aux;
end;

procedure generar_archivo(var arch:arch_comisiones);
var 
    com: comision;
    i, j: integer;  
    cantidad: integer;
begin 
    rewrite(arch);
    with com do begin 
        for i := 1 to 20 do begin 
            // que si o si cada empleado tenga una comision
            cantidad := random(5) + 1; 
            codigo := i;
            nombre := generar_string();
            for j := 1 to cantidad do begin 
                monto := random(100000) + (1 / (random(10) + 1));
                write(arch, com);
            end;
        end;
    end;
    close(arch);
end;



procedure imprimir_archivo(var arch:arch_comisiones);
var 
    com: comision;
    aux: integer;
begin 
    reset(arch);
    leer(arch, com);
    while (com.codigo <> valor_alto) do begin 
        aux := com.codigo;
        writeln(com.nombre, ' ', com.codigo, ':');
        write('Valor comisiones: ');
        while ((com.codigo <> valor_alto) and (com.codigo = aux)) do begin 
            write(com.monto:0:2, '|');
            leer(arch, com);
        end;
        writeln();
    end;
    close(arch);
end;
        

var 
    arch: arch_comisiones;
begin 
    assign(arch, 'comisiones.dat');
    generar_archivo(arch);
    imprimir_archivo(arch);
end.



