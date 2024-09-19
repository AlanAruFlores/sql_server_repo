	CREATE DATABASE MusicaDB ON PRIMARY
	(
	NAME = 'Musica',
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Musica.mdf' ,
	SIZE = 5096KB ,
	MAXSIZE = 20480KB ,
	FILEGROWTH = 1024KB
	)
	LOG ON
	( NAME = 'Musica_log',
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Musica_log.ldf' ,
	SIZE = 2048KB ,
	MAXSIZE = 10240KB ,
	FILEGROWTH = 10%
	);
	
	use MusicaDB;

	select * from sys.databases;
		
	--2.1) Como politica de retencion de log se ha definido el nombre, la ruta, el tamaño inicial del archivo , en su caso 2MB. Luego
	--el tamaño maximo de ese archivo 10MB y por ultimo el incremento de la misma.


	--2.2) Si se crearan estadisticas automaticamente ya que viene en TRUE como valor por defecto
	select is_auto_create_stats_on
	from sys.databases
	where name like 'MusicaDB';

	--2.3) No es compatible con una base de datos de SQL Server 2000, sino con el 2014
	SELECT compatibility_level
	FROM sys.databases
	WHERE name = 'MusicaDB';



	-- 2.4) El juego de caracteres que se utilizara es el Modem_Spanish_CI_AS el cual 
	-- permite que se realicen comparaciones y ordenamientos de texto en español
	SELECT collation_name
	FROM sys.databases
	WHERE name = 'MusicaDB';

	--3) Crear schema discos
	create schema discos;

	--4)
	create table discos.artista(
		artno smallint NOT NULL,
		nombre varchar(50) NULL,
		clasificacion char(1) NULL,
		bio text NULL,
		foto image null,
		CONSTRAINT PK_Artista PRIMARY KEY CLUSTERED (artno)
	
	);

	create table discos.concierto(
		artno smallint NOT NULL,
		fecha datetime  NOT NULL, 
		ciudad varchar(25),
		CONSTRAINT pk_concierto PRIMARY KEY (artno, fecha),
		CONSTRAINT fk_concierto_artno FOREIGN KEY(artno) REFERENCES discos.artista(artno)
	);

	

	
	create table discos.album(
		titulo varchar(50) NOT NULL,
		artno smallint NOT NULL,
		itemno smallint NOT NULL,
		CONSTRAINT pk_album PRIMARY KEY(itemno),
		CONSTRAINT fk_album_artno FOREIGN KEY(artno) REFERENCES discos.artista(artno)
	);

	create table discos.stock(
		itemno smallint NOT NULL,
		tipo char(1),
		precio decimal(5,2),
		cantidad int,
		CONSTRAINT pk_stock PRIMARY KEY(itemno),
		CONSTRAINT fk_stock_itemno FOREIGN KEY(itemno) REFERENCES discos.album(itemno)
	);

	create table discos.orden(
		itemno smallint NOT NULL,
		timestamp timestamp,
		CONSTRAINT pk_orden PRIMARY KEY(itemno),
		CONSTRAINT fk_orden_itemno FOREIGN KEY(itemno) REFERENCES discos.stock(itemno)
	);



	--5) Crear un diagrama con el modelo relacional generado. (Listo)


	--6.1)
	alter table discos.concierto alter column ciudad varchar(30);
	exec sp_help 'discos.concierto'; -- muestro la estructura de una tabla
	
	--6.2)
	alter table discos.stock add constraint df_precio default 0 for precio;
	exec sp_help 'discos.stock'; -- muestro la estructura de una tabla
	
	--6.3)En la tabla de álbumes el nombre del título no puede ser nulo.
	alter table discos.album alter column titulo varchar(50) not null
	exec sp_help 'discos.album'

	/*
		7. Agregar los siguientes registros dentro de la base de datos creada:
	- 3 artistas
	- 2 conciertos por cada uno de los artistas en diferentes fechas y ciudades
	- 2 álbumes por cada uno de los artistas
	- Stock sólo de 2 álbumes de diferentes artistas
	*/


	insert into discos.artista (artno, nombre, clasificacion, bio) 
	values
	( 1, 'Artista 1', 10, 'Biografia del artista 1'),
	( 2, 'Artista 2', 20, 'Biografia del artista 2'),
	( 3, 'Artista 3', 30, 'Biografia del artista 3');

	insert into discos.concierto (artno, fecha,ciudad) 
	values
	(1, GETDATE(), 'Ciudad 1'),
	(2, GETDATE(), 'Ciudad 2');


	insert into discos.album (itemno,artno,titulo)
	values
	(1,1,'Album 1 del artista 1'),
	(2,1,'Album 2 del artista 1'),
	(3,2,'Album 1 del artista 2'),
	(4,2,'Album 2 del artista 2');

	insert into discos.stock(itemno,precio,cantidad)
	values(1,200,1000)

	insert into discos.stock(itemno,precio,cantidad)
	values(4,300,1000)


	select * from discos.artista;
	select * from discos.concierto;
	select * from discos.album;
	select * from discos.stock;


