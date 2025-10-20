{ACTIVIDAD 3: Crear el archivo Fechas.pas
● Implemente un módulo que cargue un vector de 15 fechas de
nacimiento elegidas al azar.
● Implemente un módulo que reciba un vector de fechas y una fecha a
buscar y devuelva si existe en el vector.
● Implemente un módulo que reciba un vector de fechas y devuelva la
fecha de la persona más jóven.
● Implemente un módulo que reciba un vector de fechas y lo devuelva
ordenado de menor a mayor.
● Implemente un módulo que reciba un vector de fechas y las imprima
por consola.
● Escriba un programa que invoque a todos los módulos implementados
y compruebe el correcto funcionamiento del mismo.}
program fechas;
uses UDateTime, URandomGenerator;
type
    vFechas= array[1..15] of date;
    
procedure cargarvfechas (var v:vFechas; var rg:RandomGenerator);
var
i,d,m,a:integer;
begin
for i:=1 to 15 do begin
    d:=rg.getInteger(1,31);
    m:=rg.getInteger(1,12);
    a:=rg.getInteger(1900,2024);
    v[i]:= date.create(d,m,a);
  end;
end;

function existefecha(v:vFechas;bfecha:date):boolean;
var i:integer; aux:boolean;
begin
  aux:=false;
  for i:=1 to 15 do
   begin
      if v[i].equals(bfecha) then
        aux:=true;
   end; 
  existefecha:=aux;
end;

function masjoven(v:vFechas):date;
 var
i:integer; mindate:date;
 begin
mindate:=v[1];
for i:=2 to 15 do begin
  if v[i].lessThan(mindate) then
    begin
      mindate:= v[i];
    end;
end;
masjoven:=mindate;
end;

procedure ordenarFechas(var v:vFechas);
var
i,j,minIndex:integer; aux:date;
begin
  // Algoritmo de ordenamiento por selección (Selection Sort)
  for i:=1 to 14 do
  begin
    minIndex := i; // Asumir que el elemento actual es el mínimo
    
    // Buscar el elemento más pequeño en el resto del vector
    for j:=i+1 to 15 do
    begin
      if v[j].lessThan(v[minIndex]) then
        minIndex := j;
    end;
    
    // Intercambiar el elemento actual con el mínimo encontrado
    if minIndex <> i then
    begin
      aux := v[i];
      v[i] := v[minIndex];
      v[minIndex] := aux;
    end;
  end;
end;

procedure imprimirFechas(v:vFechas);
var
i:integer;
begin
  writeln('Fechas en el vector:');
  for i:=1 to 15 do
  begin
    writeln('Posicion ', i, ': ', v[i].toString());
  end;
end;

{-------------------------------------------}
var
rg:RandomGenerator; 
v:vFechas;
fechaBuscar:date;
begin
  // Crear el generador de números aleatorios
  rg := RandomGenerator.create();
  
  // Cargar el vector con fechas aleatorias
  writeln('Cargando vector con fechas aleatorias...');
  cargarvfechas(v,rg);
  
  // Imprimir fechas originales
  writeln('Fechas originales:');
  imprimirFechas(v);
  
  // Buscar una fecha específica
  fechaBuscar := date.create(15, 6, 2000);
  writeln();
  writeln('Buscando fecha: ', fechaBuscar.toString());
  if existefecha(v, fechaBuscar) then
    writeln('La fecha existe en el vector')
  else
    writeln('La fecha NO existe en el vector');
  
  // Encontrar la persona más joven
  writeln();
  writeln('La persona mas joven nacio el: ', masjoven(v).toString());
  
  // Ordenar el vector de menor a mayor
  writeln();
  writeln('Ordenando fechas de menor a mayor...');
  ordenarFechas(v);
  
  // Imprimir fechas ordenadas
  writeln('Fechas ordenadas:');
  imprimirFechas(v);
  

end.
