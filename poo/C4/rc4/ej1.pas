program CentroDeDistribucion;
{$mode objfpc}

uses GenericLinkedList, UEncomienda, UCamion, URandomGenerator;

type
  listaEncomiendas = specialize LinkedList<Encomienda>;
  TCamiones = array[1..10] of Camion;

procedure CrearCamiones(var camiones: TCamiones; rg: RandomGenerator);
var
  i: integer;
  capacidad: integer;
begin
  for i := 1 to 10 do
  begin
    capacidad := rg.getInteger(5000, 25000);
    camiones[i] := Camion.create(capacidad);
  end;
end;

{ Simulación de la cátedra: cargar todas las encomiendas del día }
procedure ObtenerInfoEncomiendas(var encomiendas: listaEncomiendas; rg: RandomGenerator);
var
  i, cantidad: integer;
  peso: real;
  rem, dest: string;
  enc: Encomienda;
begin
  encomiendas := listaEncomiendas.create();
  cantidad := rg.getInteger(80, 200);
  for i := 1 to cantidad do
  begin
    rem := rg.getString(6);
    dest := rg.getString(6);
    peso := rg.getReal(100, 3000);
    enc := Encomienda.create(rem, dest, peso);
    encomiendas.add(enc);
  end;
end;

{ Llenado secuencial: se llena el camión i al máximo posible y luego se avanza }
procedure RepartirEncomiendasSecuencial(var camiones: TCamiones; encomiendas: listaEncomiendas);
var
  i: integer;
  pudoAgregar: boolean;
begin
  encomiendas.reset();
  for i := 1 to 10 do
  begin
    pudoAgregar := true;
    while (not encomiendas.eol()) and pudoAgregar do
    begin
      pudoAgregar := camiones[i].agregarEncomienda(encomiendas.current());
      if pudoAgregar then
        encomiendas.next();
    end;
  end;
end;

procedure ImprimirResumen(camiones: TCamiones);
var
  i: integer;
begin
  for i := 1 to 10 do
  begin
    writeln('Camion ', i, ' | encomiendas: ', camiones[i].cuantasEncomiendasTenes(),
            ' | peso primera: ', camiones[i].getPesoPrimerEncomienda():0:2);
  end;
end;

var
  rg: RandomGenerator;
  camiones: TCamiones;
  encomiendasDelDia: listaEncomiendas;
begin
  writeln('=== Centro de Distribucion ===');
  rg := RandomGenerator.create();

  CrearCamiones(camiones, rg);
  ObtenerInfoEncomiendas(encomiendasDelDia, rg);
  RepartirEncomiendasSecuencial(camiones, encomiendasDelDia);

  writeln('--- Resumen por camion ---');
  ImprimirResumen(camiones);
  writeln('Proceso finalizado');
end.
