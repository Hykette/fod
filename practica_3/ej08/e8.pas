program e8;

uses types;

function buscar_distro(var maestro:arch_maestro; nombre:string):integer;
var 
    distro:distros;
begin 

    seek(maestro, 1); //se saltea la cabecera
    leer_maestro(maestro, distro);
    while ((distro.nombre <> valor_alto) and (distro.nombre <> nombre)) do leer_maestro(maestro, distro);

    if ((distro.nombre = nombre) and (distro.desarrolladores > 0)) then buscar_distro := filepos(maestro) - 1
    else buscar_distro := -1;

end;


procedure baja_distro(var maestro:arch_maestro);
var 
    distro:distros;
    aux:distros;
    nombre:string;
    indice:integer;
begin 
    reset(maestro);
    writeln('nombre de distro a borrar');
    readln(nombre);

    indice := buscar_distro(maestro, nombre);

    if (indice <> -1) then begin 
        seek(maestro, indice);
        read(maestro, distro);
        seek(maestro, 0);
        read(maestro, aux);

        distro.desarrolladores := aux.desarrolladores;
        aux.desarrolladores := indice * -1;

        seek(maestro, 0);
        write(maestro, aux);
        seek(maestro, indice);
        write(maestro, distro);
    end else writeln('distro no existente');

    close(maestro);
end;

procedure alta_distro(var maestro:arch_maestro; distro:distros);
var 
    aux:distros;
begin 
    reset(maestro);

    if (buscar_distro(maestro, distro.nombre) <> -1) then begin 
        seek(maestro, 0);
        read(maestro, aux);
        if (aux.desarrolladores = 0) then begin 
            seek(maestro, filesize(maestro));
            write(maestro, distro);
        end else begin 
            seek(maestro, (aux.desarrolladores * -1));
            read(maestro, aux);
            seek(maestro, filepos(maestro) -1);
            write(maestro, distro);

            seek(maestro, 0); 
            read(maestro, distro);
            seek(maestro, 0);
            distro.desarrolladores := aux.desarrolladores;
            write(maestro, distro); //queda la cabecera con nuevos valores
        end;
    end else writeln('ya existe la distro ', distro.nombre);
    
    close(maestro);
end;

var 
    maestro:arch_maestro;
    distro:distros;
    eleccion:integer;
    nombre_distro:string;
    indice:integer;
begin 
    assign(maestro, 'maestro.dat');
    writeln('0.cerrar 1.eliminar 2.agregar distro 3.buscar distro 4.imprimir contenido');
    readln(eleccion);
    while (eleccion <> 0) do begin 
        case eleccion of 
            1: baja_distro(maestro);
            2:  begin 
                    nueva_distro(distro);
                    alta_distro(maestro, distro);
                end;
            3:  begin 
                    writeln('nombre de distro a buscar');
                    readln(nombre_distro);
                    reset(maestro);
                    indice := buscar_distro(maestro, nombre_distro);
                    close(maestro);
                    if (indice <> -1) then writeln('Distro encontrada en la pos', indice) 
                    else writeln('distro no encontrada');
                end;
            4: imprimir_contenido(maestro);
            0: exit();
            else writeln('?');
        end;
        writeln('0.cerrar 1.eliminar 2.agregar distro 3.buscar distro 4.imprimir contenido');
        readln(eleccion);
    end;
end.
        
        
            
    
