{ACTIVIDAD 4: Crear el archivo UCartero.pas
Cree un objeto Cartero para representar a la persona que reparte las
encomiendas.
Estado:
- encomiendas: GenericList<Encomienda>
- cantidadDeEncomiendas: integer // lleva la contabilidad de
// encomiendas almacenados en la lista de encomiendas
Comportamiento
- create() // El constructor debería ser el encargado de instanciar la
// lista de encomiendas y poner el contador de productos en cero.
- agregarEncomienda(unaEncomienda: Encomienda)
// Agrega unaEncomienda a la lista y actualiza el contador de
encomiendas.
- sacarEncomienda(): Encomienda
// Saca la primer encomienda de la lista (la de menor peso) y la
devuelve. También actualiza el contador de encomiendas.
- cuantasEncomiendasTenes(): integer
// Devuelve la cantidad de encomiendas que tiene el repartidor}

unit UCartero;
{$mode objfpc}

interface
 uses GenericLinkedList;
    type
     liEncomiendas= specialize linkedlist <Encomienda>;
  
        cartero = class
         private
            encomiendas:liEncomiendas;
            cantidadDeEncomiendas:integer; //cantidad de elementos de liEncomiendas
         public
            constructor create();
            procedure agregarEncomienda(unaEncomienda:Encomienda);
            function sacarEncomienda():Encomienda;
            function cuantasEncomiendasTenes():integer;
       end;  
implementation

constructor cartero.create();
 begin
   encomiendas:= liEncomiendas.create();
   cantidadDeEncomiendas:= 0;
 end;
procedure cartero.agregarEncomienda(unaEncomienda:Encomienda);
//inserto ordenado, para cumplir el siguiente modulo (que el primero sea el de menor peso)
begin
  encomiendas.reset();
  while (not encomiendas.eol()) and unaEncomienda.getPeso() > encomiendas.current().getPeso()
   begin
     encomiendas.next();
   end;
   encomiendas.insertCurrent(unaEncomienda);
  cantidadDeEncomiendas:= 1 + cantidadDeEncomiendas;
end;
function cartero.sacarEncomienda ():Encomienda;
begin
 encomiendas.reset();
 if  (not encomiendas.eol) then 
   begin
     sacarEncomienda:= encomiendas.current();
     encomiendas.removeCurrent();
     cantidadDeEncomiendas:= cantidadDeEncomiendas - 1 ;
   end
   else 
     sacarEncomienda:= nil;
end;

function cuantasEncomiendasTenes():integer;
 begin
   cuantasEncomiendasTenes:= cantidadDeEncomiendas;
 end;
end.