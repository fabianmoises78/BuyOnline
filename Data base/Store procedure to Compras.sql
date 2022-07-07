IF EXISTS 
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'RecordCompra'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.RecordCompra
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE RecordCompra
(
    @datebuy DATE,
    @idpaytype INT,
    @IVA  FLOAT,
    @total FLOAT, --tener en cuenta que este total es el total de cantidad x precio + IVA
    @idcostume INT
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(10),@msg VARCHAR (50)
    BEGIN TRAN record_tran
    BEGIN TRY
        INSERT INTO dbo.Compra(FechaCompra,IdTipoP,IVA,Total,IdCliente,IdEstado)
        VALUES(@datebuy,@idpaytype,@IVA,0,@idcostume,1)

        COMMIT TRAN record_tran
        SET @target = 1
        SET @msg = 'Succesfully.'
    END TRY
    BEGIN CATCH
        SET @target = 0
        SET @msg = 'error' + ERROR_MESSAGE()
        ROLLBACK TRAN record_tran
    END CATCH
    SELECT @msg
END
GO

IF EXISTS
(
    SELECT type_desc, TYPE
    FROM sys.procedures
    WHERE NAME = 'ShowCompras'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.ShowCompras
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE ShowCompras
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(50), @msg VARCHAR(50)
    BEGIN TRAN show_compras
    BEGIN TRY
        SELECT * FROM dbo.Compra

        COMMIT TRAN show_compras
        SET @target = 1
        SET @msg = 'Succesfully.'
    END TRY
    BEGIN CATCH
        SET @target = 0
        SET @msg = 'Error ' + ERROR_MESSAGE()
        ROLLBACK TRAN show_compras
    END CATCH
    SELECT @msg
END
GO

IF EXISTS 
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'UpdateCompras'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.UpdateCompras
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE UpdateCompras
(
    @idbuy INT,
    @datebuy DATE,
    @idpaytype INT,
    @total FLOAT,
    @idcustumer INT,
    @idestado INT
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(10), @msg VARCHAR (50)
    BEGIN TRAN update_compras
    BEGIN TRY
        UPDATE dbo.Compra SET
        FechaCompra = @datebuy,
        IdTipoP = @idpaytype,
        Total = @total,
        IdCliente = @idcustumer,
        IdEstado = @idestado
        WHERE IdCompra = @idbuy

        COMMIT TRAN update_compras
        SET @target = 1
        SET @msg = 'Succesfully.'
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN update_compras
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
    WHERE NAME = 'ChanceStatusCompras'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.ChanceStatusCompras
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE ChanceStatusCompras
(
    @idstatus INT,
    @idbuy INT
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(10), @msg VARCHAR(50)
    BEGIN TRAN status_compras
    BEGIN TRY
        IF(@idstatus = 1)
        BEGIN
            UPDATE dbo.Compra SET
            IdEstado = 1
            WHERE IdCompra = @idbuy
        END
        ELSE IF(@idstatus = 2)
        BEGIN
            UPDATE dbo.Compra SET
            IdEstado = 2
            WHERE IdCompra = @idbuy
        END
        ELSE IF(@idstatus = 4)
        BEGIN
            UPDATE dbo.Compra SET
            IdEstado = 4
            WHERE IdCompra = @idbuy
        END
        ELSE IF(@idstatus = 5)
        BEGIN
            UPDATE dbo.Compra SET
            IdEstado = 5
            WHERE IdCompra = @idbuy
        END

        COMMIT TRAN status_compras
        SET @target = 1
        SET @msg = 'succesfully.'
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN status_compras
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
    WHERE NAME = 'SearchCompras'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.SearchCompras
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE SearchCompras
(
    @data VARCHAR(100)
)
AS 
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(10), @msg VARCHAR(10)
    BEGIN TRAN search_compras
    BEGIN TRY
        SELECT * FROM dbo.Compra c INNER JOIN dbo.Cliente t
        ON c.IdCliente = t.IdCliente 
        WHERE c.FechaCompra LIKE '%'+@data+'%' OR c.Total LIKE '%'+@data+'%' OR t.Usuario LIKE '%'+@data+'%'

        COMMIT TRAN show_compra
        SET @target = 1
        SET @msg = 'Succesfully.'
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN show_compra
        SET @target = 0
        SET @msg = 'Error ' + ERROR_MESSAGE()
    END CATCH
    SELECT @msg
END
GO
