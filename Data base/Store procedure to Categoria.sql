create procedure AgregarCat --agrega datos a nuestra tabla LISTO
(
    @Ncat varchar(100)
) 
AS
begin
    insert into dbo.Categoria(Cat) VALUES (@Ncat)
end
go 

create procedure EliminarCat --elimina alguna categoria de nuestra tabla LISTO
(
    @catI int
)
as 
begin 
    delete from dbo.Categoria where IdCat = @catI
end 
GO

create procedure ActualizarCat --actualiza datos de nuestra tabla LISTO
(
    @Cat varchar(100),
    @Idc int 
)
as 
begin 
    update dbo.Categoria
    set Cat = @Cat
    where IdCat = @Idc
end 
GO

create procedure LeerCat --muestra datos de nuestra tabla LISTO will be update
as 
BEGIN
select c.IdCat, c.Cat from dbo.Categoria as c 
end 
GO

---------------------------------------------------------------------------------------------------------------
create procedure BuscarCat --Este procedimiento busca las categorias de la tabla mediante una busqueda NOT READY
(
    @cat VARCHAR(100)
)
as 
begin 
    SELECT c.IdCat, c.Cat from dbo.Categoria as c
    where Cat like '%'+@cat+'%'
END
GO