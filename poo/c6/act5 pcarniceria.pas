program PCarniceria;

uses
  SysUtils, 
  URandomGenerator,
  UCajaDeAhorro,    
  UMercaderia,      
  UBalanza,         
  UCarniceria,      
  UCliente;         

var
  miCarniceria: Carniceria;
  billeteraCarnicero: CajaDeAhorro; // <-- Nuevo
  billeteraCliente: CajaDeAhorro;
  cliente: Cliente;
  saldo: real;

begin
  randomize; 

  // --- Configuración de la Carnicería ---
  billeteraCarnicero := CajaDeAhorro.create(99999); // Creamos su caja
  billeteraCarnicero.depositar(50000.0); // Le damos un fondo inicial
  miCarniceria := Carniceria.create('Don Pepe', billeteraCarnicero); // Se la pasamos

  // --- Configuración del Cliente ---
  billeteraCliente := CajaDeAhorro.create(12345);
  billeteraCliente.depositar(15000.0); 
  cliente := Cliente.create('Juan', billeteraCliente);

  // --- Imprimimos saldos iniciales ---
  saldo := billeteraCliente.consultarSaldo();
  writeln('Saldo inicial de Juan: $', saldo:0:2);
  saldo := billeteraCarnicero.consultarSaldo();
  writeln('Saldo inicial Carniceria: $', saldo:0:2);
  writeln('-----------------------------------');

  // --- Simulación de la compra ---
  cliente.comprarEnCarniceria(miCarniceria);

  // --- Imprimimos saldos finales ---
  writeln('-----------------------------------');
  saldo := billeteraCliente.consultarSaldo();
  writeln('Saldo final de Juan: $', saldo:0:2);
  saldo := billeteraCarnicero.consultarSaldo();
  writeln('Saldo final Carniceria: $', saldo:0:2);
  
  // --- Liberamos memoria ---
  cliente.free;
  miCarniceria.free;
  billeteraCliente.free; 
  billeteraCarnicero.free; // Liberamos la nueva caja
  
  readln;
end.
