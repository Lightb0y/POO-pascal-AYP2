unit UCamion;
{$mode objfpc}

interface

uses GenericLinkedList, UEncomienda;

type
  listaEncomiendas = specialize LinkedList<Encomienda>;

  Camion = class
  private
    encomiendas: listaEncomiendas;
    cantidadDeEncomiendas: integer;
    capacidad: real; // Peso máximo total permitido
    
    
  public
    constructor create(unaCapacidad: real);
    function cuantasEncomiendasTenes: integer;
    function agregarEncomienda(unaEncomienda: Encomienda): boolean;
    function extraerEncomienda: Encomienda;
    function getPesoPrimerEncomienda: real;
  end;

implementation

constructor Camion.create(unaCapacidad: real);
begin
  capacidad := unaCapacidad;
  encomiendas := listaEncomiendas.create();
  cantidadDeEncomiendas := 0;
end;

function Camion.cuantasEncomiendasTenes(): integer;
begin
  cuantasEncomiendasTenes := cantidadDeEncomiendas;
end;

function Camion.getPesoTotalActual(): real;
var
  total: real;
begin
  total := 0;
  encomiendas.reset();
  while not encomiendas.eol() do
  begin
    total := total + encomiendas.current().getPeso();
    encomiendas.next();
  end;
  getPesoTotalActual := total;
end;

function Camion.agregarEncomienda(unaEncomienda: Encomienda): boolean;
var
  pesoTotalLuego: real;
  insertado: boolean;
  pesoNueva: real;
begin
  pesoNueva := unaEncomienda.getPeso();
  pesoTotalLuego := getPesoTotalActual + pesoNueva;
  if (pesoTotalLuego > capacidad) then
  begin
    agregarEncomienda := false;
  end
  else
  begin

  // Insertar manteniendo la lista ordenada por peso ascendente
  encomiendas.reset();
  insertado := false;
  while (not encomiendas.eol()) and (not insertado) do
  begin
    if encomiendas.current().getPeso() >= pesoNueva then
    begin
      encomiendas.insertCurrent(unaEncomienda);
      insertado := true;
    end;
    encomiendas.next();
  end;
  if not insertado then
    encomiendas.addLast(unaEncomienda);
  cantidadDeEncomiendas := cantidadDeEncomiendas + 1;
  agregarEncomienda := true;
  end;
end;

function Camion.extraerEncomienda: Encomienda;
var
  encomiendaExtraida: Encomienda;
begin
  encomiendas.reset();
  if encomiendas.eol() then
  begin
    extraerEncomienda := nil;
  end
  else
  begin
    encomiendaExtraida := encomiendas.removeCurrent();
    cantidadDeEncomiendas := cantidadDeEncomiendas - 1;
    extraerEncomienda := encomiendaExtraida;
  end;
end;

function Camion.getPesoPrimerEncomienda: real;
begin
  encomiendas.reset();
  if encomiendas.eol() then
  begin
    getPesoPrimerEncomienda := 0;
  end
  else
  begin
    getPesoPrimerEncomienda := encomiendas.current().getPeso();
  end;
end;

end.

