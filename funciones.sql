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

-- CONVERT()
select convert(varchar(255), GETDATE(), 103) as 'VARCHAR DATETIME';


--CAST() --> Se usa para castear variables
declare 
	@texto varchar(255),
	@numeroString varchar(10),
	@numero int;

set @texto = 'Hola';
select @texto+' desde SQL Server' as 'Texto'; -- Concateno 2 strings

set @numeroString='20';
set @numero = cast(@numeroString as int); -- casteo el varchar a un string
select @numero+'10' as 'Numero'; --Suma el valor del numero (20) + 10  = 30


