{ACTIVIDAD 1: Crear el archivo UTicket.pas
Cree un objeto Ticket para representar el ticket de una compra en la
verdulerA-a.
Estado:
- productos: GenericList<Producto>
- cantidadDeProductos: integer
- cliente: string
- hora: Time
- dia: Date
- totalAPagar: real
Comportamiento
- create(unaHora: Time; unDia: Date) // Constructor
- setCliente(unCliente: string) // Setter
- setTotalAPagar(unTotalAPagar: real) // Setter
- getTotalAPagar(): real // Getter
- agregarProducto(unProducto: Producto) // Agrega unProducto a la lista y actualiza el contador de productos.
- cuantosProductosTenes() // Getter
- imprimir() // Imprime toda la informaciA3n del ticket

}

unit UTicket;
{$mode objfpc}

interface
 uses GenericLinkedList; UProducto;UDateTime;
 type
 liProductos = specialize linkedlist <Producto>;
  Ticket = class
    private 
        productos:liProductos
        cantidadDeProductos:integer;
        cliente:string;
        hora:Time;
        dia:Date;
        totalAPagar:real;
    public
       constructor create(unaHora:time;unDia:Date);
       procedure setCliente(unCliente: string);
       procedure setTotalAPagar(unTotalAPagar: real);
       function getTotalAPagar():real;
       procedure agregarProducto(unProducto:Producto);
       function cuantosProductosTenes():integer;
       procedure imprimir();
  end;
implementation
  constructor ticket.create(unaHora:time;unDia:Date);
   begin
     hora := unaHora;
     dia := unDia;
     productos:=liProductos.create();
     cantidadDeProductos:=0;
   end;
  procedure  ticket.setCliente(unCliente:string);
   begin
     cliente:=unCliente;
   end;
  procedure ticket.setTotalAPagar(unTotalAPagar:real);
  begin
    totalAPagar:= unTotalAPagar;
  end;
  function ticket.getTotalAPagar():real;
   begin
    getTotalAPagar:=totalAPagar;
   end;
   procedure ticket.agregarProducto (unProducto:Producto);
   begin
     productos.add(unProducto);
     cantidadDeProductos:= cantidadDeProductos + 1;
   end;
   function ticket.cuantosProductosTenes():integer;
     begin
       cuantosProductosTenes:= cantidadDeProductos;
     end;
   procedure ticket.imprimir();
     begin
       writeln('Cliente: ',cliente,'|dia: ',dia.toString(),'|hora: ',hora.toString(),'|Cantidad prod: ',cantidadDeProductos,'|Total a pagar: ',totalAPagar);
       writeln('         [Productos comprados]');
       productos.reset();
       while (not productos.eol())do
        begin
           writeln('- 'productos.current().nombre,' ,Peso: ',productos.current().peso ,' KG');
           productos.next();
        end;
     end;
end.
