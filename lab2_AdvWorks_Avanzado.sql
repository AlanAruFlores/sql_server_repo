
/*Lab2_AdvWorks_Avanzado*/

use AdventureWorks2014;

/*
	1)Listar los nombres de los productos y el nombre del modelo
	que posee asignado. Solo listar aquellos que tengan asignado
	algún modelo.
*/
select pp.Name as 'Producto', pm.Name as 'Modelo'
from Production.Product as pp inner join 
Production.ProductModel pm on pp.ProductModelID = pm.ProductModelID;

/*
	2) Mostrar “todos” los productos junto con el modelo que tenga
	asignado. En el caso que no tenga asignado ningún modelo,
	mostrar su nulidad. 
*/
select pp.Name as 'Producto', pm.Name as 'Modelo'
from Production.Product as pp left join 
Production.ProductModel pm on pp.ProductModelID = pm.ProductModelID;


/*
	3) Ídem Ejercicio2, pero en lugar de mostrar nulidad, mostrar la
	palabra “Sin Modelo” para indicar que el producto no posee un
	modelo asignado. 
*/
select pp.Name as 'Producto', 
case when pm.Name is null then 'Sin Modelo'
else pm.Name
end as 'Modelo'
from Production.Product as pp left join 
Production.ProductModel pm on pp.ProductModelID = pm.ProductModelID;

/*
	4) Contar la cantidad de Productos que poseen asignado cada
	uno de los modelos.
*/
select pm.Name, count(*) as 'cantidad'
from Production.Product as pp inner join 
Production.ProductModel pm on pp.ProductModelID = pm.ProductModelID
group by pm.ProductModelID, pm.Name


/*
	5)  Contar la cantidad de Productos que poseen asignado cada
	uno de los modelos, pero mostrar solo aquellos modelos que
	posean asignados 2 o más productos. 
*/
select pm.Name, count(*) as 'cantidad'
from Production.Product as pp inner join 
Production.ProductModel pm on pp.ProductModelID = pm.ProductModelID
group by pm.ProductModelID, pm.Name
having count(*) >= 2;

/*
	6) Contar la cantidad de Productos que poseen asignado un
	modelo valido, es decir, que se encuentre cargado en la tabla
	de modelos. Realizar este ejercicio de 3 formas posibles:
	“exists” / “in” / “inner join”. 
*/


--exists
select pm.Name as 'Categoria', count(*) as 'cantidad'
from Production.Product as pp,
Production.ProductModel as pm 
where pp.ProductModelID = pm.ProductModelID and exists(
	select pm2.ProductModelID
	from Production.ProductModel pm2
	where pm2.ProductModelID = pp.ProductModelID
)
group by pm.ProductModelID, pm.Name

--in
select pm.Name as 'Categoria', count(*) as 'cantidad'
from Production.Product as pp,
Production.ProductModel as pm 
where pp.ProductModelID = pm.ProductModelID and pp.ProductModelID in (
	select pm2.ProductModelID
	from Production.ProductModel pm2
)
group by pm.ProductModelID, pm.Name

--inner join
select pm.Name, count(*) as 'cantidad'
from Production.Product as pp inner join 
Production.ProductModel pm on pp.ProductModelID = pm.ProductModelID
group by pm.ProductModelID, pm.Name;

/*
	7) . Contar cuantos productos poseen asignado cada uno de los
	modelos, es decir, se quiere visualizar el nombre del modelo y
	la cantidad de productos asignados. Si algún modelo no posee
	asignado ningún producto, se quiere visualizar 0 (cero). 
*/

select pm.Name as 'Modelo', 
case WHEN COUNT(pp.ProductID) = 0 THEN 0 --Evalua aquellos registros que no tengan una relacion con la tabla producto
else count(*)
end as 'Cantidad'
from Production.Product as pp right join 
Production.ProductModel pm on pp.ProductModelID = pm.ProductModelID
group by pm.ProductModelID, pm.Name;

/*
	8) Se quiere visualizar, el nombre del producto, el nombre
		modelo que posee asignado, la ilustración que posee asignada
		y la fecha de última modificación de dicha ilustración y el
		diagrama que tiene asignado la ilustración. Solo nos interesan
		los productos que cuesten más de $150 y que posean algún
		color asignado. 
*/

select * from Production.Product;
select * from Production.ProductModel;
select * from Production.ProductModelIllustration;
select * from Production.Illustration;

select pp.Name as 'Producto', pm.Name as 'Modelo', pi.ModifiedDate as 'Fecha Modificacion', pi.Diagram as 'Diagrama'
from Production.Product as pp inner join Production.ProductModel as pm on pp.ProductModelID = pm.ProductModelID
	inner join Production.ProductModelIllustration as pmi on pm.ProductModelID = pmi.ProductModelID
	inner join Production.Illustration as pi on pmi.IllustrationID = pi.IllustrationID;


/*
	9) . Mostrar aquellas culturas que no están asignadas a ningún
		producto/modelo.	
*/

/*
select pc.Name as 'Cultura', count(*) as 'Cantidad'
from Production.ProductModel as pm inner join Production.ProductModelProductDescriptionCulture as pmpc
	on pm.ProductModelID = pmpc.ProductModelID inner join Production.Culture pc 
	on pc.CultureID = pmpc.CultureID
group by pc.CultureID, pc.Name;
*/
select pc.Name as 'Cultura', 
case when count (pmpc.ProductModelID) = 0 THEN 0
else count(*) 
end as 'Cantidad'
from Production.Culture as pc left join Production.ProductModelProductDescriptionCulture as pmpc
	on pc.CultureID = pmpc.CultureID
group by pc.CultureID, pc.Name
having count(pmpc.ProductModelID) = 0;


/*
	10) Agregar a la base de datos el tipo de contacto “Ejecutivo de
		Cuentas” (Person.ContactType) 
*/
insert into Person.ContactType (Name, ModifiedDate) values ('Ejecutivo de Cuentas', GETDATE());


/*
	11) Agregar la cultura llamada “nn” – “Cultura Moderna”. 
*/
insert into Production.Culture (CultureID,Name, ModifiedDate) values('nn','Cultura Moderna', GETDATE());


/*
	12) Cambiar la fecha de modificación de las culturas Spanish,
	French y Thai para indicar que fueron modificadas hoy. 
*/

update Production.Culture set ModifiedDate = GETDATE()
where Name in ('Spanish', 'French', 'Thai');

/*
	13) En la tabla Production.CultureHis agregar todas las culturas
	que fueron modificadas hoy. (Insert/Select). 

*/

GO
--drop view culturas_hoy;
create view culturas_hoy as select * from Production.Culture where DATEDIFF(DAY, ModifiedDate, GETDATE()) = 0;
GO

select * 
into Production.CultureHis
from culturas_hoy

select * from Production.CultureHis;


/*
	14) Al contacto con ID 10 colocarle como nombre “Juan Perez”. 
*/
update Person.ContactType set [Name] = 'Juan Perez' where ContactTypeID = 10;

/*
	15) Agregar la moneda “Peso Argentino” con el código “PAR”
		(Sales.Currency) 
*/
insert into Sales.Currency values ('PAR', 'Peso Argentino', GETDATE());

/*
	16) ¿Qué sucede si tratamos de eliminar el código ARS
		correspondiente al Peso Argentino? ¿Por qué? 

		Salta un error a la hora de eliminar el registro debido a que la misma esta siendo referenciada en otras tablas de la base de datos.
*/
delete Sales.Currency where CurrencyCode like 'ARS';

/*
	17) Realice los borrados necesarios para que nos permita eliminar
	el registro de la moneda con código ARS. 
*/
select * from Sales.CountryRegionCurrency;
select * from Sales.CurrencyRate;

delete Sales.CountryRegionCurrency where CurrencyCode like 'ARS';
delete Sales.CurrencyRate where ToCurrencyCode like 'ARS';
delete Sales.Currency where CurrencyCode like 'ARS';


/*
	18)	Eliminar aquellas culturas que no estén asignadas a ningún
	producto (Production.ProductModelProductDescriptionCulture) 
*/
select * from Production.Culture;
select * from Production.ProductModelProductDescriptionCulture;

delete Production.Culture where CultureID not in (
	select CultureID
	from Production.ProductModelProductDescriptionCulture 
	group by CultureID
);




