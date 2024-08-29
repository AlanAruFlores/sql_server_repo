/*
	Funciones en SQL Server
*/
use Northwind;

--Obtenemos la version y el lenguaje
select @@VERSION;
select @@LANGUAGE;

/* min , max, count ,sum*/

--Min : obtiene el valor minimo de una columna
select min([Extension]) as 'Extension min'
from Employees;

--Max : obtiene el valor maximo de una columna
select max([Extension]) as 'Extension max'
from Employees;

--Count : obtiene la cantidad de registros
select count(*) as 'Cantidad de empleados'
from Employees;

--Sum : obtiene la sumatoria de una columna
select sum([EmployeeID]) as 'Sumatoria de ids'
from Employees;


--Conversiones de datetime a varchar
select convert(varchar(255), GETDATE(), 103) as 'VARCHAR DATETIME';


