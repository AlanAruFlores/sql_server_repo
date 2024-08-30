/*
	Lab3_AdvWors_FUNC_PREDETER
*/

use AdventureWorks2014;

-- 1) Realizar una consulta que permita devolver la fecha y hora actual 
select getdate() as 'fecha actual';

-- 2) Realizar una consulta que permita devolver �nicamente el a�o y mes actual: 
select year(getdate()) as 'a�o' , month(getdate()) as 'mes';


-- 3) Realizar una consulta que permita saber cu�ntos d�as faltan para el d�a de la primavera (21-Sep) 
select DATEDIFF(day, getdate(), '2024-09-21') as 'dias faltantes';


-- 4) Realizar una consulta que permita redondear el n�mero 385,86 con �nicamente 1 decimal. 
select round(385.86,1); --Redondeo el numero, con 1 decimal


-- 5) Realizar una consulta permita saber cu�nto es el mes actual al cuadrado.
select square(month(getdate()));


-- 6) Devolver cu�l es el usuario que se encuentra conectado a la base de datos 
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
devolver �nicamente uno de ellos*/

select LastName as 'Apellido', len(lastname) as 'Longitud'
from Person.Person
group by LastName;


-- 9) Realizar una consulta que permita encontrar el apellido con mayor longitud. 

select LastName as 'Apellido', len(lastname) as 'Longitud'
from Person.Person
where len(lastname) = (select max(len(lastname)) from Person.Person);



/* 
10) Realizar una consulta que devuelva los nombres y 
apellidos de los contactos que hayan sido modificados en los �ltimos 3 a�os. 
*/
select FirstName as 'Nombre', LastName as 'Apellido'
from Person.Person
where datediff(year, ModifiedDate, getdate()) <= 3;


-- 11) Se quiere obtener los emails de todos los contactos, pero en may�scula. 
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
13) Devolver los �ltimos 3 d�gitos del NationalIDNumber de cada empleado
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
15) Listar la direcci�n de cada empleado �supervisor� que haya nacido hace m�s
de 30 a�os. Listar todos los datos en may�scula. Los datos a visualizar son:
nombre y apellido del empleado, direcci�n y ciudad
*/


select *
from Person.Person;



