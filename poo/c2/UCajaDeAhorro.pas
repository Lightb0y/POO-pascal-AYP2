unit UCajaDeAhorro;
{$mode objfpc}

interface

type

	CajaDeAhorro = class
		private
			saldo: real;
			numero: integer;
			
		public
			constructor create(unNumero: integer);

			function getNumero: integer;
			procedure depositar(unMonto: real);
			procedure extraer(unMonto: real; var ok: boolean);
			function consultarSaldo(): real;
	end;
	
implementation
    constructor CajaDeAhorro.create(unNumero: integer);
    begin
    numero:= unNumero;
    end;
    
    function CajaDeAhorro.getNumero: integer;
    begin
    getNumero:= numero;
    end;
    
	procedure CajaDeAhorro.depositar(unMonto: real);
	begin
	saldo:= saldo + unMonto;
	end;
	
	procedure CajaDeAhorro.extraer(unMonto: real; var ok: boolean);
	begin
	if saldo > unMonto then
		begin
		saldo:= saldo - unMonto;
		ok:= true;
		end
	else
		ok:= false;
	end;
	
	function CajaDeAhorro.consultarSaldo(): real;
	begin
	consultarSaldo:= saldo;
	end;
				
end.
