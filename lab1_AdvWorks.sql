/*Lab1_AdvWorks*/

use AdventureWorks2014;

-- 1) Listar los códigos y descripciones de todos los productos
select [ProductID] as 'Codigo', [Name] as 'Descripcion' 
from Production.Product;


-- 2) Listar los datos de la subcategoria 17
select * 
from Production.ProductSubcategory 
where [ProductSubcategoryID] = 17; 

-- 3) Listar los productos cuya descripción comience con D
select * 
from Production.Product 
where [Name] like 'd%';

-- 4) Listar las descripciones de los productos cuyo número finalice con 8
select * 
from Production.Product 
where [ProductNumber] like '%8';

-- 5) Listar aquellos productos que posean un color asignado. Se deberán excluir todos aquellos que no posean ningún valor 
select * 
from Production.Product 
where [Color] is not null;

-- 6) Listar el código y descripción de los productos de color Black (Negro) y que posean el nivel de stock en 500. 
select [ProductID] as 'Codigo', [Name] as 'Descripcion' 
from Production.Product
where [Color] like '%Black%' and [SafetyStockLevel] = 500;

-- 7) Listar los productos que sean de color Black (Negro) ó Silver(Plateado)
select * 
from Production.Product
where [Color] in ('Black', 'Silver');

-- 8) Listar los diferentes colores que posean asignados los productos. Sólo se deben listar los colores.
select distinct [Color]
from Production.Product
where [Color] is not null

-- 9) Contar la cantidad de categorías que se encuentren cargadas en la base. (Ayuda: count) 
select count(*) as 'Cantidad de categorias' 
from Production.ProductCategory 

-- 10) Contar la cantidad de subcategorías que posee asignada la categoría 2. 
select count(*) as 'Cantidad' 
from Production.ProductSubcategory 
where [ProductCategoryID] = 2

-- 11) Listar la cantidad de productos que existan por cada uno de los colores. 
select [Color] , count(*) as 'Cantidad'
from Production.Product
where [Color] is not null
group by [Color];

-- 12) Sumar todos los niveles de stocks aceptables que deben existir para los productos con color Black
select sum(SafetyStockLevel) as 'Cantidad'
from Production.Product
where [Color] like '%Black%';

-- 13) Calcular el promedio de stock que se debe tener de todos los productos cuyo código se encuentre entre el 316 y 320. 
select avg(SafetyStockLevel) as 'Promedio'
from Production.Product
where [ProductID] between 316 and 320;

-- 14) Listar el nombre del producto y descripción de la subcategoría que posea asignada. (Ayuda: inner join)
select pp.Name as 'Producto', ps.Name as 'Subcategoria'
from Production.Product as pp inner join Production.ProductSubcategory as ps on pp.ProductSubcategoryID = ps.ProductSubcategoryID;


-- 15)  Listar todas las categorías que poseen asignado al menos una subcategoría. Se deberán excluir aquellas que no posean ninguna.
select distinct pc.*
from Production.ProductCategory as pc inner join Production.ProductSubcategory as ps on pc.ProductCategoryID = ps.ProductCategoryID;

-- 16) Listar el código y descripción de los productos que posean fotos asignadas
select pp.ProductID as 'Codigo', pp.Name as 'Producto'
from Production.Product as pp inner join Production.ProductProductPhoto as ppc on pp.ProductID = ppc.ProductID
inner join Production.ProductPhoto as pph on pph.ProductPhotoID = ppc.ProductPhotoID;

-- 17) Listar la cantidad de productos que existan por cada una de las Clases
select [Class] as 'Clase', count(*) as 'Cantidad'
from Production.Product
where [Class] is not null
group by [Class];

/*
	18)Listar la descripción de los productos y su respectivo color. Sólo
	nos interesa caracterizar al color con los valores: Black, Silver
	u Otro. Por lo cual si no es ni silver ni black se debe indicar
	Otro. (Ayuda: utilizar case).
*/
select [Name] as 'Descripcion',
case when [Color] not in ('Black', 'Silver') THEN 'Otro' -- Si no es black o silver, devuelve 'Otro'
else [Color] -- Retorno el campo en caso de que no se cumpla la condicion del when
end as 'Color' -- Nombre del campo nuevo
from Production.Product
where [Color] is not null;




-- 19)  Listar el nombre de la categoría, el nombre de la subcategoría y la descripción del producto. (Ayuda: join) 
select p.Name as 'Producto', ps.Name as 'Subcategoria', pc.Name as 'Categoria'
from Production.Product as p
inner join Production.ProductSubcategory as ps on p.ProductSubcategoryID = ps.ProductSubcategoryID
inner join Production.ProductCategory as pc on pc.ProductCategoryID = ps.ProductCategoryID;

-- 20) Listar la cantidad de subcategorías que posean asignado los productos. (Ayuda: distinct). 
select count(distinct p.ProductID)
from Production.Product as p
inner join Production.ProductSubcategory as ps on p.ProductSubcategoryID = ps.ProductSubcategoryID
inner join Production.ProductCategory as pc on pc.ProductCategoryID = ps.ProductCategoryID;


SELECT * FROM Production.Product;
SELECT * FROM Production.ProductDescription;
select * from Production.ProductCategory;
select * from Production.ProductSubcategory;
select * from Production.ProductPhoto;
