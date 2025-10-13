unit UBalanza;
{$mode objfpc}

interface

type

	Balanza = class
		private
			cantProds: integer;
			precioPorKilo, totalAPagar: real;
			
		public
			constructor create();
			
			procedure limpiar();
			procedure setPrecioPorKilo(unPrecioPorKilo: real);
			procedure pesar(unPesoEnKilos: real);
			procedure imprimir();
			function getTotalAPagar(): real;
	end;
	
implementation
    constructor Balanza.create();
    begin
    self.limpiar();
    end;
    
	procedure Balanza.limpiar();
	begin
	cantProds:= 0;
	precioPorKilo:= 0;
	totalAPagar:= 0;
	end;
	
	procedure Balanza.setPrecioPorKilo(unPrecioPorKilo: real);
	begin
	precioPorKilo:= unPrecioPorKilo;
	end;
	
	procedure Balanza.pesar(unPesoEnKilos: real);
	begin
	cantProds:= cantProds + 1;
	totalAPagar:= totalAPagar + precioPorKilo * unPesoEnKilos;
	end;
	
	procedure Balanza.imprimir();
	begin
	writeln('---------------------------------------------');
	writeln('Cantidad de productos pesados: ', cantProds);
	writeln('Total a pagar: ', totalAPagar:2:2);
	writeln('---------------------------------------------');
	end;
	
	function Balanza.getTotalAPagar(): real;
	begin
	getTotalAPagar:= totalAPagar;
	end;
end.
