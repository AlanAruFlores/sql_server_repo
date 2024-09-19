
/*
	Practicas con las vistas de SQL Server
*/


use Northwind;

/*Ej1:Crear una vista de los pedidos(nro y total($)) 
de clientes de argentina.*/


create view VistaPedidos as
select o.[OrderID] as 'Numero de pedido' , sum(od.UnitPrice * od.Quantity) as 'Total'
from dbo.Orders o inner join dbo.[Order Details] od on o.OrderID = od.OrderID
inner join dbo.Customers c on o.CustomerID = c.CustomerID
where c.Country like '%Argentina%'
group by o.[OrderID];

select * from VistaPedidos;

/*
Ejer2:Crear una vista con los totales de flete x Pais
*/

create view VistaFletesPais as
select ShipCountry as 'Pais',SUM(Freight) as 'Flete' from Orders
group by ShipCountry;


select * from VistaFletesPais;

/*
Ejer3 :Crear una vista con los productos ( nombres  y cantidades en el año 1998
*/

create view VistaProductos1998 as 
select p.ProductName , SUM(od.Quantity) as 'Cantidad'
from [Order Details] od inner join Orders o on od.OrderID = o.OrderID
inner join Products p on od.ProductID = p.ProductID
where year(OrderDate) = 1998
group by p.ProductName;

select * from VistaProductos1998

/*
Ejer5:Crear una vista con las categorias , los proveedores y sus productos
*/

create view VistaProductoCategoriaProveedor as
select p.ProductName as 'Producto', c.CategoryName as 'Categoria', s.CompanyName as 'Proveedor'
from Products p inner join Categories c on p.CategoryID = c.CategoryID
inner join Suppliers s on p.SupplierID = s.SupplierID;

select * from VistaProductoCategoriaProveedor;

/*
Ejer6:Crear una vista con los empleados, sus importes totales de los pedidos en 1996
*/

create view VistaEmpleadosImporte1996 as
select (em.FirstName +' '+ em.LastName) as 'Empleado', SUM(od.Quantity*od.UnitPrice) as 'Importe Total'
from Orders o inner join Employees em on o.EmployeeID =  em.EmployeeID
inner join [Order Details] od on od.OrderID = o.OrderID
where year(o.OrderDate) = 1996
group by em.FirstName, em.LastName;

select * from VistaEmpleadosImporte1996;


