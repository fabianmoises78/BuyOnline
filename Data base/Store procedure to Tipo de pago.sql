create procedure InsertarTPago --Procedimiento almacenado de insertar Tipos de pagos NOT READY
(
    @tipo VARCHAR(20)
)
as 
begin 
    insert into dbo.TipoPago(TipoPago)
    values(@tipo)
end 
GO

create procedure ActualizarTPago --Procedure to update the table of Tipo de pago NOT READY 
(
    @IdT int,
    @pago varchar(20)
)
as 
BEGIN
    update dbo.TipoPago
    set TipoPago = @pago
    where IdTipoP = @IdT
end 
go 

create procedure EliminarTPago --procedure to delete the table a table´s register NOT READY
(
    @IdT int
) 
as 
BEGIN
    delete from dbo.TipoPago
    where IdTipoP = @IdT
END
GO

create procedure ListarTPago --Procedure to list to all table´s register NOT READY
as 
begin 
    select t.IdTipoP, t.TipoPago from dbo.TipoPago as t
end 
GO

---------------------------------------------------------------------------------------------------
create procedure BuscarTPago --Procedure to search many register or only one by parameter NOT READY
(
    @busque varchar(25)
)
as 
begin 
    select t.IdTipoP, t.TipoPago from dbo.TipoPago as t
    where t.TipoPago like '%'+@busque+'%'
END
go