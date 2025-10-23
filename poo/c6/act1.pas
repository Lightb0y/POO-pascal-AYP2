unit UMercaderia;
{$mode objfpc}

interface

uses 
  SysUtils, GenericLinkedList; // Necesitamos la lista genérica

type
  { --- Definición de la clase Producto --- }
  Producto = class
  private
    descripcion: string;     
    precioPorKilo: real;    
  public
    constructor create(unaDescripcion: string; unPrecioPorKilo: real); 
    function getPrecioPorKilo(): real;     
    function getDescripcion(): string;   
  end;
  
  // Especializamos la lista para que contenga objetos Producto
  ListaProductos = specialize LinkedList<Producto>;

  { --- Definición de la clase Mercaderia --- }
  Mercaderia = class
  private
    precios: ListaProductos; 
  public
    constructor create; 
    destructor destroy; override;
    procedure agregarProducto(unProducto: Producto); 
    function getProducto(unaDescripcion: string): Producto; 
  end;

implementation

{ --------------------------------------- }
{ --- Implementación de la clase Producto --- }
{ --------------------------------------- }

constructor Producto.create(unaDescripcion: string; unPrecioPorKilo: real);
begin
  self.descripcion := unaDescripcion;
  self.precioPorKilo := unPrecioPorKilo;
end;

function Producto.getPrecioPorKilo(): real;
begin
  getPrecioPorKilo := self.precioPorKilo;
end;

function Producto.getDescripcion(): string;
begin
  getDescripcion := self.descripcion;
end;

{ ----------------------------------------- }
{ --- Implementación de la clase Mercaderia --- }
{ ----------------------------------------- }

constructor Mercaderia.create;
begin
  // Creamos la lista de precios (productos)
  self.precios := ListaProductos.create();
end;

destructor Mercaderia.destroy;
var
  p: Producto;
begin
  // Es importante liberar la memoria de todos los productos
  // que están en la lista antes de liberar la lista misma.
  self.precios.reset();
  while not self.precios.eol() do
  begin
    p := self.precios.removeCurrent(); // Saca el producto de la lista
    p.free; // Libera la memoria del objeto Producto
  end;
  
  self.precios.free; // Libera la memoria de la lista
  inherited destroy;
end;

procedure Mercaderia.agregarProducto(unProducto: Producto);
begin
  // Agregamos el producto a la lista
  self.precios.add(unProducto);
end;

function Mercaderia.getProducto(unaDescripcion: string): Producto;
var
  p_actual: Producto;
  encontrado: boolean;
begin
  encontrado := false;
  p_actual := nil;
  self.precios.reset();
  
  // Buscamos el producto por su descripción
  while (not self.precios.eol()) and (not encontrado) do
  begin
    p_actual := self.precios.current();
    if (p_actual.getDescripcion() = unaDescripcion) then
      encontrado := true
    else
      self.precios.next();
  end;
  
  // Si lo encontramos, lo devolvemos. Si no, devolvemos nil.
  if encontrado then
    getProducto := p_actual
  else
    getProducto := nil;
end;

end.
