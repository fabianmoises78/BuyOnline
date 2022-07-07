create procedure InsertarPais --Inserta nuevos registros para la tabla de pais NOT REAADY
(
    @pais VARCHAR(100)
)
as 
begin 
    insert into dbo.Pais(Nombre)
    values(@pais)
end 
GO

create procedure ActualizarPais --Actualiza un registro de la tabla pais con la condicional del ID NOT READY
(
    @paisp VARCHAR(100),
    @id int 
)
as 
begin 
    update dbo.Pais 
    set Nombre = @paisp
    where IdPais = @id
end 
GO

create procedure EliminarPais --Elimina un registro de la tabla pais con la condicional del ID NOT READY
(
    @IdP int
)
as 
begin 
    delete from dbo.Pais
    where IdPais = @IdP
end 
go

create procedure ListarPais --Lista todos los datos de la tabla paises NOT READY
as 
begin 
    select p.IdPais, p.Nombre from dbo.Pais as p
end 
GO

---------------------------------------------------------------------------------------------
create procedure BuscarPais --Busqueda de paises mediante variable y sin variable NOT READY
(
    @Nom varchar(10)
)
as 
begin 
    select p.IdPais, p.Nombre from dbo.Pais as p
    where Nombre like '%' + @Nom + '%'
end 
GO