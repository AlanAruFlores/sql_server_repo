/*
	Lab6_AdvWorks_StoreProcedure
*/
use AdventureWorks2014;

exec sp_help 'Production.Culture'


--1)
create proc sp_InsCulture(@id nchar(12),@name  varchar(100), @date datetime)
as 
	insert into Production.Culture (CultureID, Name, ModifiedDate) values(@id,@name,@date);
go

declare @date datetime = getdate();
exec sp_InsCulture 'es', 'espanol', @date


-- 2)
create proc sp_SelCulture(@id nchar(12))
as
	select * from Production.Culture where CultureID = @id;
go
exec sp_SelCulture 'es';

--3)
create proc sp_DelCulture(@id nchar(12))
as
	delete Production.Culture where CultureID = @id;
go
exec sp_DelCulture 'es';

--4)
create proc sp_UpdCulture(@id nchar(12))
as
	update Production.Culture set Name = 'Nuevo Name' where CultureID = @id;
go

exec sp_UpdCulture 'en';

--5)
create proc sp_CantCulture(@cant int OUTPUT)
as
	select @cant=COUNT(*) from Production.Culture;
go
declare @cant int;
exec sp_CantCulture @cant output;
select @cant;

--6)
create proc sp_CultureAsignadas
as
	select c.CultureID, c.Name 
	from Production.Culture as c inner join Production.ProductModelProductDescriptionCulture pmdc on c.CultureID  = pmdc.CultureID
	group by c.CultureID, c.Name
go

exec sp_CultureAsignadas;

--7) (Arreglar)

alter proc sp_ExisteCultureId(@id nchar(12), @existe smallint output)
as
	declare @cantidad int = 0;
	select @cantidad = COUNT(*) from Production.Culture where CultureID = @id;
	if @cantidad > 0 
	begin
		set @existe = 1;
	end
	else
	begin
		set @existe = 0;
	end
go

alter proc sp_ExisteCultureName(@name varchar(100), @existe smallint output)
as
	declare @cantidad int = 0;
	select @cantidad = COUNT(*) from Production.Culture where Name = @name;
	if @cantidad > 0 
	begin
		set @existe = 1;
	end
	else
	begin
		set @existe = 0;	
	end
go

alter proc sp_ValidarCamposNoVaciosCulture(@id nchar(12), @name varchar(100), @date datetime, @valida int output)
as
	if(@id is null or @name is null or @date is null)
	begin
		set @valida = 0;
	end
	else if (@id is not null and @name is not null or @date is not null)
	begin
		set @valida = 1;
	end
go

alter proc sp_ValidarFechaCulture(@date datetime , @valida int output)
as

	if(@date < getdate())
	begin
		set @valida = 0;
	end
	else
	begin
		set @valida = 1;
	end
go

alter proc sp_ValCulture(@id nchar(12), @name varchar(100),@date datetime, @operacion varchar(1), @valida smallint out)
as
		set @valida = 0;

		if @operacion = 'U'
		begin
			declare @idValido smallint;
			exec sp_ExisteCultureId @id, @idValido output;
			if(@idValido = 1)
			begin
				set @valida = 1
			end
		end
		
		else if @operacion = 'I'
		begin
			declare @idValido smallint , @nameValido smallint,
				@campoValidos smallint , @fechaValida smallint;
			
			print('Insert');

			exec sp_ExisteCultureId @id, @idValido output;
			exec sp_ExisteCultureName @name, @nameValido output;
			exec sp_ValidarCamposNoVaciosCulture @id,@name,@date,@campoValidos output;
			exec sp_ValidarFechaCulture @date , @fechaValida output;
			
			if(@idValido = 1 and @nameValido = 1 and @campoValidos = 1 and @fechaValida = 1)
			begin
				set @valida = 1
			end
		end
		
		else if @operacion = 'D'
		begin
			declare @idValido smallint;
			exec sp_ExisteCultureId @id, @idValido output;
			if(@idValido = 1)
			begin
				set @valida = 1
			end
		end
go


declare @fechaCulture datetime = getdate();
declare @valida int;

exec sp_ValCulture 'us', 'australiano',@fechaCulture,'I', @valida output;
select @valida as 'Operacion Valida';


-- 8)
create proc sp_SelCulture2(@id nchar(12) out, @name varchar(100) out, @date datetime out)
as
	select @id=CultureID, @name = Name,  @date = ModifiedDate from Production.Culture  where CultureID =@id; 
go

declare @id nchar(12) = 'en', @name varchar(100),  @date datetime;

exec sp_SelCulture2 @id output , @name output , @date output;
select @id, @name,@date;

--9)

select * from Production.Culture;


