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


/*
	Funciones para cadenas
*/

-- SUBSTRING (cadena, inicio, longitud) --> obtiene una parte de la cadena especificada en los ultimos 2 argumentos
declare @saludo varchar(100);
set @saludo = 'Hola como esta?';
select substring(@saludo, 1,4); -- Hola

-- CHARINDEX (substring, string, inicio) --> busca un texto especifico dentro de otro texto, el ultimo parametro indica desde donde va a buscar
select charindex('como', @saludo, 4); -- Devuelve 6 ya que a partir de ese indice se encuentra el substring.

-- PATINDEX(%patron%, string) --> devuelve la posicion donde el patron se cumple en una cadena. Si no se encuentra devuelve 0
declare @indicePatIndex int;
set @indicePatIndex = PATINDEX('%como%', @saludo)
select @indicePatIndex as 'PATINDEX RESULTADO';

--str(numero, longitud, cantidad_decimales):  convierte el numero en caracteres, especificando 	
select str(123.456,7,2)-- en este caso le digo que el numero en decimales lo mande a string, pero que solo me muestre los 7 caracteres (2do parametro) y me muestre 2 decimales


--len(cadena): devuelve la longitud del texto enviado como argumento
select len('Hola SQL') as 'longitud';

--char(x): retorna un caracter del codigo ASCII
select char(100) as 'caracter';

--left(cadena,longitud): retorna una parte de esa cadena especificada en la longitud, empezando desde izquierda a derecha
select left('Hola SQL Server', 8);

--right(cadena,longitud): retorna una parte de esa cadena especificada en la longitud, empezando desde derecha a izquierda
select right('Hola SQL Server', 8);



--lower(cadena) retorna la cadena en caracteres minusculas
select lower('Base De Datos');

--upper(cadena) retorna la cadena en caracteres mayusculas
select upper('Base De Datos');


--ltrim(cadena) elimina	la cadena con  los espacios de la izquierda eliminados
select ltrim('   Texto    ');

--rtrim(cadena) elimina	la cadena con  los espacios de la derecha eliminados
select rtrim('     Texto    ');

--replace(cadena, string_reemplazo, string_a_reemplazar): retorna la cadena con todas las ocurrencias de la subcadena reemplazo por la subcadena a reemplazar. 
select replace('Hxla cxmx estan', 'x', 'o');

--reverse(cadena): retorna la cadena invertida
select reverse('Base de datos');


--replicate(cadena, cantidad): concatena o repite la cadena dependiendo de su cantidad
select replicate('Karl',4);


--space(n): devuelve espacios n veces
select 'Hola'+space(1)+'gente';
