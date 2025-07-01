unit types;

interface 

const 
    
    distros_iniciales: array[1..20] of string = (
        'Arch Linux', 'Debian', 'Fedora', 'Ubuntu', 'CentOS',
        'Mint', 'openSUSE', 'Manjaro', 'Kali Linux', 'Zorin OS',
        'Pop!_OS', 'Elementary OS', 'Slackware', 'Gentoo', 'RHEL',
        'MX Linux', 'Deepin', 'Parrot OS', 'Solus', 'Lubuntu'
    );

    distros_adicionales: array[1..10] of string = (
        'Puppy Linux', 'Alpine Linux', 'Void Linux', 'Kubuntu',
        'Xubuntu', 'Linux Lite', 'antiX', 'Qubes OS', 'Clear Linux', 'Tails'
    );

    valor_alto = 'ZZZ';
type 

    distros = record
        nombre:string; 
        lanzamiento:integer;
        version:integer;
        // desarrolladores como indice
        desarrolladores:integer;
        descripcion:string;
    end;

    arch_maestro = file of distros;

    procedure leer_maestro(var maestro:arch_maestro;var distro:distros);
    function generar_string():string;
    procedure imprimir_contenido(var maestro:arch_maestro);
    procedure nueva_distro(var distro:distros);
    
implementation 

    procedure leer_maestro(var maestro:arch_maestro; var distro:distros);
    begin 
        if (eof(maestro)) then distro.nombre := valor_alto
        else read(maestro, distro);
    end;

    procedure imprimir_contenido(var maestro:arch_maestro);
    var 
        distro:distros;
    begin 
        reset(maestro);
        while (not eof(maestro)) do begin 
            read(maestro, distro);
            write(distro.nombre, '|', distro.desarrolladores, '|  ');
        end;
        close(maestro);
        writeln();
    end;

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

    procedure nueva_distro(var distro:distros);
    begin 
        if (random(100) > 60) then distro.nombre := distros_iniciales[random(20) + 1]
        else distro.nombre := distros_adicionales[random(10) + 1];
        
        distro.lanzamiento := random(50) + 1970;
        distro.version := random(100);
        distro.desarrolladores := random(100) + 1;
        distro.descripcion := generar_string();
    end;

end.

{
onoce: nombre, año de lanzamiento, número de 
versión  del  kernel,  cantidad  de  desarrolladores  y  descripción
}

{
Este archivo debe ser mantenido realizando bajas 
lógicas y utilizando la técnica de reutilización de espacio libre llamada lista invertida. 
Escriba  la  definición  de  las  estructuras  de  datos  necesarias  y  los  siguientes 
procedimientos:

}