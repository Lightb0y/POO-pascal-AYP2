unit UCliente;
{$mode objfpc}

interface

uses
  SysUtils, UCajaDeAhorro, UCarniceria, URandomGenerator;

type
  Cliente = class
  private
    nombre: string;
    billetera: CajaDeAhorro; // <-- Composición ("Tiene una")
  public
    constructor create(unNombre: string; unaCajaDeAhorro: CajaDeAhorro);
    procedure comprarEnCarniceria(unaCarniceria: Carniceria); // <-- Asociación ("Usa una")
  end;

implementation

constructor Cliente.create(unNombre: string; unaCajaDeAhorro: CajaDeAhorro);
begin
  self.nombre := unNombre;
  self.billetera := unaCajaDeAhorro;
end;

procedure Cliente.comprarEnCarniceria(unaCarniceria: Carniceria);
var
  rg: RandomGenerator;
  i, cantProductos: integer;
  peso: real;
  producto: string;
  montoTotal: real;
  pudoPagar: boolean;
begin
  // Creamos un generador random para esta simulación
  rg := RandomGenerator.create;
  // IMPORTANTE: Cargamos el generador con los MISMOS productos
  // que tiene la carnicería para poder elegirlos al azar.
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

  writeln('Cliente ', self.nombre, ' inicia la compra...');
  
  [cite_start]// 1. Comienza la compra [cite: 252]
  unaCarniceria.comenzarCompra();
  
  [cite_start]// 2. Elige al azar la cantidad de productos a llevar (entre 1 y 5) [cite: 253]
  cantProductos := rg.getInteger(1, 5);
  writeln('Cliente: Voy a llevar ', cantProductos, ' productos.');
  
  [cite_start]// 3. Pide cada producto al azar [cite: 254]
  for i := 1 to cantProductos do
  begin
    producto := rg.getLabel();       // Elige un producto al azar
    peso := rg.getReal(0.5, 3.0);  // Elige un peso al azar (ej. entre 0.5 y 3kg)
    
    writeln('Cliente: ...dame ', peso:0:2, 'kg de ', producto);
    
    // Le pasa el pedido a la carnicería
    unaCarniceria.llevo(producto, peso);
  end;
  
  [cite_start]// 4. Finaliza la compra y recibe el monto [cite: 256]
  montoTotal := unaCarniceria.finalizarCompra();
  writeln('Carniceria: El total es $', montoTotal:0:2);
  
  [cite_start]// 5. Usa la billetera para pagar [cite: 257]
  if montoTotal > 0 then
  begin
    self.billetera.extraer(montoTotal, pudoPagar);
    
    [cite_start]// 6. Imprime el éxito de la operación [cite: 258]
    if pudoPagar then
      writeln('Cliente: Pago realizado con éxito.')
    else
      writeln('Cliente: ERROR. Saldo insuficiente para pagar.');
  end
  else
  begin
    writeln('Cliente: No se compró nada. No hay nada que pagar.');
  end;
  
  rg.free;
end;

end.
