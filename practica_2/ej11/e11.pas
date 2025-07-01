program e11;

uses types;

procedure txt_a_vector(var txt_montos:TextFile; var vector:extras_por_categoria);
var 
    i:integer;
    aux:integer;
begin 
    reset(txt_montos);
    for i:=1 to 15 do begin 
        read(txt_montos, aux, vector[i]);
    end;
    close(txt_montos);
end;

procedure informar(var arch:archivo; var txt_montos:TextFile);
var 
    info:informe;
    emp:empleado;
    extras:extras_por_categoria;
begin 
    reset(arch);
    leer_archivo(arch, emp);
    txt_a_vector(txt_montos, extras);

    while (emp.departamento <> valor_alto) do begin 
        info.departamento := emp.departamento;
        info.total_monto_departamento := 0;
        info.total_horas_departamento := 0;
        writeln('Departamento ', info.departamento);
        while (emp.departamento = info.departamento) do begin 
            info.division := emp.division;
            info.total_horas_division := 0;
            info.total_monto_division := 0;
            writeln('   Division: ', info.division);
            writeln('       Numero de empleado          Total de Hs.              importe a cobrar');
            while ((emp.departamento = info.departamento) and (emp.division = info.division)) do begin 
                info.numero := emp.numero;
                info.total_horas_empleado := 0;
                info.total_monto_empleado := 0;
                info.categoria := emp.categoria;


                while ((emp.departamento = info.departamento) and (emp.division = info.division) and (emp.numero = info.numero)) do begin 
                    info.total_horas_empleado := info.total_horas_empleado + emp.horas_extra;
                    leer_archivo(arch, emp);
                end;


                info.total_monto_empleado := info.total_horas_empleado * extras[info.categoria];
                writeln('       ', info.numero, '                          ', info.total_horas_empleado, '                        ', info.total_monto_empleado:0:2);
                info.total_horas_division := info.total_horas_division + info.total_horas_empleado;
                info.total_monto_division := info.total_monto_division + info.total_monto_empleado;
            end;

            info.total_horas_departamento := info.total_horas_departamento + info.total_horas_division;
            info.total_monto_departamento := info.total_monto_departamento + info.total_monto_division;
            writeln('   Total Horas Division: ', info.total_horas_division);
            writeln('   Total Monto Division: ', info.total_monto_division:0:2);
            writeln('================================================================================');
            writeln();
        end;
        writeln('Total Horas Departamento: ', info.total_horas_departamento);
        writeln('Total Monto Departamento: ', info.total_monto_departamento:0:2);
        writeln('================================================================================');
        writeln();
    end;
    close(arch);
end;

var 
    arch:archivo;
    txt:TextFile;
begin 
    assign(arch, 'empleados.dat');
    assign(txt, 'Monto_de_horas_extra_por_categoria.txt');
    informar(arch, txt);
end.

            
