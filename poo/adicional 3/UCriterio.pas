unit UCriterio;
{$mode objfpc}

interface
uses UProducto,UComparador;
 type
   Criterio= class (TObject)
		public 
		 function vaAntes(unComparable, otroComparable: Comparable; unComparador: Comparador): boolean;virtual;abstract;
      end;
   
   OrdenAscendente = class (criterio)
     public
       function vaAntes(unComparable, otroComparable: Comparable; unComparador: Comparador): boolean;override;
   end;
    OrdenDescendente = class (criterio)
     public
       function vaAntes(unComparable, otroComparable: Comparable; unComparador: Comparador): boolean;override;
       end;
implementation
 function ordenascendente.vaAntes(unComparable, otroComparable: Comparable; unComparador: Comparador): boolean;
 begin
	  vaAntes := unComparador.esMayor(otroComparable,unComparable);
 end;
 
  function ordendescendente.vaAntes(unComparable, otroComparable: Comparable; unComparador: Comparador): boolean;
 begin
    vaAntes:= unComparador.esMayor(unComparable,otroComparable);
 end;
end.
