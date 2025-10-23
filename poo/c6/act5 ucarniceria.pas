unit UCarniceria;
{$mode objfpc}

interface

uses
  UCajaDeAhorro, // <-- Agregamos esta unidad
  UMercaderia, 
  UBalanza, 
  URandomGenerator; 

type
  Carnicero = class
  private
    nombre: string;
    mercaderia: Mercaderia; 
    balanza: Balanza;     
    cajaDeAhorro: CajaDeAhorro; // <-- 1. Nuevo atributo (Composición)
  public
    // 2. Constructor modificado
    constructor create(unNombre: string; unaCajaDeAhorro: CajaDeAhorro); 
    destructor destroy; override;
    procedure comenzarCompra();
    procedure llevo(unaDescripcion: string; unPeso: real);
    function finalizarCompra(): real;
    procedure recibirPago(unMonto: real); // <-- 3. Nuevo método
  end;

implementation

// 2. Constructor modificado: ahora RECIBE la caja de ahorro
constructor Carnicero.create(unNombre: string; unaCajaDeAhorro: CajaDeAhorro);
var
  rg: RandomGenerator;
  i: integer;
  descProducto: string;
begin
  self.nombre := unNombre;
  self.cajaDeAhorro := unaCajaDeAhorro; // La asignamos
  
  // Sigue creando sus componentes internos
  self.mercaderia := Mercaderia.create();
  self.balanza := Balanza.create();
  
  rg := RandomGenerator.create;
  rg.addLabel('Lomo'); rg.addLabel('Vacio'); rg.addLabel('Asado');
  rg.addLabel('Nalga'); rg.addLabel('Peceto'); rg.addLabel('Pollo');
  rg.addLabel('Milanesa'); rg.addLabel('Chorizo'); rg.addLabel('Morcilla');
  rg.addLabel('Entrana');
  
  for i := 1 to 10 do
  begin
    descProducto := rg.getLabel(); 
    self.mercaderia.agregarProducto(
      Producto.create(descProducto, rg.getReal(2000, 5000))
    );
  end;
  rg.free;
end;

destructor Carnicero.destroy;
begin
  // El carnicero libera los objetos que ÉL CREÓ (mercaderia y balanza).
  // NO libera la cajaDeAhorro, porque la recibió de afuera.
  self.mercaderia.free;
  self.balanza.free;
  inherited destroy;
end;

procedure Carnicero.comenzarCompra();
begin
  self.balanza.limpiar(); 
end;

procedure Carnicero.llevo(unaDescripcion: string; unPeso: real);
var
  p: Producto;
begin
  p := self.mercaderia.getProducto(unaDescripcion);
  if (p <> nil) then
  begin
    self.balanza.setPrecioPorKilo(p.getPrecioPorKilo());
    self.balanza.pesar(unPeso);
  end;
end;

function Carnicero.finalizarCompra(): real;
begin
  finalizarCompra := self.balanza.getTotalAPagar();
end;

// 3. Implementación del nuevo método
procedure Carnicero.recibirPago(unMonto: real);
begin
  // Delega la responsabilidad de depositar a su caja de ahorro
  writeln('Carniceria: Recibiendo pago de $', unMonto:0:2);
  self.cajaDeAhorro.depositar(unMonto);
end;

end.
