unit UProducto;
{$mode objfpc}

interface
uses
UDatetime;
  
type
 comparable = class (TObject)
      end;
 producto=class (comparable)
	private
	  descripcion:string; precio:real;
	  stock:integer; vencimiento:date;
	public
	  constructor create(unaDescripcion:string;unPrecio:real;unStock:integer;unVencimiento:date);
	   function getDescripcion():string;
	   function getPrecio():real;
	   function getStock():integer;
	   function getVencimiento():date;
 end;

implementation
 constructor producto.create(unaDescripcion:string;unPrecio:real;unStock:integer;unVencimiento:date);
  begin
	descripcion:=unaDescripcion; precio:=unPrecio;stock:=unStock; vencimiento:=unVencimiento;
  end;
  
  function producto.getDescripcion():string;
  begin
	getDescripcion:= descripcion;
  end;
  function producto.getPrecio():real;
  begin
	getPrecio:=precio;
  end;
  function producto.getStock():integer;
  begin
	getStock:=stock;
  end;
  function producto.getVencimiento():date;
  begin
	getVencimiento:=vencimiento;
  end;
end.
