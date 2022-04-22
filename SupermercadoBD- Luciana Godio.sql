/*Hecho por Luciana Godio*/
CREATE DATABASE Supermercado_BD
go
use [Supermercado_BD]
go
/*tabla de productos*/
create table Tipo_producto(
	idTipoProducto int PRIMARY KEY identity (1,1) not null,
	nombre varchar(50));

CREATE TABLE Producto(
	idProducto int PRIMARY KEY identity (1,1) not null,
	idTipoProducto int REFERENCES Tipo_producto(idTipoProducto) ON DELETE CASCADE,
	nombre varchar(50),
	precio float);

CREATE TABLE Empleado(
	idEmpleado int PRIMARY KEY identity (1,1) not null,
	nombre varchar(50),
	apellido varchar(50));

CREATE TABLE Cliente(
	idCliente int PRIMARY KEY identity (1,1) not null,
	nombre varchar(50),
	apellido varchar(50),
	socio varchar(2),
	fechaInscripcion date );

CREATE TABLE Compras(
	idCompra int PRIMARY KEY identity (1,1) not null,
	idCliente int REFERENCES Cliente(idCliente)ON DELETE CASCADE,
	idProducto int REFERENCES Producto(idProducto)ON DELETE CASCADE,
	idEmpleado int REFERENCES Empleado(idEmpleado)ON DELETE CASCADE,
	fechaCompra date);

/*Inserts*/
insert into Tipo_Producto(nombre) values
('Shampoo'),
('Arroz'),
('Atun'),
('Mermelada'),
('Galletitas'),
('Dulce de leche'),
('Cafe'),
('Cereales'),
('Gaseosas'),
('Yogures');

insert into Producto(idTipoProducto,nombre,precio) values
(1,'Sedal Crema Balance',249.00),
(1,'Elvive Color Vive',320.10),
(1,'Pantene Pro-V',303.50),
(2,'Gallo Oro',117.80),
(2,'Gallo Integral',176.20),
(3,'Campagnola al natural',211.12),
(3,'Vea al natural',118.45),
(4,'Arcor Damasco',109.20),
(4,'Campagnola Durazno',130.00),
(5,'Pepitas Gold 500gr',140.33),
(5,'Chocolinas 250gr',97.48),
(5,'Gold Mundo Rosquitas',182.60),
(6,'Sancor Tradicional 400gr',109.10),
(7,'La Virginia x 20 saquitos',255.10),
(7,'La Virginia Cappuccino Tradicional',122.10),
(8,'Trix 480gr',370.64),
(9,'Coca Cola 2.25L',173.61),
(10,'Yogurisimo Firme Vainilla 190gr',78.54);

insert into Empleado(nombre,apellido)values
('Matias','Schulz'),
('Juan','Bar'),
('Diego','Simonet'),
('Ignacio','Pizarro'),
('Santiago','Baronetto'),
('Pablo','Vainstein'),
('Guillermo','Fischer'),
('Nicolas','Bonanno'),
('Lucas','Moscariello'),
('Gonzalo','Carou'),
('Gaston','Mouriño');

insert into Cliente(nombre,apellido,socio,fechaInscripcion) values ('Sergio','Ramos','Si','2020-02-02');
insert into Cliente(nombre,apellido,socio,fechaInscripcion) values ('Karim','Benzema','Si','2020-10-05');
insert into Cliente(nombre,apellido,socio) values ('Eden','Hazard','No');
insert into Cliente(nombre,apellido,socio) values ('Marcelo','Vieira','No');
insert into Cliente(nombre,apellido,socio,fechaInscripcion) values ('Luka','Mondric','Si','2020-08-31');
insert into Cliente(nombre,apellido,socio,fechaInscripcion) values ('Marvin','Park','Si','2021-01-02');
insert into Cliente(nombre,apellido,socio) values ('Marco','Asensio','No');
insert into Cliente(nombre,apellido,socio,fechaInscripcion) values ('Federico','Valverde','Si','2019-02-19');
insert into Cliente(nombre,apellido,socio) values ('Lucas','Vazquez','No');
insert into Cliente(nombre,apellido,socio,fechaInscripcion) values ('Victor','Chust','Si','2020-06-15');
insert into Cliente(nombre,apellido,socio,fechaInscripcion) values ('Gerard','Pique','Si','2020-03-04');

insert into Compras(idCliente,idProducto,idEmpleado,fechaCompra)values
(11,15,3,'2021-02-28'),
(1,1,1,'2021-03-03'),
(1,5,1,'2021-03-03'),
(1,7,1,'2021-03-03'),
(1,10,1,'2021-03-03'),
(5,4,1,'2021-03-03'),
(5,6,1,'2021-03-03'),
(5,18,1,'2021-03-03'),
(3,6,6,'2021-03-04'),
(3,7,6,'2021-03-04'),
(3,9,6,'2021-03-04'),
(6,2,4,'2021-03-06'),
(6,3,4,'2021-03-06'),
(9,7,3,'2021-03-08'),
(1,17,6,'2021-03-09'),
(1,16,6,'2021-03-09'),
(1,18,6,'2021-03-09');