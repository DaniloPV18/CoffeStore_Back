CREATE TABLE RolUsuario
(
	Codigo varchar(20) primary key,
	Descripcion varchar(255)
);

CREATE TABLE Usuario
(
	Id int identity(1,1) primary key,
	Cedula varchar(255),
	Nombres varchar(255),
	Apellidos varchar(255),
	FechaNacimiento date,
	Email varchar(50) unique,
	Contrasena varchar(255),
	Rol varchar(20),
	Estado varchar(50),
	CreatedAt datetime,
	UpdateAt datetime,
	FOREIGN KEY (Rol) REFERENCES RolUsuario(Codigo),
);

CREATE TABLE FormaPago
(
	Codigo varchar(20) primary key,
	Metodo varchar(50)
);

CREATE TABLE FormaPago_Usuario
(
	Id int identity(1,1) primary key,
	Usuario int,
	FormaPago varchar(20),

	Cuenta varchar(50),
	CreatedAt datetime,
	--
	FOREIGN KEY (FormaPago) REFERENCES FormaPago(Codigo),
	FOREIGN KEY (Usuario)	REFERENCES Usuario(Id)
);

-- MEL

CREATE TABLE CategoriaProducto
(
	Codigo varchar(20) primary key,
	Descripcion varchar(255)
);

CREATE TABLE Producto
(
	Id int identity(1,1) primary key,
	Nombre varchar(255),
	Descripcion varchar (255),
	ImagenUrl varchar (255),
	Precio float,
	Categoria varchar(20),
	Estado varchar(255),
	CreatedAt datetime,
	UpdatedAt datetime,

	FOREIGN KEY (Categoria) REFERENCES CategoriaProducto(Codigo),
);

CREATE TABLE CompraUnidad
(
	Id int identity(1,1) primary key,
	Producto int,
	Cantidad int,

	FOREIGN KEY (Producto) REFERENCES Producto (Id)
);

CREATE TABLE CompraConjunto
(
	Id int identity(1,1) primary key,
	CompraUnidad int,
	FormaPago_Usuario int,

	FOREIGN KEY (FormaPago_Usuario) REFERENCES FormaPago_Usuario (Id),
	FOREIGN KEY (CompraUnidad) REFERENCES CompraUnidad (Id)
);