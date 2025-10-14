{ACTIVIDAD 5: Crear el archivo PCorreo.pas
Se desea hacer un programa para que un correo reciba y despache
encomiendas. El correo cuenta con 5 carteros.
● Implemente un módulo Inicializar que cree los 5 carteros sin
encomiendas.
● Implemente un módulo SimularRecepcion que reciba a todos los
carteros por parámetro y que simule la recepción de encomiendas
agregando N encomiendas generadas al azar. (N también es elegido al azar)
La elección de a qué cartero asignarle cada una de las encomiendas
también se elige al azar. (Los carteros podrían quedar con distinto número
de encomiendas).
ACTIVIDAD 5: (Continuación)
● Implemente un módulo SimularReparto que reciba a todos los carteros
por parámetro y que simule el reparto de encomiendas. El reparto de una
encomienda se simula imprimiendo toda la información de la encomienda.
Todos los carteros deben hacer el reparto de todas sus encomiendas.
● Haga un programa que invoque a los tres módulos implementados y
compruebe el correcto funcionamiento del mismo.
}
program Pcorreo;
uses UCartero;UEncomienda;URandomGenerator;
const
  cant_carteros = 5;
type
 vCarteros = array [1..cant_carteros] of Cartero;

 procedure inicializar (var v:vCarteros);
 var i:integer;
 begin
   for i:=1 to cant_carteros do
    begin
      v[i]:= cartero.create();
    end;
 end;
 
 procedure SimularRecepcion(v:vCarteros;rg:RandomGenerator);
  var
   n,eleccion:integer;
   rem,des:string; 
   pes:real;
  begin 
    n := rg.getInteger(1,50);
    
    for i:=1 to n do  // generador de encomiendas
     begin
       eleccion := rg.getInteger(1,cant_carteros);
        rem:= rg.getString(5);
        des:=rg.getString(5);
        pes:= rg.getReal(0.1,1);
        v[eleccion].agregarEncomienda(encomienda.create(rem,des,pes));
     end;
  end;
  procedure SimularReparto(v:vCarteros);
  var i:integer;
  begin
    for i:=1 to cant_carteros do
      begin
        writeln('---Cartero ,',i,'|Cantidad de encomiendas: ',v[i].cuantasEncomiendasTenes(),);
         writeln('Lista de Encomiendas');
         while (v[i].cuantasEncomiendasTenes()>0)do
          writeln('Encomienda entregada, ',v[i].sacarEncomienda().toString());
      end;
      writeln('---------------------------------------------------------------------------------');
  end;
var
v:vCarteros;
rg:RandomGenerator;
begin
  rg:= RandomGenerator.create();
  inicializar(v);
  SimularRecepcion(v,rg);
  SimularReparto(v);
end.
