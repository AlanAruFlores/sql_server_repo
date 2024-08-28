
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
from Production.Product as pp right join 
Production.ProductModel pm on pp.ProductModelID = pm.ProductModelID
group by pm.ProductModelID, pm.Name


/*
	5)  Contar la cantidad de Productos que poseen asignado cada
	uno de los modelos, pero mostrar solo aquellos modelos que
	posean asignados 2 o más productos. 
*/
select pm.Name, count(*) as 'cantidad'
from Production.Product as pp right join 
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







