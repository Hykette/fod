program generar_archivos;

uses types, sysutils;

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

procedure generar_archivo(var detalle:arch_detalle);
var 
    logs:logins;
    i, j, k, veces:integer;
begin 
    rewrite(detalle);
    with logs do begin 
        for i:=1 to 10 do begin //10 usuarios
            codigo := i;
            for j:=1 to 7 do begin 
                fecha := j;
                veces := random(5) + 1;
                for k:=1 to veces do begin
                    tiempo_sesion := random(1000) + 60;
                    write(detalle, logs);
                end;
            end;
        end;
    end;
    close(detalle);
end;

procedure generar_archivos(var vec_detalles:detalles);
var
    i:integer;
begin 
    for i:=1 to dimF do begin 
        generar_archivo(vec_detalles[i]);
    end;
end;

function registro_minimo(vec_logs:vector_logs):integer;
var 
    i, j:integer; // por que no puedo hacer dos loops con i?
    minimo_codigo:integer; // con esta variable se imprime en orden el codigo 
    minimo_fecha:integer;  // con esta variable se imprime en orden ambos
    indice:integer;
begin 
    minimo_codigo := valor_alto; minimo_fecha := valor_alto;

    for i:=1 to dimF do begin 
        if ((vec_logs[i].codigo < minimo_codigo) or ((vec_logs[i].codigo = minimo_codigo) and (vec_logs[i].fecha < minimo_fecha)))then begin 
            minimo_codigo := vec_logs[i].codigo;
            minimo_fecha := vec_logs[i].fecha;
            indice := i;
        end;
    end;
    registro_minimo := indice;
end;

procedure minimo(var vec_detalles:detalles; var vec_logs:vector_logs; var min:logins);
var 
    i:integer;
begin 
    i := registro_minimo(vec_logs);
    min := vec_logs[i];
    leerD(vec_detalles[i], vec_logs[i]);
end;

procedure leer_detalles(var vec_detalles:detalles; var vec_logs:vector_logs);
var 
    i:integer;
begin 
    for i:=1 to dimF do begin 
        reset(vec_detalles[i]);
        read(vec_detalles[i], vec_logs[i]);
    end;
end;

procedure cerrar_detalles(var vec_detalles:detalles);
var 
    i:integer;
begin 
    for i:=1 to dimF do begin 
        close(vec_detalles[i]);
    end;
end;

procedure imprimir_detalles(var vec_detalles:detalles);
var 
    min, aux, aux2:logins;
    vec_logs:vector_logs;
    i:integer;
begin 
    for i:=1 to dimF do begin 
        reset(vec_detalles[i]);
        read(vec_detalles[i], vec_logs[i]);
    end;

    minimo(vec_detalles, vec_logs, min);

    while (min.codigo <> valor_alto) do begin 
        aux := min;
        writeln();
        writeln();
        write('codigo: ', min.codigo);
        while ((min.codigo = aux.codigo) and (min.codigo <> valor_alto)) do begin 

            aux2 := min;
            writeln();
            write('fecha ', aux2.fecha, ': ', '|');

            while ((aux2.fecha = min.fecha) and (aux2.codigo = min.codigo) and (min.codigo <> valor_alto)) do begin 
                write(min.tiempo_sesion:0:2, '|');
                minimo(vec_detalles, vec_logs, min);
            end;

        end;
    end;

    for i:=1 to dimF do begin 
        close(vec_detalles[i]);
    end;
end;

var 
    vector_detalles:detalles;
    path:string;
    i:integer;
    nombre_fisico:string;
begin 
    randomize;
    path:= 'var/detalles/detalle'; //i.dat'
    for i:=1 to dimF do begin 
        nombre_fisico := path + IntToStr(i) + '.dat';
        assign(vector_detalles[i], nombre_fisico);
    end;
    generar_archivos(vector_detalles);
    imprimir_detalles(vector_detalles);
end.


