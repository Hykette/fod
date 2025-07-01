program generar_archivo;

uses types;

procedure generar_archivo(var arch:archivo);
var 
    emp:empleado;
    i, j, k, l, empleado:integer;
begin 
    empleado := 0;
    rewrite(arch);
    for i:=1 to 5 do begin 
        emp.departamento := i;
        for j:=1 to 5 do begin 
            emp.division := j;
            for k:=1 to 5 do begin 
                emp.numero := empleado;
                emp.categoria := random(15) + 1;
                inc(empleado);
                for l:=1 to 30 do begin 
                    emp.horas_extra := random(4);
                    write(arch, emp);
                end;
            end;
        end;
    end;
    close(arch);
end;

procedure imprimir_archivo(var arch:archivo);
var 
    emp:empleado;
    aux:empleado;
begin 
    reset(arch);
    leer_archivo(arch, emp);

    while (emp.departamento <> valor_alto) do begin 
        aux.departamento := emp.departamento;
        writeln('departamento: ', aux.departamento);
        while (emp.departamento = aux.departamento) do begin 
            aux.division := emp.division;
            writeln('division: ', aux.division);
            while ((emp.departamento = aux.departamento) and (emp.division = aux.division)) do begin 
                aux.numero := emp.numero;
                write('Empleado: ', aux.numero);
                while ((emp.departamento = aux.departamento) and (emp.division = aux.division) and (emp.numero = aux.numero)) do begin 
                    write('|', emp.horas_extra);
                    leer_archivo(arch, emp);
                end;
                writeln();
            end;
            writeln();
        end;
        writeln();
    end;
    close(arch);
end;

var 
    arch:archivo;
begin 
    assign(arch, 'empleados.dat');
    generar_archivo(arch);
    imprimir_archivo(arch);
end.
    
