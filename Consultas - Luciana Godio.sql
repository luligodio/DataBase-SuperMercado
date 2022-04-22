/*Hecho por Luciana Godio*/

/*Consultas de la base de datos: Supermercado_BD*/

go
use [Supermercado_BD]
go

set language spanish
go
/*Vista: Compras en un cierto dia*/
create view ComprasDia as 
	select compras.idCompra,compras.idEmpleado,Compras.idCliente,Compras.idProducto,Compras.FechaCompra
	from Compras
	where day(Compras.FechaCompra)=3	
go
/*Consultas*/

/*Empleado que vendio mas productos en un mes determinado (Marzo)*/
select Empleado.idEmpleado as EmpleadoDelMes, Empleado.nombre, Empleado.apellido
from Compras
inner join Empleado on (Empleado.idEmpleado=Compras.idEmpleado)
where MONTH(Compras.fechaCompra)=3
group by Empleado.idEmpleado, Empleado.nombre,Empleado.apellido
having count(Compras.idCompra)=(
select max(CantPC) as maximCp
from(
	select count(Compras.idCompra) as CantPC
	from Compras
	where month(Compras.fechaCompra)=3
	group by Compras.idEmpleado
	)as x
)

/*Cliente que compro la mayor cantidad de productos en un dia determinado*/
select Cliente.nombre as 'Nombre', Cliente.apellido as 'Apellido', Cliente.socio,count(Cliente.idCliente) as 'Cantidad de Productos Comprados'
from Compras
inner join Cliente on (Cliente.idCliente=Compras.idCliente)
where day(Compras.fechaCompra)=3 
group by  Cliente.idCliente,Cliente.nombre, Cliente.apellido, Cliente.socio
having count( compras.idCompra)=( 
	select max(cantCompras) as cantComprasC
	from(
		select count(Compras.idCompra) as cantCompras
		from Compras
		where day(Compras.fechaCompra)=3
		group by Compras.idCliente
	)as x
)

go

/*Cantidad de socios que compraron productos en el mes de marzo*/
create procedure CantSociosComprasrs as
select count(DISTINCT Compras.idCliente) as CantSocios
from Compras
inner join Cliente on (Cliente.idCliente=Compras.idCliente)
where MONTH(compras.FechaCompra)=3 and Cliente.socio like'S%'
go
 exec CantSociosComprasrs

/*Socio con mas antiguedad*/
select concat(Cliente.Nombre,' ',cliente.Apellido) as Cliente, Cliente.FechaInscripcion as Fecha
from Cliente
where Cliente.FechaInscripcion=(
select distinct min(Cliente.FechaInscripcion) from Cliente)
		
/*El producto mas caro de cada tipo de producto*/
select distinct Producto.idTipoProducto ,Tipo_producto.Nombre ,Producto.Nombre, Producto.Precio 
from Producto
inner join Tipo_producto on (Producto.idTipoProducto=Tipo_producto.idTipoProducto)
where Producto.Precio in 
	(select a.maximo from 
		(select Producto.idTipoProducto, max(precio) as maximo
		 from Producto
		 group by Producto.idTipoProducto
		) as a
	) 
	order by Producto.idTipoProducto

/*Precio promedio de productos vendidos por empleado*/
select compras.idEmpleado,concat(empleado.nombre,' ',empleado.apellido) as Empleado,avg(Producto.precio) as 'Precio promedio de productos vendidos'
from Compras
inner join Producto on (Compras.idproducto=Producto.idproducto)
inner join Empleado on (Compras.idEmpleado=Empleado.idEmpleado)
group by Compras.idEmpleado, concat(empleado.nombre,' ',empleado.apellido)
	
/*Empleado o empleados que vendio del producto mas caro*/
select compras.idEmpleado,concat(empleado.nombre,' ',empleado.apellido)as 'Empleado',concat(Cliente.nombre,' ',Cliente.apellido) as 'Cliente',producto.Nombre as 'Producto',Producto.idProducto, max(Producto.precio) as Precio
from Compras
inner join Producto on (Compras.idproducto=Producto.idproducto)
inner join Empleado on (Compras.idEmpleado=Empleado.idEmpleado)
inner join Cliente on (Compras.idCliente=Cliente.idCliente)
where Producto.Precio=(
	select max(Precio) 
	from Producto 
	)
group by Compras.idEmpleado,concat(empleado.nombre,' ',empleado.apellido),concat(Cliente.nombre,' ',Cliente.apellido),producto.Nombre,Producto.idProducto

/*Ganancia obtenida por un cierto empleado*/
select concat(empleado.Nombre,' ',Empleado.Apellido) as Empleado, sum(producto.Precio) as 'Ganancia'
from Empleado
inner join Compras on (Empleado.idEmpleado=Compras.idEmpleado)
inner join Producto on (Compras.idProducto=Producto.idProducto)
where Compras.idEmpleado=1
group by concat(empleado.Nombre,' ',Empleado.Apellido)


/*Fecha exacta del dia o dias con menos compras*/
select DATENAME(dw,Compras.FechaCompra) as 'Dia de la semana',DAY(compras.FechaCompra) as 'Numero de dia',DATENAME(MM,compras.FechaCompra) as 'Mes', count(compras.idCompra) as 'Cantidad de Compras'
from Compras
group by DATENAME(dw,Compras.FechaCompra),DAY(compras.FechaCompra),DATENAME(MM,compras.FechaCompra)
having count(compras.idCompra)=(
	select min(cantC)
	from (
		select count(Compras.idCompra) as cantC
		from Compras
		group by  DATENAME(dw,Compras.FechaCompra)
		)as x
	)

/*Eliminar un socio de clientes*/
delete from Cliente
where Cliente.idCliente=13

/*Actualizar la fecha de inscripcion de un cliente*/
update Cliente
set Socio='Si', fechaInscripcion='2021-03-10'
where cliente.idcliente=4

/*Primeros 3 socios que ingresaron en el 2021*/
select top 3*
from Cliente
where cliente.Socio='Si' and year(Cliente.FechaInscripcion)='2021'
order by Cliente.FechaInscripcion

/*Tipos de productos cuyo precio de alguno de sus productos sea mayores a 150 pesos y menores a 250 pesos*/
select Tipo_producto.Nombre
from Tipo_producto
where exists (
	select Producto.Nombre
	from Producto
	where Producto.idTipoProducto=Tipo_producto.idTipoProducto //and Producto.Precio between 150 and 250
	)

/*Tipo o tipos de producto mas vendido y su cantidad*/
select Tipo_producto.idTipoProducto,Tipo_producto.Nombre as 'Nombre del tipo de producto', count(producto.idproducto) as Cantidad
from Tipo_producto
inner join Producto on (Producto.idTipoProducto=Tipo_producto.idTipoProducto)
inner join Compras on (compras.idProducto=Producto.idProducto)
group by Tipo_producto.idTipoProducto, Tipo_producto.Nombre
having count(producto.idproducto)=(
	select max(PmasVend) from
		(select count(Producto.idTipoProducto) as pmasVend
			from Compras
			inner join Producto on (Producto.idProducto=Compras.idProducto)
			inner join Tipo_producto on(Tipo_producto.idTipoProducto=Producto.idTipoProducto)
			group by Tipo_producto.idTipoProducto
		)as x
)


