IF EXISTS --store procedure to record to credit card
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'RecordCard'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.RecordCard 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE RecordCard
(
    @PlaceHolder VARCHAR(100),
    @Number VARCHAR(16),
    @dateexpe DATE,
    @SecPin INT,
    @idest INT,
    @idusuario int
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(50), @msg VARCHAR(50)
    BEGIN TRAN record_card
    BEGIN TRY
        INSERT INTO dbo.Tarjeta(Titular,Numero,Ex,PinS,IdEstado,IdCliente)
        VALUES(@PlaceHolder,@Number,@dateexpe,@SecPin,@idest,@idusuario)

        COMMIT TRAN record_card
        SET @msg = 'Successfully Card record.'
        SET @target = 1
    END TRY
    BEGIN CATCH
        SET @target = 0
        SET @msg = 'A problem has occurred ' + ERROR_MESSAGE()
        ROLLBACK TRAN record_card
    END CATCH
    SELECT @msg
END
GO

IF EXISTS --store procedure to disable to debit card
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'UpdateCard'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.UpdateCard 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE UpdateCard
(
    @idcard INT,
    @idest INT
)
AS 
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(50), @msg VARCHAR(50)
    BEGIN TRAN update_card
    BEGIN TRY
        IF(@idest = 2) --disable card
        BEGIN
            UPDATE dbo.Tarjeta SET
            IdEstado = 2
            WHERE IdTar = @idcard
        END
        ELSE IF(@idest = 3) --ban card
        BEGIN
            UPDATE dbo.Tarjeta SET
            IdEstado = 3
            WHERE IdTar = @idcard
        END
        ELSE IF(@idest = 1) --ban card
        BEGIN
            UPDATE dbo.Tarjeta SET
            IdEstado = 1
            WHERE IdTar = @idcard
        END
    
        COMMIT TRAN update_card
        SET @target = 1
        SET @msg = 'Successfully disable debit card.'
    END TRY
    BEGIN CATCH
        SET @target = 0
        SET @msg = 'A problem has occurred ' + ERROR_MESSAGE()
        ROLLBACK TRAN update_card
    END CATCH
    SELECT @msg
END
GO

IF EXISTS --store procedure to show all credit cards
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'ShowCard'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.ShowCard 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE ShowCard
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(50), @msg VARCHAR(50)
    BEGIN TRAN show_card
    BEGIN TRY
        SELECT t.IdTar,t.Titular,t.Numero,t.Ex,t.PinS,e.Estado
        FROM  dbo.Tarjeta t INNER JOIN dbo.Estado e 
        ON t.IdEstado = e.IdEstado 

        COMMIT TRAN show_card
        SET @msg = 'Successfuhhhhlly card recorded.'
        SET @target = 1
    END TRY 
    BEGIN CATCH
        SET @msg = 'A problem has occurred ' + ERROR_MESSAGE()
        SET @target = 0
        ROLLBACK TRAN show_card
    END CATCH
    SELECT @msg
END
GO

IF EXISTS
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'SearchCard'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.SearchCard 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE SearchCard
(
    @dat VARCHAR(50)
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(50), @msg VARCHAR(50)
    BEGIN TRAN search_card
    BEGIN TRY
        SELECT t.IdTar,t.Titular,t.Numero,t.Ex,t.PinS,e.Estado, c.Usuario
        FROM  dbo.Tarjeta t INNER JOIN dbo.Estado e 
        ON t.IdEstado = e.IdEstado
        INNER JOIN dbo.Cliente c 
        ON c.IdPersona = t.IdCliente
        WHERE t.Numero LIKE '%'+@dat+'%' OR t.Titular LIKE '%'+@dat+'%'

        COMMIT TRAN search_card
        SET @target = 1
        SET @msg = 'Succesfully.'
    END TRY
    BEGIN CATCH
        SET @target = 0
        SET @msg = 'A problem has occurreded ' + ERROR_MESSAGE()
        ROLLBACK TRAN search_card
    END CATCH
    SELECT @msg
END
GO