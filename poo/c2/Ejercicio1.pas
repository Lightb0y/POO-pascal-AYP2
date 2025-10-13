program Ejercicio1;
uses UCajaDeAhorro;

var ca1, ca2: CajaDeAhorro;
begin
ca1:= CajaDeAhorro.create(1);
ca1.depositar(1000);
writeln(ca1.consultarSaldo():10:2);

ca2:= CajaDeAhorro.create(2);
ca2.depositar(2000);
writeln(ca2.consultarSaldo():10:2);
end.
