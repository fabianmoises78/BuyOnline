alter procedure InsertarPais --Inserta nuevos registros para la tabla de pais NOT REAADY
(
    @pais VARCHAR(100)
)
as 
begin 
    insert into dbo.Pais(NombrePais)
    values(@pais)
end 
GO

alter procedure ActualizarPais --Actualiza un registro de la tabla pais con la condicional del ID NOT READY
(
    @paisp VARCHAR(100),
    @id int 
)
as 
begin 
    update dbo.Pais 
    set NombrePais = @paisp
    where IdPais = @id
end 
GO

alter procedure EliminarPais --Elimina un registro de la tabla pais con la condicional del ID NOT READY
(
    @IdP int
)
as 
begin 
    delete from dbo.Pais
    where IdPais = @IdP
end 
go

alter procedure ListarPais --Lista todos los datos de la tabla paises NOT READY
as 
begin 
    select p.IdPais, p.NombrePais from dbo.Pais as p
end 
GO

---------------------------------------------------------------------------------------------
alter procedure BuscarPais --Busqueda de paises mediante variable y sin variable NOT READY
(
    @Nom varchar(10)
)
as 
begin 
    select p.IdPais, p.NombrePais from dbo.Pais as p
    where NombrePais like '%' + @Nom + '%'
end 
GO

create procedure ListarPaisbyid
(
    @id int
) --Lista todos los datos de la tabla paises NOT READY
as 
begin 
    select p.IdPais, p.NombrePais from dbo.Pais as p WHERE p.IdPais = @id
end 
GO