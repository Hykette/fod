{
Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados. 
De cada producto se almacena: código del producto, nombre, descripción, stock disponible, 
stock mínimo y precio del producto. 
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se 
debe  realizar  el  procedimiento  que  recibe  los  30  detalles y actualiza el stock del archivo 
maestro. 
 La  información  que  se  recibe  en los detalles es: código de producto y cantidad 
vendida.  Además,  se  deberá  informar  en  un  archivo  de  texto: 

 nombre  de  producto, 
descripción, stock disponible y precio de aquellos productos que tengan stock disponible por 
debajo  del  stock  mínimo.  
Pensar  alternativas  sobre  realizar  el  informe  en  el  mismo 
procedimiento  de  actualización,  o  realizarlo  en  un  procedimiento  separado  (analizar 
ventajas/desventajas en cada caso)
}

unit types;

interface 

const valor_alto = 9999;
const dimF = 30;

type 

    producto = record
        codigo: integer;
        nombre: string;
        descripcion: string;
        stock_disponible: integer;
        stock_minimo: integer;
        precio: real;
    end;

    ventas = record
        codigo: integer;
        cantidad:integer;
    end;

    informe = record
        nombre: string;
        descripcion: string;
        stock_disponible: integer;
        poco_stock_precio: real;
    end;

    arch_maestro = file of producto;

    arch_detalle = file of ventas;  

    arch_informe = file of Text;

    detalles = array[1..dimF] of arch_detalle;

    vector_ventas = array[1..dimF] of ventas;

    procedure leerD(var detalle:arch_detalle; var ven:ventas);
    procedure leerM(var maestro:arch_maestro; var prod:producto);

implementation 

    procedure leerD(var detalle:arch_detalle; var ven:ventas);
    begin 
        if (eof(detalle)) then ven.codigo := valor_alto
        else read(detalle, ven);
    end;

    procedure leerM(var maestro:arch_maestro; var prod:producto);
    begin 
        if(eof(maestro)) then prod.codigo := valor_alto
        else read(maestro, prod);
    end;

end.
