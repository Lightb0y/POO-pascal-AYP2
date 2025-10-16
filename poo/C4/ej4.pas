program Verduleria2y3;
uses GenericLinkedList, UDateTime, URandomGenerator , UBalanza, UTicket, UProducto;

type
	listaProducto = specialize LinkedList<Producto>;
	listaTickets = specialize LinkedList<Ticket>;
	cajaDeCobro = record
		numeroCaja : integer;
		ticketsEmitidos : listaTickets;
	end;

procedure cargarCarrito(var car : listaProducto; rg : RandomGenerator);
var
	prodAct : Producto;
	i : integer;
	cantidad : integer;
begin
	cantidad := rg.getInteger(1, 20);
	car := listaProducto.create();
	for i:=1 to cantidad do
	begin
		prodAct := Producto.create(rg.getLabel(), rg.getReal(0.1, 5.0));
		car.add(prodAct);
	end;
end;

procedure printCarrito(car: listaProducto);
begin
	car.reset();
	while (not car.eol()) do
	begin
		writeln(car.current().getNombre(), ' : ', car.current().getPeso():0:2, ' kg');
		car.next();
	end;
end;

procedure pesarCarrito(car : listaProducto; bal : balanza; var tic : ticket; rg:RandomGenerator);
var
	fechaMin, fechaMax : Date;
	horaMin, horaMax : Time;
begin
	fechaMin := Date.create(1, 9, 2024);
	fechaMax := Date.create(30, 9, 2024);
	horaMin := Time.create(0, 0, 0);
	horaMax := Time.create(23, 59, 59);

	bal.limpiar();
	car.reset();
	while (not car.eol()) do
	begin
		bal.setPrecioPorKilo(rg.getReal(250, 2000));
		bal.pesar(car.current().getPeso());
		car.next();
	end;

	tic := ticket.create(rg.getTime(horaMin, horaMax), rg.getDate(fechaMin, fechaMax));
	tic.setCliente(rg.getString(6));
	tic.setTotalAPagar(bal.getTotalAPagar());

	car.reset();
	while (not car.eol()) do
	begin
	tic.agregarProducto(car.current());
	car.next();
end;
end;

{Implemente un módulo recursivo que reciba todos los tickets generados
y devuelva la cantidad de tickets con más de tres productos.}
function contarTicketsConMasDeTresProductos(tickets: listaTickets): integer;
begin
	if tickets.eol() then
		contarTicketsConMasDeTresProductos := 0
	else
	begin
		if tickets.current().cuantosProductosTenes() > 3 then
			contarTicketsConMasDeTresProductos := 1 + contarTicketsConMasDeTresProductos(tickets)
		else
			contarTicketsConMasDeTresProductos := contarTicketsConMasDeTresProductos(tickets);
	tickets.next();
end;
end;

{Implemente un módulo recursivo que reciba todos los tickets generados
y devuelva aquellos cuyo total a pagar es mayor a un monto recibido por
parámetro.}
procedure imprimirTicketsConMontoMayor(tickets: listaTickets; montoMinimo: real);
begin
	if not tickets.eol() then
	begin
		if tickets.current().getTotalAPagar() > montoMinimo then
			tickets.current().imprimir();
		tickets.next();
		imprimirTicketsConMontoMayor(tickets, montoMinimo);
	end;
end;


{Implemente un módulo que simule la venta de varias compras en cada una de las cajas.}
procedure simularVentasEnCajas(var caja1, caja2, caja3: cajaDeCobro; rg: RandomGenerator);
var
	chango : listaProducto;
	balan : balanza;
	ticketAct : ticket;
	cantidadVentas, i : integer;
	cajaSeleccionada : integer;
begin
	balan := Balanza.create();
	
	{Inicializar las cajas}
	caja1.numeroCaja := 1;
	caja1.ticketsEmitidos := listaTickets.create();
	caja2.numeroCaja := 2;
	caja2.ticketsEmitidos := listaTickets.create();
	caja3.numeroCaja := 3;
	caja3.ticketsEmitidos := listaTickets.create();
	
	{Simular ventas aleatorias en las tres cajas}
	for i := 1 to 15 do {15 ventas distribuidas entre las 3 cajas}
	begin
		cargarCarrito(chango, rg);
		pesarCarrito(chango, balan, ticketAct, rg);
		
		{Seleccionar caja aleatoriamente}
		cajaSeleccionada := rg.getInteger(1, 3);
		
		if cajaSeleccionada = 1 then
			caja1.ticketsEmitidos.add(ticketAct)
		else if cajaSeleccionada = 2 then
			caja2.ticketsEmitidos.add(ticketAct)
		else
			caja3.ticketsEmitidos.add(ticketAct);
	end;
end;

{Implemente un módulo que imprima todos los tickets de todas las cajas.}
procedure imprimirTodosLosTicketsDeTodasLasCajas(caja1, caja2, caja3: cajaDeCobro);
begin
	writeln('========== TICKETS DE LA CAJA ', caja1.numeroCaja, ' ==========');
	caja1.ticketsEmitidos.reset();
	while not caja1.ticketsEmitidos.eol() do
	begin
		caja1.ticketsEmitidos.current().imprimir();
		writeln('---');
		caja1.ticketsEmitidos.next();
	end;
	
	writeln('========== TICKETS DE LA CAJA ', caja2.numeroCaja, ' ==========');
	caja2.ticketsEmitidos.reset();
	while not caja2.ticketsEmitidos.eol() do
	begin
		caja2.ticketsEmitidos.current().imprimir();
		writeln('---');
		caja2.ticketsEmitidos.next();
	end;
	
	writeln('========== TICKETS DE LA CAJA ', caja3.numeroCaja, ' ==========');
	caja3.ticketsEmitidos.reset();
	while not caja3.ticketsEmitidos.eol() do
	begin
		caja3.ticketsEmitidos.current().imprimir();
		writeln('---');
		caja3.ticketsEmitidos.next();
	end;
end;

{Escriba un programa que invoque a los dos módulos implementados y compruebe el correcto funcionamiento del mismo.}
var
	rg : RandomGenerator;
	caja1, caja2, caja3 : cajaDeCobro;
BEGIN
	writeln('========== SIMULACION DE VENTAS EN TRES CAJAS ==========');
	
	rg := RandomGenerator.create();
	rg.addLabel('Papa');
	rg.addLabel('Morron');
	rg.addLabel('Cebolla');
	rg.addLabel('Perejil');
	rg.addLabel('Puerro');
	rg.addLabel('Verdeo');
	rg.addLabel('Chauchas');
	rg.addLabel('Ajo');
	rg.addLabel('Tomate');
	rg.addLabel('Lechuga');
	
	{Simular ventas en las tres cajas}
	simularVentasEnCajas(caja1, caja2, caja3, rg);
	
	{Imprimir todos los tickets de todas las cajas}
	imprimirTodosLosTicketsDeTodasLasCajas(caja1, caja2, caja3);
	
	writeln('========== SIMULACION COMPLETADA ==========');
end.
