
--Creacion de la base de datos con sus archivos de datos y log de transacciones.
CREATE DATABASE Prueba 
ON (
NAME = 'Prueba_Data',
FILENAME = 'C:\DATA\Prueba.mdf',
 SIZE = 20 MB, 
FILEGROWTH = 0) 
LOG ON (NAME = 'Prueba_Log',
FILENAME = 'C:\DATA\Prueba_Log.ldf', 
SIZE = 5 MB, 
FILEGROWTH = 0);

-- Metadatos

select * from sys.databases; -- MUESTRA TODAS LAS Bases de datos DEL SISTEMA

select * from sys.database_files; -- MUESTRA LA UBICACION DE LOS ARCHIVOS de datos y transacciones (RUTA)

select * from sys.tables; -- MUESTRA LAS TABLAS DE UNA BD

select * from sys.views; -- MUESTRA LAS VISTAS DE UNA BD

select * from sys.columns; -- DEVUELVE UN REGISTRO POR CADA COLUMNADE UN OBJETO

select * from sys.sysfiles; -- MUESTRA LOS ARCHIVOS DE LA BD Actual

--SEGURIDAD 

select * from sys.database_permissions;

select * from sys.database_role_members;


-- FUNCIONES DEL SISTEMA (DEVUELVEN INFORMACION ACERCA DE LA BD Y DE LOS OBJETOS DE LA MISMA)

/* DB_ID: DEVUELVE EL NUMERO DE IDENTIFICADOR DE LA BD */
select db_id('crud_producto'); -- 10

/* DB_NAME: DEVUELVE EL NOMBRE DE LA BD*/
select db_name(10); -- crud_producto

/* FILE_ID: DEVUELVE EL NUMERO DE IDENTIFICACION DEL ARCHIVO (ID) DEL NOMBRE DEL ARCHIVO LOGICO DADO DE LA BD ACTUAL*/
select file_id('crud_producto');

select file_name(1);



--PROCEDIMIENTOS ALMACENADOS DEL SISTEMA
/*
	Estos son algunos de los procedimientos almacenados de sistema que permiten consultar 
	información sobre base de datos: 
*/

exec sp_databases; -- Muestra las bases de datos y su tamaño en MB


exec sp_helpdb; -- Muestra toda la informacion de las bases de datos de un servidor

exec sp_help; -- Muestra toda la informacion de una base de datos











