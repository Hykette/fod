unit types;

{
  Presentar  en  pantalla  un  listado  con  el 
siguiente formato:

1 5000
2 10000 y asi en el txt


departamento, 
división,  número  de  empleado,  categoría  y  cantidad  de  horas  extras  realizadas  por  el 
empleado. 

ordenado  por  departamento,  luego  por 
división  y,  por  último,  por  número  de  empleado.

Departamento 
    División 
    Número de Empleado    Total de Hs.   Importe a cobrar 
    ......                                ..........               .........    
    ......                                ..........               .........    
    Total de horas división:  ____ 
    Monto total por división: ____ 
Total horas departamento: ____ 
Monto total departamento: ____

Para obtener el valor de la hora se debe cargar un arreglo desde un archivo de texto al 
iniciar el programa con el valor de la hora extra para cada categoría. La categoría varía 
de 1 a 15. En el archivo de texto debe haber una línea para cada categoría con el número 
de categoría y el valor de la hora, pero el arreglo debe ser de valores de horas, con la 
posición del valor coincidente con el número de categoría

}

interface 

const 
    valor_alto = 9999;

type

    empleado = record
        departamento:integer;
        division:integer;
        numero:integer;
        categoria:integer;
        horas_extra:integer;
    end;

    informe = record
        departamento:integer;
        division:integer;
        numero:integer;
        categoria:integer;
        total_horas_empleado:integer;
        total_monto_empleado:real;
        total_horas_division:integer;
        total_monto_division:real;
        total_horas_departamento:integer;
        total_monto_departamento:real;
    end;

    extras_por_categoria = array[1.. 15] of real;
    archivo = file of empleado;
    texto = file of text;

    procedure leer_archivo(var arch:archivo; var emp:empleado);

implementation

    procedure leer_archivo(var arch:archivo; var emp:empleado);
    begin 
        if eof(arch) then emp.departamento := valor_alto
        else read(arch, emp);
    end;

end.
