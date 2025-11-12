program ListadoDeProductos;
{$mode objfpc}

uses UProducto,UOrdenador,UCriterio,UComparador,URandomGenerator, UDateTime, GenericLinkedList;

const CANT_PRODS = 10;
procedure armarOrdenador(var ord: Ordenador);
var i: integer; p:producto;
	f1, f2: Date;
	rg: RandomGenerator;
	descripcion: string;
	precio: real;
	stock: integer;
	fechaVenc: Date;
	desc: array[1..CANT_PRODS] of string = ('Azucar', 'Yerba', 'Cafe', 'Te', 'Harina', 'Fideo', 'Arveja', 
											'Lenteja', 'Polenta', 'Pure de tomate');
begin
rg:= RandomGenerator.create();
f1:= Date.create(1, 1, 2025);
f2:= Date.create(30, 4, 2026);

// Crear un Ordenador con Comparador de precios y criterio ascendente
ord:= ordenador.create(comparadorPorPrecio.create(),OrdenAscendente.create());
///////////////////////////////////////////////////////////////////

for i:= 1 to CANT_PRODS do
	begin
	descripcion:= desc[i];
	precio:= rg.getReal(10, 1000);
	stock:= rg.getInteger(0, 500);
	fechaVenc:= rg.getDate(f1, f2);
	// Crear un producto con la descripción, precio, stock y fecha de vencimiento dadas
	// Agregue el producto al Ordenador
     p:=producto.create(descripcion,precio,stock,fechaVenc);
     ord.agregarObjeto(p);
	/////////////////////////////////////////////////////////////////////////	
	end;
end;


var ord: Ordenador;
	lista: liComparables;
begin 
// Inicializa con comparador por precio ascendente por defecto
armarOrdenador(ord);


writeln('Todos los productos ordenados ascendentemente por precio');

// Pida la lista al ordenador
lista:= ord.getLista();
///////////////////////////////////////////////////////////

lista.reset();
while not lista.eol() do
	begin
	writeln((lista.current() as Producto).getDescripcion():16, (lista.current() as Producto).getPrecio():8:2);
	lista.next();
	end;
writeln('*********************************************************');

writeln('Todos los productos ordenados ascendentemente por stock');

// Setee un comparador por stock
// Pida la lista al ordenador
ord.setComparador(comparadorPorStock.create());
lista:= ord.getLista();
///////////////////////////////////////////////////////////

lista.reset();
while not lista.eol() do
	begin
	writeln((lista.current() as Producto).getDescripcion():16, (lista.current() as Producto).getStock():8);
	lista.next();
	end;
writeln('*********************************************************');

writeln('Todos los productos ordenados descendentemente por fecha de vencimiento');

// Setee un comparador por fecha de vencimiento
// Setee un criterio de orden descendente
// Pida la lista al ordenador
ord.setComparador(comparadorPorVencimiento.create());
ord.setCriterio(ordenDescendente.create());
lista:= ord.getlista();
///////////////////////////////////////////////////////////

lista.reset();
while not lista.eol() do
	begin
	writeln((lista.current() as Producto).getDescripcion():16, (lista.current() as Producto).getVencimiento().toString():12);
	lista.next();
	end;
writeln('*********************************************************');
end.
