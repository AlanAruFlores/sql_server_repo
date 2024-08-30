/*
	Lab3_AdvWors_FUNC_PREDETER
*/

use AdventureWorks2014;

-- 1) Realizar una consulta que permita devolver la fecha y hora actual 
select getdate() as 'fecha actual';

-- 2) Realizar una consulta que permita devolver únicamente el año y mes actual: 
select year(getdate()) as 'año' , month(getdate()) as 'mes';


-- 3) Realizar una consulta que permita saber cuántos días faltan para el día de la primavera (21-Sep) 
select DATEDIFF(day, getdate(), '2024-09-21') as 'dias faltantes';


-- 4) Realizar una consulta que permita redondear el número 385,86 con únicamente 1 decimal. 
select round(385.86,1); --Redondeo el numero, con 1 decimal


-- 5) Realizar una consulta permita saber cuánto es el mes actual al cuadrado.
select square(month(getdate()));


-- 6) Devolver cuál es el usuario que se encuentra conectado a la base de datos 
select SYSTEM_USER;


-- 7) Realizar una consulta que permita conocer la edad de cada empleado 
select * from HumanResources.Employee;


select [BusinessEntityID] ,
datediff(year, [BirthDate], getdate()) -
case 
	when dateadd(year, datediff(year, [BirthDate], getdate()), [Birthdate]) > getdate()
	then 1
	else 0
end
as edad
from HumanResources.Employee


/* 8) Realizar una consulta que retorne la longitud de cada apellido de los
Contactos, ordenados por apellido. En el caso que se repita el apellido
devolver únicamente uno de ellos*/

select LastName as 'Apellido', len(lastname) as 'Longitud'
from Person.Person
group by LastName;


-- 9) Realizar una consulta que permita encontrar el apellido con mayor longitud. 

select LastName as 'Apellido', len(lastname) as 'Longitud'
from Person.Person
where len(lastname) = (select max(len(lastname)) from Person.Person);



/* 
10) Realizar una consulta que devuelva los nombres y 
apellidos de los contactos que hayan sido modificados en los últimos 3 años. 
*/
select FirstName as 'Nombre', LastName as 'Apellido'
from Person.Person
where datediff(year, ModifiedDate, getdate()) <= 3;


-- 11) Se quiere obtener los emails de todos los contactos, pero en mayúscula. 
select upper([EmailAddress])
from Person.EmailAddress


/*
	12) Realizar una consulta que permita particionar 
	el mail de cada contacto, obteniendo lo siguiente: 
*/


select [BusinessEntityID], 
[EmailAddress] as Email,
substring([EmailAddress], 1, CHARINDEX('@',[EmailAddress], 1)-1) as Nombre,
substring( [EmailAddress], CHARINDEX('@',[EmailAddress], 1)+1, len([EmailAddress]) ) as Dominio
from Person.EmailAddress
order by BusinessEntityID asc;

/*
13) Devolver los últimos 3 dígitos del NationalIDNumber de cada empleado
*/

select NationalIDNumber, substring([NationalIDNumber],len(NationalIDNumber)-2,len(NationalIDNumber))
from HumanResources.Employee
order by BusinessEntityID asc


/*
14) Se desea enmascarar el NationalIDNumbre de cada empleado, de la
siguiente forma ###-####-##: 
*/

select NationalIDNumber,
substring(NationalIDNumber, 1, 3)+'-'+ substring(NationalIDNumber, 3,4)+ '-'+ substring(NationalIDNumber, 7,len(NationalIDNumber)) as 'Formato'
from HumanResources.Employee
order by BusinessEntityID asc


/*
15) Listar la dirección de cada empleado “supervisor” que haya nacido hace más
de 30 años. Listar todos los datos en mayúscula. Los datos a visualizar son:
nombre y apellido del empleado, dirección y ciudad
*/

select pp.FirstName as 'Nombre', pp.LastName as 'Apellido',pa.AddressLine1 as 'Direccion', pa.City as 'Ciudad'
from HumanResources.Employee as em inner join Person.Person as pp on em.BusinessEntityID = pp.BusinessEntityID
inner join Person.BusinessEntityAddress as bea on bea.BusinessEntityID = pp.BusinessEntityID
inner join Person.Address as pa on pa.AddressID = bea.AddressID
where datediff(year,em.BirthDate, getdate()) > 30 and pp.PersonType like 'SP';


/*
16. Listar la cantidad de empleados hombres y mujeres, de la siguiente forma: 
*/
select 
case 
when [Gender] = 'M' then replace([Gender], 'M', 'Masculino') 
else replace([Gender], 'F','Femenino')
end
as 'Sexo' , count(*) as 'Cantidad'
from HumanResources.Employee
group by [Gender];

/*
17. Categorizar a los empleados según la cantidad de horas de vacaciones,
según el siguiente formato:
*/

select pp.FirstName+space(1)+pp.LastName as 'Empleado', 
case
when em.VacationHours < 20 then 'Bajo'
when em.VacationHours >= 20 and em.VacationHours <=50 then 'Medio'
else 'Alto'
end as 'Horas'
from HumanResources.Employee as em inner join Person.Person as pp  on em.BusinessEntityID = pp.BusinessEntityID;
