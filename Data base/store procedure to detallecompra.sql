IF EXISTS
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME  = 'RecordDetalleCompra'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.RecordDetalleCompra
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE RecordDetalleCompra
(
    @idcompra INT,
    @idproduct INT,
    @precio FLOAT,
    @discount FLOAT,
    @cantidad INT
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(10), @subtotalT FLOAT, @idcompraT INT, @msg VARCHAR(20)
    SET @idcompraT = (select top 1 IdCompra from dbo.Compra where IdCliente in (select IdCliente from dbo.Compra where IdCompra = @idcompra))
    SET @subtotalT = @cantidad * (1 - @discount) * @precio * (1 + 0.13)
    BEGIN TRAN record_detalle_compra
    BEGIN TRY

        INSERT INTO dbo.DetalleCompra(IdCompra,IdProducto,Precio,Descuento,SubTotal,Cantidad)
        VALUES(@idcompra,@idproduct,@precio,@discount,@subtotalT,@cantidad)

        UPDATE dbo.Compra SET
        Total = @subtotalT
        WHERE IdCompra = @idcompra

        COMMIT TRAN record_detalle_compra
        SET @target = 1
        SET @msg = 'Succesfully.'
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN record_detalle_compra
        SET @target = 0
        SET @msg = 'Error ' + ERROR_MESSAGE()
    END CATCH
    SELECT @msg
END
GO

IF EXISTS
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'UpdateDetalleCompra'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.UpdateDetalleCompra
GO

SET ANSI_NULLS ON
GO
set QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE UpdateDetalleCompra
(
    @idcompra INT,
    @idproducto INT,
    @precio FLOAT,
    @descuento FLOAT,
    @cantidad INT
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(20), @subtotalU FLOAT, @msg VARCHAR(20)
    SET @subtotalU = @cantidad * (1 - @descuento) * @precio * (1 + 0.13)
    BEGIN TRAN update_detalle_compra
    BEGIN TRY
        UPDATE DetalleCompra SET
        IdCompra = @idcompra,
        IdProducto = @idproducto,
        Precio = @precio,
        Descuento = @descuento,
        SubTotal = @subtotalU,
        Cantidad = @cantidad
        WHERE IdCompra = @idcompra

        UPDATE Compra SET
        Total = @subtotalU
        WHERE IdCompra = @idcompra

        COMMIT TRAN update_detalle_compra
        SET @msg = 'Sucessfully.'
        SET @target = 1
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN update_detalle_compra
        SET @msg = 'Error ' + ERROR_MESSAGE()
        SET @target = 0
    END CATCH
    SELECT @msg
END
GO

IF EXISTS 
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'SearchDetalleCompra'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.SearchDetalleCompra
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE SearchDetalleCompra
(
    @data VARCHAR(50)
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(10), @msg VARCHAR(10)
    BEGIN TRAN search_detalle_compra
    BEGIN TRY
        SELECT * FROM dbo.DetalleCompra
        WHERE IdCompra LIKE '%'+@data+'%' OR IdProducto LIKE '%'+@data+'%' OR SubTotal LIKE '%'+@data+'%'

        COMMIT TRAN SearchDetalleCompra
        SET @msg = 'Succesfully.'
        SET @target = 1
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN SearchDetalleCompra
        SET @msg = 'Error ' + ERROR_MESSAGE()
        SET @target = 0
    END CATCH
    SELECT @msg
END
go
