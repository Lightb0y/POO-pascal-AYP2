{ACTIVIDAD 3: Crear el archivo UEncomienda.pas
Cree un objeto Encomienda para representar las encomiendas que se
envían y reciben por correo.
Estado:
- remitente, destinatario: string
- peso: real
Comportamiento
- create(unRemitente, unDestinatario: string; unPeso: real)
- getRemitente(): string
- getDestinatario(): string
- getPeso(): real;
- toString(): ansistring // Devuelve en formato string toda la
// información de la encomienda
ACLARACIONES:
● La función debe devolver un dato de tipo ansistring
● En la declaración se debe agregar la cláusula override
(hacia el final del módulo veremos porqué)
function toString(): ansistring; override;
● En la implementación:
function Encomienda.toString(): ansistring;
begin
{ Puede usar la función format para convertir un número entero o
real en un string. Para poder usarla agregue sysutils en la
cláusula uses. }
toString:= destinatario + remitente + format('%10.3f', [peso]);
end;}
unit UEncomienda;
{$mode objfpc}

interface
 uses sysutils;
  type
     Encomienda = class
       private
          remitente,destinatario:string;
          peso:real;
       public 
          constructor create(unRemitente,unDestinatario:string;unPeso:real);
          function getRemitente():string;
          function getDestinatario():string;
          function getPeso():real;
          function toString():ansistring; override;
     end;
implementation

 constructor Encomienda.create(unRemitente,unDestinatario:string;unPeso:real);
  begin
    remitente:=unRemitente;
    destinatario:= unDestinatario;
    peso:= unPeso;
  end;

 function Encomienda.getRemitente():string;
  begin
    getRemitente:=remitente;
  end; 
  function encomienda.getDestinatario():string;
   begin
     getDestinatario:= destinatario;
   end;
   function encomienda.getPeso():real;
    begin
      getPeso:= peso;
    end;
   function encomienda.toString():ansistring;
    begin
      toString:= 'Destinatario: '+ destinatario + ' | Remitente: '+ remitente + ' |Peso: ' + format('%10.3f',[peso]);
    end;
end.     
