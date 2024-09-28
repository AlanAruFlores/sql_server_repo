use AdventureWorks2014;

select * from sys.databases;
exec sp_databases;
exec sp_helpdb;

--Realizar una consulta que permita devolver la fecha y hora actual
declare @fecha_actual datetime;
set @fecha_actual = GETDATE();
select @fecha_actual;

--Realizar una consulta que permita devolver únicamente el año y mes actual:
declare @mes_actual datetime, @anio_actual datetime;
set @mes_actual = GETDATE();
set  @anio_actual = GETDATE();
select @mes_actual as 'Mes actual', @anio_actual as 'Anio Actual';


-- Realizar una consulta que permita saber cuántos días faltan para el día de la primavera (21-Sep)
declare @fecha_primavera datetime;
set @fecha_primavera = '2025-09-21';
select DATEDIFF(day,getdate(),@fecha_primavera) as 'Dias faltantes';


--Realizar una consulta que permita redondear el número 385,86 con únicamente 1 decimal
declare @numero decimal;
set @numero = 385.86;
select ROUND(@numero,1);


/*
	Realizar una consulta permita saber cuánto es el mes actual al cuadrado. Por
	ejemplo, si estamos en Junio, sería 62
*/

declare @mes_actual2 int;
set @mes_actual2 = MONTH(GETDATE());
select SQUARE(@mes_actual2) as 'Mes actual al cuadrado';


-- Devolver cuál es el usuario que se encuentra conectado a la base de datos
select 
SYSTEM_USER as 'Usuario',
CURRENT_USER as 'Usuario actual',
SESSION_USER as 'Sesion User';


--Realizar una consulta que permita conocer la edad de cada empleado
select  *,DATEDIFF(YEAR, [BirthDate], GETDATE()) as 'Edad' from HumanResources.Employee;


/*
Realizar una consulta que retorne la longitud de cada apellido de los
Contactos, ordenados por apellido. En el caso que se repita el apellido
devolver únicamente uno de ellos
*/
select distinct LastName, LEN(LastName) as 'Longitud' from Person.Person order by LEN(LastName) asc;


--Realizar una consulta que permita encontrar el apellido con mayor longitud.
select distinct LastName, LEN(LastName) as 'Longitud' from Person.Person
where LEN(LastName) = (select MAX(LEN(LastName)) from Person.Person);

--Devolver los últimos 3 dígitos del NationalIDNumber de cada empleado
select SUBSTRING([NationalIDNumber],LEN([NationalIDNumber])-3,3) from HumanResources.Employee

--Se desea enmascarar el NationalIDNumbre de cada empleado, de la siguiente forma ###-####-##:
select [NationalIDNumber],substring([NationalIDNumber],1,3)+'-'+SUBSTRING([NationalIDNumber],4,4)+
case
	when (SUBSTRING([NationalIDNumber],8,2) = '') 
	then ''
	else '-' + SUBSTRING([NationalIDNumber],8,2)
end
from HumanResources.Employee


/*
	Se quiere visualizar, el nombre del producto, el nombre
	modelo que posee asignado, la ilustración que posee asignada
	y la fecha de última modificación de dicha ilustración y el
	diagrama que tiene asignado la ilustración. Solo nos interesan
	los productos que cuesten más de $150 y que posean algún
	color asignado.
*/

select p.Name as 'Producto',
case
	when(pm.Name is not null)
	then pm.Name
	else 'No tiene modelo'
end as 'Modelo',
pi.Diagram as 'Ilustracion',
pi.ModifiedDate as 'Fecha de Modificacion'
from [Production].Product p 
left join [Production].ProductModel pm on p.ProductModelID = pm.ProductModelID
inner join Production.ProductModelIllustration pmi on pm.ProductModelID = pmi.ProductModelID
inner join Production.Illustration pi on pmi.IllustrationID = pi.IllustrationID
where p.ListPrice > 150 and p.Color is not null;


select * from Production.Product;

select * from Production.ProductCostHistory
select * from Production.ProductModel;
select * from Production.Illustration;
select * from Production.ProductModelIllustration;





--QUERY PARCIAL 1 PRACTICA



use Northwind;
--1)
create view v_ProductosFaltantes 
	as select p.ProductID as 'Codigo' , p.ProductName as 'Descripcion' , od.OrderID
from Products p left join [Order Details] od on p.ProductID = od.ProductID
where (p.UnitsInStock = 0) AND od.ProductID is null;
select * from v_ProductosFaltantes;

--2)
use CorreoCompras;
create schema Compras

--3)

/*
	Lo que hace el siguiente script es la creacion de una nueva base de datos denominada "Tecnicatura DB)
	donde se configuran las propiedades de 2 archivos: 
		1 de registro de datos
		1 de log de transacciones
	En el archivo de registro de datos tiene como propiedades su nombre, nombre del archivo, el tamaño inicial
	en KB, su tamaño maximo de 10240KB y su incremento
	En el archivo de log de transacciones se especifican tambien su nombre, nombre del archivo, tamaño inicial y 
	maxime e incremento en Porcentaje
*/

--4)
USE AdventureWorks2014;
select NationalIDNumber as 'Numero', substring(NationalIDNumber,1,3)+'-'+SUBSTRING(NationalIDNumber,4,3)+'-'+substring(NationalIDNumber,7,3) as 'Formato' from HumanResources.Employee;

--5-A)
use Northwind;
select DATEDIFF(YEAR, BirthDate, GETDATE()) as 'Edad', * from Employees

--5-B)
create view edadEmployee as
select DATEDIFF(YEAR, BirthDate, GETDATE()) as 'Edad' , * from Employees

select * from edadEmployee where Edad > 25;


--6) 
/*
a- Este error indica que la consulta es ineficiente debido a que la busqueda de los registros
se hace secuencialmente por lo tanto el rendimiento del mismo es bajo para volumenes de datos
grandes. Para su solucion es mejor optar por uso de indices recomendablemente clustered 

b- Para hacer mas eficiente a esta consulta si es que hace muchas consultas por apellido , es mejor 
usar indice de tipo agrupado o clustered.


*/

