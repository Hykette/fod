program generar_archivo;

uses types;

procedure generar_distros(var maestro:arch_maestro);
var     
    i:integer;
    distro:distros;
begin 
    rewrite(maestro);
    distro.nombre := 'a';
    distro.lanzamiento := 0;
    distro.version := 0;
    distro.desarrolladores := 0;
    distro.descripcion := generar_string();
    write(maestro, distro);
    for i:=1 to 20 do begin 
        distro.nombre := distros_iniciales[i];
        distro.lanzamiento := random(50) + 1970;
        distro.version := random(100);
        distro.desarrolladores := random(100) + 1;
        distro.descripcion := generar_string();
        write(maestro, distro);
    end;
    close(maestro);
end;    

var 
    maestro:arch_maestro;
begin 
    assign(maestro, 'maestro.dat');
    generar_distros(maestro);
    imprimir_contenido(maestro);
end.
    
        
