program Ejercicio1;
uses UBalanza, URandomGenerator;
var b: Balanza; rg: RandomGenerator; i: integer;
begin
rg:= RandomGenerator.create();
b:= Balanza.create();
for i:= 1 to 5 do
	begin
	b.setPrecioPorKilo(rg.getReal(200, 500));
	b.pesar(rg.getReal(1,5));
	end;
b.totalAPagar:= b.totalAPagar / 2;
b.imprimir();
end.
