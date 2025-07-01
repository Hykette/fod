program generar_archivo;

uses types;

procedure generar_archivos(var arch_1:arch_movimientos; var arch_2:arch_correos);
var 
    correo:correos;
    mov:movimientos;
    i, j, veces:integer;
begin 
    rewrite(arch_1);
    rewrite(arch_2);
    for i:=1 to usuarios do begin 
        mov.id := i; 
        mov.nombre_usuario := generar_string();
        mov.nombre := generar_string();
        mov.apellido := generar_string();
        mov.cant_mails_enviados := 0;
        write(arch_1, mov);

        correo.id := i;
        veces := random(10) + 1;
        for j := 1 to veces do begin 
            correo.cuenta_destino := random(usuarios) + 1;
            correo.cuerpo_mensaje := generar_string();
            write(arch_2, correo);
        end;
    end;
    close(arch_1);
    close(arch_2);
end; 

procedure imprimir_correo(var arch:arch_correos);
var 
    correo:correos;
    aux:integer;
begin 
    reset(arch);
    leer_correo(arch, correo);
    while (correo.id <> valor_alto) do begin 
        aux := correo.id;
        writeln('id:                 cuenta destino:');
        writeln('===========================================');
        while (correo.id = aux) do begin 
            writeln(correo.id, '                   ', correo.cuenta_destino);
            leer_correo(arch, correo);
        end;
        writeln();
    end;
    close(arch);
end;

var 
    movs: arch_movimientos;
    cor: arch_correos;
begin 
    randomize;
    assign(movs, './var/log/logmail.dat');
    assign(cor, './var/mails/mails.dat');
    generar_archivos(movs, cor);
    imprimir_correo(cor);
end.

{
ambos archivos estan ordenados por numero de usuario pero 
un archivo contiene x usuarios porque es un archivo de mails 
usuario (origen) destinatario (destino) mail (contenido)
y el otro
usuario (usuario) mails que mando (conteo de mails)

o sea que es un corte control de un orden
}