program Ejercicio4;
uses UCajaDeAhorro;
type vector = array[1..10] of CajaDeAhorro;
var ca: CajaDeAhorro;
	i: integer; v: vector;
begin
ca:= CajaDeAhorro.create(1);
for i:= 1 to 10 do
    begin
    v[i]:= ca;
    v[i].depositar(1000);
    writeln(v[i].consultarSaldo():10:2);
    end;
end.

