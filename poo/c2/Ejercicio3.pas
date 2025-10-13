program Ejercicio3;
uses UCajaDeAhorro;
procedure operar(ca: CajaDeAhorro);
var ok: boolean;
begin
ca.depositar(2000);
ca.extraer(500,ok);
end;
var ca: CajaDeAhorro;
begin
ca:= CajaDeAhorro.create(1);
operar(ca);
writeln(ca.consultarSaldo():10:2);
end.

