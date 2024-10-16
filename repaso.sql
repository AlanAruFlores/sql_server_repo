use AdventureWorks2014;
select * from HumanResources.Department;


/*Sentencia Like*/
select * from HumanResources.Department where Name like '[a-e]%';

/*Funciones de agregado*/

-- Count
select count(*) as cantidad_manufacturing from HumanResources.Department where GroupName like 'Manufacturing'; 

-- Sum
select * from HumanResources.Employee;
select sum(VacationHours) as 'sumatoria_vacation_hours' from HumanResources.Employee;

--Max
select max(VacationHours) as 'maximo_vacation_hours' from HumanResources.Employee;

--Min
select min(VacationHours) as 'minimo_vacation_hours' from HumanResources.Employee;

--Avg
select avg(VacationHours) as 'promedio_vacation_hours' from HumanResources.Employee;

/*Group By*/
select * from HumanResources.Employee;

--Obtengo la cantidad de empleados por profesion
select [JobTitle], count(*) as cantidad 
from HumanResources.Employee
group by JobTitle;

--Obtengo la cantidad de empleados por genero
select Gender, count(*) as cantidad
from HumanResources.Employee
group by Gender;

--Obtengo la cantidad de empleados contratados en años mayores o iguales a 2010
select year(HireDate), count(*) as cantidad
from HumanResources.Employee
where year(HireDate) >= 2010
group by year(HireDate);




/*HAVING --> Realiza filtrado sobre funciones de agregacion*/
select * from HumanResources.Employee;

-- Obtener el genero con mayor presencia en la empresa

select [Gender] as 'Genero', count(*) 
from HumanResources.Employee 
group by [Gender]
having count(*) = (
	select max(cantidad)
	from (
		select count(*) as cantidad
		from HumanResources.Employee
		group by [Gender]
	) as subquery
);

-- Agrupar la cantidad de empleados cuyo nivel de organizacion sea mayor a 1
select [OrganizationLevel] as 'Nivel de Organizacion' , count(*) as 'Cantidad'
from HumanResources.Employee
where [OrganizationLevel] IS NOT NULL
group by OrganizationLevel
having [OrganizationLevel] > 1;


/*JOINS*/
select * from Person.BusinessEntity;
select * from HumanResources.Employee;

exec sp_help 'HumanResources.Employee'; -- Ver la estructura de una tabla
exec sp_pkeys 'HumanResources.Employee'; -- Ver las pks 
exec sp_fkeys 'HumanResources.Employee'; -- Ver las fks


-- INNER JOIN --> solo se incluyen en el resultado las filas que tienen coincidencias en ambas tablas según la condición especificada. Las filas de las tablas que no tienen coincidencias se ignoran en el resultado
select em.JobTitle , em.Gender, b.rowguid
from HumanResources.Employee em inner join Person.BusinessEntity b
on em.BusinessEntityID = b.BusinessEntityID


-- LEFT JOIN --> Tomas los registros de la tabla de la izquierda aunque no tenga ninguno con el derecho
select em.JobTitle , em.Gender, b.rowguid
from HumanResources.Employee em left join Person.BusinessEntity b
on em.BusinessEntityID = b.BusinessEntityID


--RIGHT JOIN --> Toma los registros de la tabla de la derecha aunque no tenga ninguno con el izquierdo
select em.JobTitle , em.Gender, b.rowguid
from HumanResources.Employee em right join Person.BusinessEntity b
on em.BusinessEntityID = b.BusinessEntityID;


--SELF JOIN --> Relacion a si misma
--Mostrar nombre de los empleados y el nombre de su jefe
use Northwind;

select em.FirstName as Empleado , j.FirstName as Jefe 
from Employees em left join Employees j on em.ReportsTo = j.EmployeeID;




--CROSS JOIN --> Trae la combinaciones de todos los registro
use AdventureWorks2014;
select *
from HumanResources.Employee as em cross join Person.BusinessEntity b
where em.BusinessEntityID <> b.BusinessEntityID;
/*
use Northwind;
select l.Nombre as 'Local',
'Vs' as Versus,
v.Nombre as Visitante
from equipos as l cross join equipos as v
where l.Nombre <> v.Nombre;
*/


--DISTINCT: Sirve solo para retornar valores distintos 
use Northwind;
select distinct Country as Pais from Employees;


--TOP: devuelve los primeros registros indicados 

--Ejemplo: devolver los primeros 3 empleados en estar recien contratados
select top 3 * from Employees order by [HireDate] desc;


/*
	INSERT / UPDATE /DELETE
*/

--INSERT --> Sirve para insertar un registro
select * from Categories;
INSERT INTO Categories(CategoryName, Description, Picture) VALUES('Categoria Nueva', 'asdasdsad', null);

--INSERT...SELECT --> tambien podemos usar una combinacion entre INSERT y SELECT, para insertar registros de un SELECT (opcionalmente con alguna condicion)
INSERT INTO Categories(CategoryName, Description, Picture)
	SELECT CategoryName, Description, Picture from Categories;

--SELECT...INTO --> sirve para insertar registros iniciales y crear una nueva tabla en una misma operacion

SELECT LastName as Apellido ,FirstName as Nombre, Title as Titulo
INTO Empleados
FROM Employees;

select * from Empleados

--DEFAULT --> permite para dar valores por defecto
INSERT INTO Empleados VALUES ('Prrueba', 'prueba', DEFAULT); 


--DELETE -->Sirve para eliminar registros (DML)
select * from Orders;

--Elimina los ordenes cuya fecha de envio con la actual , tengan una diferencia de 6 meses
DELETE Orders WHERE DATEDIFF(MONTH, ShippedDate, GETDATE()) >= 6;
	
--TRUNCATE -->Elimina todas las filas de una tabla (DDL)
select * from Empleados;
truncate table Empleados;

--DELETE Y INNER JOIN --> Elimina una relacion entre 2 tablas, eliminando registros de la tabla que contiene la FK
use Northwind;
select * from Orders;
select * from [Order Details];

select * from Orders o inner join [Order Details] od on od.OrderID = o.OrderID;

DELETE FROM [Order Details]
FROM [Orders] as o
inner join [Order Details] as od
ON o.OrderID = od.OrderID
where o.OrderID=10249

-- UPDATE --> Sirve para actualizar datos de los campos especificados en el SET
select * from empleados;
update Empleados set titulo = 'Titulo Actualizado' where Nombre like 'Nancy'; 

update Empleados set titulo = 'Sala Representativa' 
where Nombre in (
	select Nombre
	from Empleados
	where titulo like 'Sales Representative'
);
