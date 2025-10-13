{ACTIVIDAD 8: Cree el archivo Banco2.pas
Se desea modificar el programa de la actividad anterior para que el banco
pueda manejar sus 7 sucursales. Cada sucursal maneja 15 cajas de ahorro.
● Implemente un módulo que cree las cajas de ahorro de todas las
sucursales.
● Implemente un módulo que simule 45 operaciones sobre las cajas de
ahorro de las distintas sucursales. Por cada operación debe elegir al
azar una caja de ahorro y una sucursal e invocar al módulo
SimularMovimiento implementado en la actividad anterior.
● Implemente un módulo que imprima el saldo de las cajas de ahorro.
● Implemente un módulo que devuelva el número de sucursal que más
dinero tiene. El dinero de una sucursal es la suma de los saldos de
todas sus cajas de ahorro.
● Haga un programa que invoque a los cuatro módulos y compruebe el
correcto funcionamiento del mismo.}
program banco1;
uses UCajaDeAhorro;
const
CANT_CAJAS = 15;
CANT_SUCURSALES = 7;
type
mCajas = array [1..CANT_CAJAS,1..CANT_SUCURSALES] of CajaDeAhorro;
vacum = array [1..7] of real;
//--------------------------------------------------------------
procedure crearCajas (var m:mCajas);
var
i:integer; j:integer;
begin
	for i:=1 to CANT_CAJAS do
	for j:=1 to CANT_SUCURSALES do
	 begin
		m[i,j]:=CajaDeAhorro.create(i);
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
procedure operaciones (m:mCajas);
 var
 op,i,j:integer;
 exito:boolean;
 
 begin

     for op:=1 to 45 do
      begin
	    i:= random(cant_cajas)+1;
	    j:= random(cant_sucursales)+1;
	    
	    SimularMovimiento(m[i,j],exito);
	  end;
 end;
 //-----------------------------------------------------------------
 procedure imprimirCajas (m:mCajas);
  var
  i,j:integer;
  begin
	for i:=1 to CANT_CAJAS do
	for j:=1 to CANT_SUCURSALES do 
	begin
	  writeln('caja de ahorro numero ',i,'sucursal Numero ',j,'     Saldo: $',m[i,j].consultarSaldo():0:2);
	end;
  end;
  //----------------------------------------------------------------------
  procedure iniciarvacum(var va:vacum);
  var i:integer;
  begin
	for i:=1 to CANT_SUCURSALES do
		va[i]:= 0;
  end;
  //---------------------------------------------------------------------
  procedure sumarcajas(m:mCajas ;var va:vacum);
  var 
  i,j:integer;
  acum:real;
  begin
	for j:=1 to cant_sucursales do 
	begin
	 acum:= 0;
	  for i:=1 to cant_cajas do
		 	acum:= m[i,j].consultarSaldo() + acum;
	 va[j]:= acum;		
	 end;
  end;
  //--------------------------------------------------------------------
  procedure calcularposmax (va:vacum;var posmax:integer);
  var i:integer; max:real;
  begin
	max:= va[1];
	for i:=2 to CANT_SUCURSALES do
		begin
		   if va[i]> max then
		    begin
			  max:= va[i];
			  posmax:= i;
			end; 
		end;
  end;
  //--------------------------------------------------------------------
  var
  m:mCajas;
  va:vacum;
  posmax:integer;
  begin
  randomize;
  crearCajas(m);
  operaciones(m);
  imprimirCajas(m);
  iniciarvacum(va);
  posmax:=1;
  sumarcajas(m,va);
  calcularposmax(va,posmax);
  writeln('======La sucursal con mayor cantidad de dinero es: Sucursal ',posmax,'==========');
  end.
