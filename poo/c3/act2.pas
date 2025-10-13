{ACTIVIDAD 2: Crear el archivo PContadorManual.pas
● Implemente la unidad UContadorManual con el objeto contador
● Escriba un programa que lea de teclado 10 números enteros y cuente
cuántos números pares e impares se leyeron e imprima las cantidades.
Utilice al objeto contador para llevar ambas contabilidades.}

unit UContadorManual;
{$mode objfpc}

interface
    type
        ContadorManual = class
            private
                cantidad:integer;
            public
                constructor create ();
                procedure incrementar ();
                procedure resetear ();
                function getCantidad ():integer;
        end;

implementation
 constructor ContadorManual.create();
    begin
        cantidad:=0;
    end;
 procedure ContadorManual.incrementar();
   begin
    cantidad := cantidad + 1;
   end;
  procedure ContadorManual.resetear ();
   begin
     cantidad:=0;
   end;
  function ContadorManual.getCantidad():integer;
   begin
    getCantidad:= cantidad;    // uso solo el nombre del procedure declarado en public
   end;
end.

{----------------------------------}
program PContadorManual;
uses UContadorManual;
var
i,num:integer;
cm1,cm2:ContadorManual;
begin
 //instancio los dos contadores
 cm1:=ContadorManual.create();
 cm2:= ContadorManual.create();
  for i:=1 to 10 do 
  begin
    writeln('Ingresa un numero');
    readln(num);
    if num mod 2 = 0 then   // si es par
       cm2.incrementar();
    else 
       cm1.incrementar();
  end;
  writeln('===RESULTADOS===');
  writeln('Cantidad de impares : ',cm1.getCantidad(),'| Cantidad de pares: ',cm2.getCantidad());  
end.
