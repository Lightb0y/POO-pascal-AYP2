program Ejercicio6;
uses UCajaDeAhorro;
type Vector = array[1..10] of CajaDeAhorro;
procedure inicializar(v: Vector);
var i: integer;
begin
for i:= 1 to 10 do
	v[i]:= CajaDeAhorro.create(i);
end;
procedure operar(v: Vector);
var i: integer;
begin
for i:= 1 to 10 do
	v[i].depositar(1000 * i);
end;
procedure imprimirSaldos(v: Vector);
var i: integer;
begin
for i:= 1 to 10 do
	writeln(v[i].consultarSaldo());
end;
var v: vector;
begin
inicializar(v);
operar(v);
imprimirSaldos(v);
end.

