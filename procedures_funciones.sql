﻿
/*Procedimientos y Funciones*/


/*GO --> indica un lote de instrucciones a ejecutar (Fin de un BATCH)*/

DECLARE
@numero varchar(10) = '1',
@numero2 varchar(10) = '2';

--go, si descomento este go entonces habran 2 batchs donde las variables se declaran en el 1er batch y por tanto no estarian disponibles para el 2do batch 

print('El numero 1 es: '+@numero);
print('El numero 2 es: '+@numero2);
go


declare @variable int;
set @variable = 20;

select @variable

/*
Queremos saber todos los datos de productos con mayor precio de la tabla "Product". 
Para ello podemos emplear una variable para almacenar el precio más alto
*/

use Northwind;
declare @precioMaximo float;
select @precioMaximo = MAX(UnitPrice) from [dbo].Products;
select * from [dbo].Products where UnitPrice = @precioMaximo;


-- Crear un procedimiento almacenado
create proc MayoresPrecios 
as
select * from dbo.Products where UnitPrice > 100;
go

exec dbo.MayoresPrecios;

-- Modificar un procedimiento almacenado
alter proc MayoresPrecios 
as
select * from dbo.Products where UnitPrice > 40;
go

exec dbo.MayoresPrecios


--Eliminar un procedimiento almacenado
drop proc MayoresPrecios;
exec dbo.MayoresPrecios;


--Procedimiento con parametros
create proc MayoresPreciosEntre (@desde_precio float, @hasta_precio float)
as
	select * from dbo.Products where UnitPrice between @desde_precio and @hasta_precio;
go

exec MayoresPreciosEntre 10.0, 20.0;


--Procedicimiento con parametros de entrada y salida

create proc sp_multiplicar (@numero_uno int , @numero_dos int, @resultado int OUTPUT)
as
	set @resultado = @numero_uno * @numero_dos;
go
declare @res int;
exec sp_multiplicar 2, 4, @res OUTPUT; 
select @res;


-- TRY CATCH

create proc sp_excepcionAritmetica
as
	begin try -- Intenta realizar este comando
		select 1/0 as 'Error';
	end try
	begin catch -- Si surge una excepcion, salta los logs 
		select ERROR_LINE() as 'Linea de error',
			   ERROR_MESSAGE() as 'Mensaje Error',
			   ERROR_STATE() as 'Error State',
			   ERROR_PROCEDURE() as 'Error Procedure',
			   ERROR_SEVERITY() as 'Error Severity';
	end catch
go

exec sp_excepcionAritmetica;


/*Funciones Escalares*/
use AdventureWorks2014

--Funciones Escalares
create schema Sales;

CREATE FUNCTION Sales.SumSold(@ProductID int) RETURNS int  
AS  
BEGIN 
  DECLARE @ret int 
  SELECT @ret = SUM(OrderQty)  
  FROM Sales.SalesOrderDetail WHERE ProductID = @ProductID  
  IF (@ret IS NULL)  
    SET @ret = 0 
  RETURN @ret 
END 

SELECT ProductID, [Name], Sales.SumSold(ProductID) AS SumSold FROM Production.Product; 


--Funciones Tabulares en Linea
CREATE FUNCTION HumanResources.EmployeesForBussinesEntityId(@BussinessEntityId int)  
RETURNS TABLE 
AS 
RETURN  
( 
  SELECT * 
  FROM HumanResources.Employee Employee  
  WHERE Employee.BusinessEntityID = @BussinessEntityId  
) 

SELECT * FROM HumanResources.EmployeesForBussinesEntityId(3) 
SELECT * FROM HumanResources.EmployeesForBussinesEntityId(6) 

--Funciones Tabulares MultiSentencia

CREATE FUNCTION HumanResources.EmployeeNames(@format nvarchar(9)) 
RETURNS @tbl_Employees TABLE --Devuelve una tabla con su nombre especifico
  ( 
    EmployeeID int PRIMARY KEY,  
    EmployeeName nvarchar(100) 
  ) 
AS 
BEGIN 
  IF (@format = 'SHORTNAME') 
    INSERT @tbl_Employees  
    SELECT [BusinessEntityID], LastName  
    FROM Person.Person
  ELSE IF (@format = 'LONGNAME') 
    INSERT @tbl_Employees  
    SELECT [BusinessEntityID], (FirstName + ' ' + LastName)  
    FROM Person.Person 
RETURN 
END 

select * from HumanResources.EmployeeNames('SHORTNAME');
select * from HumanResources.EmployeeNames('LONGNAME');

SELECT * FROM Person.Person









