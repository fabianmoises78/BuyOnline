create procedure InsertarEstado --ingresa datos a la tabla de estados NOT READY
(
    @estado varchar(25)
)
as 
begin 
    insert into Estado(Estado)
    values (@estado)
END
go 

create procedure ActualizarEstado --Actualiza los estados de la tabla NOT READY
(
    @estado VARCHAR(25),
    @Id int 
)
as 
begin 
    update dbo.Estado
    set Estado = @estado
    where IdEstado = @Id
end 
GO

create procedure EliminarEstado --Elimina un estado de la tabla de estados NOT READY
(
    @EstadoId INT
)
as 
begin 
    delete from dbo.Estado
    where IdEstado = @EstadoId
end 
GO

create procedure VeerEstados --Visualiza la lista de la tabla estado NOT READY
as 
BEGIN
    select e.IdEstado, e.Estado from dbo.Estado as e
end 
GO
----------------------------------------------------------------------------------------------------
create procedure BuscarEstado --procedimiento almacenado que busca los estados por variable NOT READY
(
    @estadob VARCHAR(100)
)
as 
begin
    select e.IdEstado, e.Estado from dbo.Estado as e 
    where Estado like '%'+@estadob+'%'
END
GO 
