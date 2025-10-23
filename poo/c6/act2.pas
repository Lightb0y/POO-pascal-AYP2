unit UCarniceria;
{$mode objfpc}

interface

uses
  UMercaderia, UBalanza, URandomGenerator; // Unidades que componen al Carnicero

type
  Carnicero = class
  private
    nombre: string;
    mercaderia: Mercaderia; // <-- Composición "Tiene una" Mercaderia
    balanza: Balanza;     // <-- Composición "Tiene una" Balanza
  public
    constructor create(unNombre: string);
    destructor destroy; override;
    procedure comenzarCompra();
    procedure llevo(unaDescripcion: string; unPeso: real);
    function finalizarCompra(): real;
  end;

implementation

constructor Carnicero.create(unNombre: string);
var
  rg: RandomGenerator;
  i: integer;
  descProducto: string;
begin
  self.nombre := unNombre;
  
  // 1. El constructor crea sus componentes internos
  self.mercaderia := Mercaderia.create();
  self.balanza := Balanza.create();
  
  // 2. Cargamos el RandomGenerator con los NOMBRES de productos posibles
  rg := RandomGenerator.create;
  rg.addLabel('Lomo');
  rg.addLabel('Vacio');
  rg.addLabel('Asado');
  rg.addLabel('Nalga');
  rg.addLabel('Peceto');
  rg.addLabel('Pollo');
  rg.addLabel('Milanesa');
  rg.addLabel('Chorizo');
  rg.addLabel('Morcilla');
  rg.addLabel('Entrana');
  
  // 3. Creamos los 10 productos de la carnicería
  //    (Serán 10 productos al azar de la lista de arriba)
  for i := 1 to 10 do
  begin
    // Obtenemos un nombre de producto al azar
    descProducto := rg.getLabel(); 
    
    // Agregamos el producto a la mercadería con un precio al azar
    self.mercaderia.agregarProducto(
      Producto.create(descProducto, rg.getReal(2000, 5000))
    );
  end;
  
  rg.free;
end;

destructor Carnicero.destroy;
begin
  // Liberamos la memoria de los objetos que "poseemos"
  self.mercaderia.free;
  self.balanza.free;
  inherited destroy;
end;

procedure Carnicero.comenzarCompra();
begin
  // El Carnicero DELEGA la tarea de resetear a la Balanza
  self.balanza.limpiar(); 
end;

procedure Carnicero.llevo(unaDescripcion: string; unPeso: real);
var
  p: Producto;
begin
  // 1. El Carnicero DELEGA a Mercaderia la búsqueda del precio
  p := self.mercaderia.getProducto(unaDescripcion);
  
  if (p <> nil) then
  begin
    // 2. El Carnicero DELEGA a Balanza el cálculo del peso y precio
    self.balanza.setPrecioPorKilo(p.getPrecioPorKilo());
    self.balanza.pesar(unPeso);
  end;
  // Si p es nil (producto no existe), simplemente no se agrega a la balanza.
end;

function Carnicero.finalizarCompra(): real;
begin
  // El Carnicero DELEGA a Balanza la tarea de darle el total
  finalizarCompra := self.balanza.getTotalAPagar();
end;

end.
