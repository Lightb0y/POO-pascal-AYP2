unit UOrdenador;
{$mode objfpc}
interface
 uses
  UComparador,UCriterio,UProducto,genericLinkedlist;
 type
  licomparables = specialize linkedlist <comparable>;
   Ordenador=class
	private 
	 TComparador:comparador;
	 TCriterio:criterio;
	 TLista:licomparables;
	public
	 constructor create(unComparador:comparador;unCriterio:criterio);
	 procedure agregarObjeto(unComparable:comparable);
	 procedure setComparador(unComparador:comparador);
	 procedure setCriterio(unCriterio:Criterio);
	 function getLista():licomparables;
   end;
implementation
 constructor ordenador.create(unComparador:comparador;unCriterio:criterio);
   begin
	 TComparador:=unComparador;
	 TCriterio:=unCriterio;
	 TLista:= licomparables.create();
   end;
   
   procedure ordenador.agregarObjeto(unComparable:comparable);
   begin
	tlista.add(unComparable);
   end;
   
   procedure ordenador.setComparador(unComparador:comparador);
   begin
	TComparador:=unComparador;
   end;
   
   procedure ordenador.setCriterio(unCriterio:criterio);
   begin
	TCriterio:=unCriterio;
   end;
   
   function ordenador.getLista():licomparables;
   var liordenada:licomparables;  encontrado:boolean;
   begin
	  liordenada:=licomparables.create();
	  tlista.reset();
	  while (not tlista.eol())do
	   begin
		 encontrado:=false;
		 liordenada.reset();
		 while (not liordenada.eol) and not encontrado do
		  begin
			if tCriterio.vaAntes(tlista.current(),liordenada.current(),TComparador)then 
			 encontrado:=true
			else 
			  liordenada.next();
		  end;
		  liordenada.insertCurrent(tlista.current());
		  tlista.next();
	   end;
	getLista:=liordenada;
   end;
end.
