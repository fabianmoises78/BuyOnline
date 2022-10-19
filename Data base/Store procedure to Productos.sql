IF EXISTS
(
    SELECT type_desc, type 
    from sys.procedures
    WHERE NAME = 'RecordProductos'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.RecordProductos
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create OR ALTER procedure RecordProductos --procedure to insert Productos on the table NOT READY
(
    @name varchar(100),
    @descript VARCHAR(500),
    @image VARCHAR(500),
    @price FLOAT,
    @existence int,
    @rate int,
    @Idcat int,
    @detalles VARCHAR(150)
)
as 
begin 
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(50), @msg VARCHAR(100)
    BEGIN TRAN Ip 
    begin TRY
        insert into Producto(Nombre,Descripcion,Imagen,precio,Exis,Valoracion,IdEstado,IdCat, Detalles)
        VALUES(@name,@descript,@image,@price,@existence,@rate,1,@Idcat, @detalles)
        set @msg = 'El producto se inserto correctamente'
        COMMIT TRAN Ip 
        SET @target = 1
    END TRY
    BEGIN CATCH
        SET @target = 2
        SET @msg = 'No se pudo registrar el producto' + ERROR_MESSAGE() + ' en la linea ' + CONVERT(nvarchar(255), ERROR_LINE()) + '.'
        ROLLBACK TRAN Ip 
    END CATCH
    SELECT @msg
END
GO


IF EXISTS
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'UpdateProducto'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.UpdateProducto
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE UpdateProducto --the store procedure update any register by the table NOT READY
(
    @IdP int, 
    @name varchar(100),
    @descript VARCHAR(500),
    @img VARCHAR(500),
    @price FLOAT,
    @existence int,
    @idcat INT,
    @detalles VARCHAR(150)
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(50), @msg VARCHAR(100)
    BEGIN TRAN UP 
    BEGIN TRY
        UPDATE dbo.Producto SET
        Nombre = @name,
        Descripcion = @descript,
        Imagen = @img,
        precio = @price,
        Exis = @existence,
        IdCat = @idcat,
        Detalles = @detalles
        WHERE IdProducto = @IdP
            
        SET @msg = 'The product has been updated succefuly.'
        COMMIT TRAN UP 
        SET @target = 1
    END TRY
    BEGIN CATCH
        SET @target = 2
        SET @msg = 'Could not update this product' + ERROR_MESSAGE()  + 'on the line ' + CONVERT(nvarchar(255),ERROR_LINE()) + '.'
        ROLLBACK TRAN UP 
    END CATCH
    SELECT @msg
END
GO


IF EXISTS
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'DIsableProducto'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.DIsableProducto
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE DIsableProducto
(
    @IdP INT,
    @idestado INT
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(50), @msg VARCHAR(100)
    BEGIN TRAN DP 
    BEGIN TRY
        IF(@idestado = 2)
        BEGIN
            UPDATE Producto
            set IdEstado = 1
            WHERE IdProducto = @IdP
        END
        ELSE IF(@idestado = 1)
        BEGIN
            UPDATE Producto
            SET IdEstado = 2
            WHERE IdProducto = @IdP
        END
    END TRY
    BEGIN CATCH
        SET @target = 2
        SET @msg = 'Could not deleted this ttarget'
        ROLLBACK TRAN DP 
    END CATCH
    SELECT @msg
END
GO

IF EXISTS
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'ShowProducts'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.ShowProducts
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE ShowProducts --this procedure show all the date of this table
AS
BEGIN
    SET NOCOUNT ON; 
    DECLARE @target VARCHAR(50), @msg VARCHAR(100)
    BEGIN TRAN SP 
    BEGIN TRY
        SELECT p.IdProducto,p.Nombre,p.Descripcion,p.Imagen,p.precio,p.Exis,p.Valoracion,e.Estado,p.IdEstado,c.Cat,p.IdCat, p.Detalles
        FROM dbo.Producto AS p INNER JOIN dbo.Estado as e ON p.IdEstado = e.IdEstado 
        INNER JOIN dbo.Categoria AS c ON p.IdCat = c.IdCat WHERE p.IdEstado = 1
        COMMIT TRAN SP 
        SET @target = 1
    END TRY
    BEGIN CATCH 
        SET @target = 2
        SET @msg = 'A problem has occurred.'
        ROLLBACK TRAN SP 
    END CATCH
    SELECT @msg
END
GO


IF EXISTS 
(
    SELECT type_desc, type
    FROM sys.procedures
    WHERE NAME = 'SearchProducts'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.SearchProducts
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE or ALTER PROCEDURE SearchProducts --this procedure make a search from 3 tables to show data
(
    @data VARCHAR(500)
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(50),  @msg VARCHAR(100)
    BEGIN TRAN search_pro 
    BEGIN TRY 
        SELECT p.IdProducto,p.Nombre,p.Descripcion,p.Imagen,p.precio,p.Exis,p.Valoracion,e.Estado,p.IdEstado,c.Cat,p.IdCat, p.Detalles
        FROM dbo.Producto AS p INNER JOIN dbo.Estado as e ON p.IdEstado = e.IdEstado 
        INNER JOIN dbo.Categoria AS c ON p.IdCat = c.IdCat
        WHERE (p.Nombre LIKE '%'+@data+'%' OR c.Cat LIKE '%'+@data+'%') AND p.IdEstado = 1
        COMMIT TRAN search_pro
        SET @target = 1
    END TRY
    BEGIN CATCH
        SET @target = 2
        SET @msg = 'A problem has occurred.'
        ROLLBACK TRAN search_pro
    END CATCH
    SELECT @msg
END
GO 

GO
IF EXISTS
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'ShowProductsbyID'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.ShowProductsbyID
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE ShowProductsbyID
(
    @idproducto INT
) --this procedure show all the date of this table
AS
BEGIN
    DECLARE @msg VARCHAR(100)
        SELECT p.IdProducto,p.Nombre,p.Descripcion,p.Imagen,p.precio,p.Exis,p.Valoracion,e.Estado, e.IdEstado,c.Cat, c.IdCat, p.Detalles
        FROM dbo.Producto AS p INNER JOIN dbo.Estado as e ON p.IdEstado = e.IdEstado 
        INNER JOIN dbo.Categoria AS c ON p.IdCat = c.IdCat WHERE p.IdProducto = @idproducto and e.IdEstado = 1
    SELECT @msg
END
GO