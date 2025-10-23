program PCarniceria;

uses
  SysUtils, 
  URandomGenerator, // Para randomize
  UCajaDeAhorro,    // Para la billetera
  UMercaderia,      // Necesario para UCarniceria
  UBalanza,         // Necesario para UCarniceria
  UCarniceria,      // Para la Carniceria
  UCliente;         // Para el Cliente

var
  miCarniceria: Carniceria;
  billeteraCliente: CajaDeAhorro;
  cliente: Cliente;
  saldo: real;

begin
  randomize; // Inicializamos el generador de números aleatorios

  // 1. Instanciamos una caja de ahorro para el cliente
  //    (Asumimos un constructor: create(numero) y un método depositar(monto))
  billeteraCliente := CajaDeAhorro.create(12345);
  billeteraCliente.depositar(15000.0); // Le damos un saldo inicial de $15000

  // 2. Instanciamos la carnicería
  miCarniceria := Carniceria.create('Don Pepe');

  // 3. Instanciamos al cliente, pasándole su billetera
  cliente := Cliente.create('Juan', billeteraCliente);

  // 4. Imprimimos el saldo inicial del cliente
  saldo := billeteraCliente.consultarSaldo();
  writeln('Saldo inicial de Juan: $', saldo:0:2);
  writeln('-----------------------------------');

  // 5. Hacemos que el cliente vaya a comprar a la carnicería
  cliente.comprarEnCarniceria(miCarniceria);

  // 6. Imprimimos el saldo final para comprobar el funcionamiento
  writeln('-----------------------------------');
  saldo := billeteraCliente.consultarSaldo();
  writeln('Saldo final de Juan: $', saldo:0:2);

  // 7. Liberamos la memoria de todos los objetos creados
  cliente.free;
  miCarniceria.free;
  billeteraCliente.free; // La billetera se libera aquí
  
  readln;
end.
