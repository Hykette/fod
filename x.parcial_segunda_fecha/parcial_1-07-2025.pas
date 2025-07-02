program parcial;

uses types, sysutils;

function indice_minimo(vec_registros:vector_registros):integer;
var 
	i,min,indice:integer;
begin
	min := valor_alto;
	indice := 1;
	for i:=1 to cant_detalles do begin 
		if (vec_registros[i].codigo < min) then begin 
			min := vec_registros[i].codigo;
			indice := i;
		end;
	end;
	indice_minimo := indice;
end;

procedure minimo(var vec_detalles:vector_detalles; var vec_registros:vector_registros; var min:partido);
var 
	i:integer;
begin 
	i := indice_minimo(vec_registros);
	min := vec_registros[i];
	leer_detalle(vec_detalles[i], vec_registros[i]);
end;

procedure actualizar_maestro(var maestro:arch_maestro; var vec_detalles:vector_detalles);
var 
	i:integer;

	min:partido;
	vec_registros:vector_registros;
	registro_maestro:equipo;

	equipo_max:equipo_maximo; //nombre y puntos

	puntos_temporada:integer;

begin 
	// Inicializa el max de puntos de temporada con un valor bajo para que se actualice con cualquier valor
	equipo_max.puntos_temporada := valor_bajo;

	// reset del vector de detalles 
	for i:=1 to cant_detalles do begin 
		reset(vec_detalles[i]);
		leer_detalle(vec_detalles[i], vec_registros[i]);
	end;
	// reset del maestro
	reset(maestro);
	leer_maestro(maestro, registro_maestro);
	
	// registro minimo de los detalles
	minimo(vec_detalles, vec_registros, min);

	while (min.codigo <> valor_alto) do begin 

		// esto no se si deberia ir o no, no especificaba si podia haber equipos sin jugar ningun partido
		while ((registro_maestro.codigo <> min.codigo) and (registro_maestro.codigo <> valor_alto)) do 
		leer_maestro(maestro, registro_maestro);

		// variable para acumular los puntos totales de la temporada
		puntos_temporada := 0;
		while ((registro_maestro.codigo = min.codigo) and (min.codigo <> valor_alto)) do begin 
			// max de puntos de temporada
			puntos_temporada := min.puntos + puntos_temporada;

			// actualizar maestro
			inc(registro_maestro.jugados);
			case registro_maestro.puntos of 
				3: inc(registro_maestro.ganados);
				1: inc(registro_maestro.empatados);
				0: inc(registro_maestro.perdidos);
				else 
			end;
			minimo(vec_detalles, vec_registros, min);
		end;
		// esto tmb actualiza el maestro, aprovechando el acumulador de los puntos de temporada
		registro_maestro.puntos := registro_maestro.puntos + puntos_temporada;
		
		// actualiza el equipo con la mayor cantidad de puntos de la temporada de ser necesario
		if (puntos_temporada > equipo_max.puntos_temporada) then begin 
			equipo_max.puntos_temporada := puntos_temporada;
			equipo_max.nombre := registro_maestro.nombre;
		end;

		// hace el write para actualizar efectivamente el maestro
		seek(maestro, filepos(maestro) - 1);
		write(maestro, registro_maestro);
	
	end;

	// informa el equipo con la mayor cantidad de puntos de la temporada junto con el nombre
	writeln('El equipo que más puntos sumó a lo largo de la temporada fue el equipo ',
	equipo_max.nombre, ' Con un total de ', equipo_max.puntos_temporada, ' puntos');

	// cierra los archivos
	for i:=1 to cant_detalles do begin 
		close(vec_detalles[i]);
	end;
	close(maestro);
end;

var 
	nombre_fisico_maestro:string;
	nombre_fisico_detalle:string;
	path_detalles:string;

	maestro:arch_maestro;
	vec_detalles:vector_detalles;
	i:integer;
begin 
	// el fileExists es para que no se rompa el codigo simplemente, en el examen está de más. O al pedo


	// assing's del maestro
	nombre_fisico_maestro := 'maestro.dat'; // se puede reemplazar por readln
	if (not fileExists(nombre_fisico_maestro)) then begin 
		writeln('Error, uno de los archivos no se pudo encontrar');
		exit();
	end else begin 
		assign(maestro, nombre_fisico_maestro);
	end;

	// assign's de los detalles
	path_detalles := 'detalles/detalle'; // se puede reemplazar por readln para el directorio donde se encuentren los detalles
	for i:=1 to cant_detalles do begin 
		nombre_fisico_detalle := path_detalles + intToStr(i) + '.dat';
		if (not fileExists(nombre_fisico_detalle)) then begin
			writeln('Error, uno de los archivos no se pudo encontrar');
			exit();
		end else begin 
			assign(vec_detalles[i], nombre_fisico_detalle);
		end;
	end;

	actualizar_maestro(maestro, vec_detalles);

end.