unit unProducto ;
{$mode objfpc}
interface
    type
       Producto = class
         private
            nombre:string;
            peso:real;
         public
            constructor create(unNombre:string;unPeso:real);
            function getNombre():string;
            function getPeso():real;
    end;
implementation
constructor producto.create(unNombre:string;unPeso:real);
begin
  nombre:=unNombre;
  peso:= unPeso;
end;
function  producto.getNombre():string;
 begin
   getNombre:= nombre;
 end;
function producto.getPeso():real;
  begin
    getPeso:= peso;
  end;

end.
