use Northwind;


--Creamos la vista
create view dbo.VistaPrecios
as select [ProductName] as Producto, [UnitPrice] as Precio from dbo.Products;

--Nos muestra la consulta almacenada de la vista
sp_Helptext VistaPrecios;

--Mostramos la vista
select * from dbo.VistaPrecios;

--Modificar
alter view dbo.VistaPrecios 
as select [ProductName] as Producto, [UnitPrice] as Precio , [CategoryID] as CategoriaId from dbo.Products;

--Encriptar la vista
alter view dbo.VistaPrecios with encryption
as select [ProductName] as Producto, [UnitPrice] as Precio , [CategoryID] as CategoriaId from dbo.Products;

