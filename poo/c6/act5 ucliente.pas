unit UCliente;
{$mode objfpc}

interface

uses
  SysUtils, UCajaDeAhorro, UCarniceria, URandomGenerator;

type
  Cliente = class
  private
    nombre: string;
    billetera: CajaDeAhorro; 
  public
    constructor create(unNombre: string; unaCajaDeAhorro: CajaDeAhorro);
    procedure comprarEnCarniceria(unaCarniceria: Carniceria); 
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
  rg := RandomGenerator.create;
  rg.addLabel('Lomo'); rg.addLabel('Vacio'); rg.addLabel('Asado');
  rg.addLabel('Nalga'); rg.addLabel('Peceto'); rg.addDabel('Pollo');
  rg.addLabel('Milanesa'); rg.addLabel('Chorizo'); rg.addLabel('Morcilla');
  rg.addLabel('Entrana');

  writeln('Cliente ', self.nombre, ' inicia la compra...');
  
  unaCarniceria.comenzarCompra();
  
  cantProductos := rg.getInteger(1, 5);
  writeln('Cliente: Voy a llevar ', cantProductos, ' productos.');
  
  for i := 1 to cantProductos do
  begin
    producto := rg.getLabel();       
    peso := rg.getReal(0.5, 3.0);  
    writeln('Cliente: ...dame ', peso:0:2, 'kg de ', producto);
    unaCarniceria.llevo(producto, peso);
  end;
  
  montoTotal := unaCarniceria.finalizarCompra();
  writeln('Carniceria: El total es $', montoTotal:0:2);
  
  if montoTotal > 0 then
  begin
    self.billetera.extraer(montoTotal, pudoPagar);
    
    if pudoPagar then
    begin
      writeln('Cliente: Pago realizado con éxito.');
      // --- ESTA ES LA LÍNEA NUEVA ---
      // El cliente le delega a la carnicería la acción de "recibir" el dinero
      unaCarniceria.recibirPago(montoTotal); 
      // -----------------------------
    end
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
