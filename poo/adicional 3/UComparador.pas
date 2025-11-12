unit UComparador;
{$mode objfpc}

interface
 uses UProducto;
 type
   Comparador=class
	public
	 function esMayor(unComparable,otroComparable:Comparable):boolean;virtual;abstract;
   end;
   
   comparadorPorPrecio=class (comparador)
   public 
   function esMayor (unComparable,otroComparable:Comparable):boolean;override;
   end;
   comparadorPorStock = class(comparador)
    public
	 function esMayor(unComparable,otroComparable:Comparable):boolean;override;
   end;
   comparadorPorVencimiento = class(comparador)
	public
	  function esMayor(unComparable,otroComparable:Comparable):boolean;override;
   end;
implementation
 uses UDateTime;
  function comparadorPorPrecio.esMayor(unComparable,otroComparable:Comparable):boolean;
  begin
	esMayor:= (unComparable as Producto).getPrecio()> (otroComparable as Producto).getPrecio();
  end;
  
  function comparadorPorStock.esMayor(unComparable,otroComparable:Comparable):boolean;
  begin
	esMayor:= (unComparable as Producto).getStock() > (otroComparable as Producto).getStock();
  end;
  
  function comparadorPorVencimiento.esMayor(unComparable,otroComparable:Comparable):boolean;
  var unDate,otroDate:date;
  begin
     unDate:= (unComparable as Producto).getVencimiento();
     otroDate:= (otroComparable as Producto).getVencimiento();
     
     if unDate.getYear()<> otroDate.getYear()then
       esMayor:= unDate.getYear()> otroDate.getYear()
     else if unDate.getMonth() <> otroDate.getMonth then
       esMayor:= unDate.getMonth >otroDate.getMonth()
     else
        esMayor:= unDate.getDay > otroDate.getDay();
       
  end;
end.
