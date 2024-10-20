/*TRANSACCIONES y BLOQUEOS*/

--Variables de tabla
declare @tablaVariable TABLE (nombre varchar(100), apellido varchar(100));
insert into @tablaVariable values ('asdasd','asdasd');
select * from @tablaVariable;


--Transaccion: operacion atomica el cual realizar una seria de operaciones en una sola 1 unidad


--Transacciones Explicitas

begin transaction -- comienza la transaccion
	use AdventureWorks2014;
	insert into Production.Culture(CultureID,Name,ModifiedDate) values (14,'Language1', GETDATE())
	insert into Production.Culture(CultureID,Name,ModifiedDate) values (15,'Language2', GETDATE())
	insert into Production.Culture(CultureID,Name,ModifiedDate) values (16,'Language3', GETDATE())
	select * from Production.Culture;
commit transaction --confirma la transaccion
rollback transaction --revierte los cambios de la transaccion en caso de error


begin transaction -- comienza la transaccion
	begin try
		use AdventureWorks2014;
		insert into Production.Culture(CultureID,Name,ModifiedDate) values (14,'Language1', GETDATE())
		insert into Production.Culture(CultureID,Name,ModifiedDate) values (15,'Language2', GETDATE())
		insert into Production.Culture(CultureID,Name,ModifiedDate) values (16,'Language3', GETDATE())
		select * from Production.Culture;
	end try
	begin catch -- Si captura un error , rollback
		rollback transaction --revierte los cambios de la transaccion en caso de error
	end catch
commit transaction --confirma la transaccion


--Transacciones implicitas