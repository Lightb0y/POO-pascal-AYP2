program PruebaBalanza;
uses UBalanza;
var
b:balanza;
begin
 b:=Balanza.create();
 b.limpiar();
 readln(precio);
 while precio > 0 do
    begin
      b.setPrecioPorKilo(precio);
      readln(peso);
      b.pesar(peso);
      readln(precio);
    end;
    b.imprimir();
end.