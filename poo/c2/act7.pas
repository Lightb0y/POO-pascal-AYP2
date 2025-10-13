{ACTIVIDAD 7: Cree el archivo Banco1.pas
Se desea hacer un programa para que un banco maneje sus 15 cajas de
ahorro.
● Implemente un módulo que cree las cajas de ahorro.
● Implemente un módulo SimularMovimiento que reciba una caja de
ahorro por parámetro y que deposite o extraiga una suma generada al
azar. La acción de depositar o extraer debe ser determinada al azar.
Este módulo además debe informar el éxito o no de la operación.
● Implemente un módulo que simule 30 operaciones sobre las cajas de
ahorro. Por cada operación debe elegir al azar una caja de ahorro e
invocar al módulo SimularMovimiento.
● Implemente un módulo que imprima el saldo de todas las cajas de
ahorro.
● Haga un programa que invoque a los cuatro módulos implementados y
compruebe el correcto funcionamiento del mismo.}


program banco1;
uses UCajaDeAhorro;
const
CANT_CAJAS = 15;

type
vCajas = array [1..CANT_CAJAS] of CajaDeAhorro;
//--------------------------------------------------------------
procedure crearCajas (var v:vCajas);
var
i:integer;
begin
	for i:=1 to CANT_CAJAS do
	 begin
		v[i]:=CajaDeAhorro.create(i);
	 end;
	
end;

//--------------------------------------------------------------
procedure SimularMovimiento (ca:CajaDeAhorro;var exito:boolean);

var
 azar:integer; cantidad:real;
begin
	azar:=random(2)+1;  //AZAR 1 = DEPOSITAR   ; AZAR 2= EXTRAER
	cantidad:=(random(2000)+1);
	if azar = 1 then  
	 begin
	    ca.depositar(cantidad);
	    writeln('depositado');
	    
	 end
	else if azar =2 then
	 begin
	   ca.extraer(cantidad,exito);
	   writeln('extraido');
	 end
	else
	  exito:=false;
end;
//---------------------------------------------------------------
procedure operaciones (v:vCajas);
 var
 i,pos:integer;
 exito:boolean;
 
 begin

     for i:=1 to 30 do
      begin
	    pos:= random(14)+1;
	    SimularMovimiento(v[pos],exito);
	  end;
 end;
 //-----------------------------------------------------------------
 procedure imprimirCajas (v:vCajas);
  var
  i:integer;
  begin
	for i:=1 to 15 do
	begin
	  writeln('caja de ahorro numero ',i,' Saldo: $',v[i].consultarSaldo():0:2);
	end;
  //----------------------------------------------------------------------
  end;
  var
  v:vCajas;
  
  begin
  randomize;
  crearCajas(v);
  operaciones(v);
  imprimirCajas(v);
  end.
