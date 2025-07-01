{
Suponga que usted es administrador de un servidor de correo electrónico. En los logs del 
mismo (información guardada acerca de los movimientos que ocurren en el server) que se 
encuentra  en  la  siguiente  ruta:  /var/log/logmail.dat  se  guarda  la  siguiente  información: 
nro_usuario,  nombreUsuario,  nombre,  apellido,  cantidadMailEnviados.  Diariamente  el 
servidor  de  correo  genera  un  archivo  con  la  siguiente  información:  nro_usuario, 
cuentaDestino, cuerpoMensaje. Este archivo representa todos los correos enviados por los 
usuarios  en  un  día  determinado.  Ambos  archivos  están  ordenados  por  nro_usuario  y se 
sabe que un usuario puede enviar cero, uno o más mails por día.
}
// /var/log/logmail.dat
unit types;

interface 

const 
    valor_alto = 9999;
    usuarios = 20;
type 

    movimientos = record
        id:integer;
        nombre_usuario:string;
        nombre:string;
        apellido:string;
        cant_mails_enviados:longint;
    end;

    correos = record //cocrreos por usuario
        id:integer;
        cuenta_destino:integer;
        cuerpo_mensaje:string;
    end;

    arch_movimientos = file of movimientos;
    arch_correos = file of correos;

    procedure leer_movimientos(var arch:arch_movimientos; var mov:movimientos);
    procedure leer_correo(var arch:arch_correos; var cor:correos);
    function generar_string():string;

implementation 

    procedure leer_movimientos(var arch:arch_movimientos; var mov:movimientos);
    begin
        if (eof(arch)) then mov.id := valor_alto
        else read(arch, mov);
    end;

    procedure leer_correo(var arch:arch_correos; var cor:correos);
    begin 
        if(eof(arch)) then cor.id := valor_alto
        else read(arch, cor);
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


end.