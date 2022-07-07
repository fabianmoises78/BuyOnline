IF EXISTS -- Store Procedure to persona and custumer, being 2 tables to registred
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'InsertPersonaXcostumer'
    AND TYPE = 'p' 
)
DROP PROCEDURE dbo.InsertPersonaXcostumer
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO 

CREATE OR ALTER PROCEDURE RecordPersonaXcostumer
(
    @name VARCHAR(100),
    @lastname VARCHAR(100),
    @old INT,
    @phone VARCHAR(12),
    @idcountry INT,
    ------------------------
    @user VARCHAR(100),
    @addres VARCHAR(100),
    @password VARCHAR(100)
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @idfolk INT, @target VARCHAR(50), @msg VARCHAR(100)
    BEGIN TRAN Insert_Folk_Costumer
    BEGIN TRY
        INSERT INTO dbo.Persona(Nombre,Apellido,Edad,Telefono,IdPais,IdEstado)
        VALUES(@name,@lastname,@old,@phone,@idcountry,1)
        SET @idfolk = SCOPE_IDENTITY()

        INSERT INTO dbo.Cliente(Usuario,Correo,Contraseña,IdPersona,IdEstado)
        VALUES(@user,@addres,@password,@idfolk,1)

        COMMIT TRAN Insert_Folk_Costumer
        SET @target = 1
        SET @msg = 'successful registered user'
    END TRY
    BEGIN CATCH
        SET @target = 0
        SET @msg = 'A problem has occurred ' + ERROR_MESSAGE()
        ROLLBACK TRAN Insert_Folk_Costumer
    END CATCH
    SELECT @msg
END
GO

IF EXISTS --Store procedure to update a registred of persona
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'UpdatePersonaXCustumer'
    AND TYPE = 'p'
)
DROP PROCEDURE UpdatePersonaXCustumer
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE UpdatePersonaXCustumer 
(
    @idfolk INT,
    @name VARCHAR(100),
    @lastname VARCHAR(100),
    @old INT,
    @phone VARCHAR(12),
    @idpais INT,
    @idestadoP INT,
    -------------------
    @usuario VARCHAR(100),
    @address VARCHAR(30),
    @password VARCHAR(100),
    @idestadoC INT
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @idfolkU VARCHAR, @msg VARCHAR(50)
    SET @idfolkU = (SELECT IdPersona from Cliente WHERE IdPersona = @idfolk)
    DECLARE @target VARCHAR(50)
    BEGIN TRAN persona_customer
    BEGIN TRY
        UPDATE dbo.Persona SET
        Nombre = @name,
        Apellido = @lastname,
        Edad = @old,
        Telefono = @phone,
        IdPais = @idpais,
        IdEstado = @idestadoP
        WHERE IdPersona = @idfolk

        UPDATE dbo.Cliente SET
        Usuario = @usuario,
        Correo = @address,
        Contraseña = @password,
        IdPersona = @idfolkU,
        IdEstado = @idestadoC
        WHERE IdPersona = @idfolkU

        COMMIT TRAN persona_customer
        SET @target = 1
        SET @msg = 'successful update user.'
    END TRY
    BEGIN CATCH
        SET @target = 0
        SET @msg = 'A problem has occurred ' + ERROR_MESSAGE() 
        ROLLBACK TRAN persona_customer
    END CATCH
    SELECT @msg
END
GO

---ejecutar de nuevo
IF EXISTS --Store procedure that disable or ban someone custumer
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'DisablePersonaXCustumer'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.DisablePersonaXCustumer
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE DisablePersonaXCustumer
(
    @idcustume INT,
    @idestado INT
)
AS 
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(100), @custum INT, @msg VARCHAR(100)
    BEGIN TRAN Disable_folk_custumer
    BEGIN TRY
        IF(@idestado = 2)
        BEGIN
            UPDATE dbo.Cliente SET
            IdEstado = 2
            WHERE IdCliente = @idcustume
        END
        ELSE IF(@idestado = 3)
        BEGIN
            UPDATE dbo.Cliente SET
            IdEstado = 3
            WHERE IdCliente = @idcustume
        END
        ELSE IF(@idestado = 1)
        BEGIN
            UPDATE dbo.Cliente SET
            IdEstado = 1
            WHERE IdCliente = @idcustume
        END
        COMMIT TRAN Disable_folk_custumer
        SET @msg = 'Custumers has been disable.'
        SET @target = 1
    END TRY
    BEGIN CATCH
        SET @msg = 'A problem has occurred ' + ERROR_MESSAGE()
        SET @target = 2
        ROLLBACK TRAN Disable_folk_custumer
    END CATCH
    SELECT @msg
END
GO

IF EXISTS --Store procedure to show all costumers
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'ShowCostumerXPersona'
    AND type = 'p'
)
DROP PROCEDURE dbo.ShowCostumerXPersona
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE ShowCostumerXPersona
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(100), @msg VARCHAR(100)
    BEGIN TRAN show_custum_person
    BEGIN TRY
        SELECT * FROM dbo.Persona p 
        INNER JOIN dbo.Cliente c ON c.IdPersona = p.IdPersona

        COMMIT TRAN show_custum_person
        SET @target = 1
    END TRY
    BEGIN CATCH
        SET @target = 2
        SET @msg = 'A problem has occurred ' + ERROR_MESSAGE()
        ROLLBACK TRAN show_custum_person
    END CATCH
    SELECT @msg
END
GO

IF EXISTS --Store procedure to search any registre with username, name, lastname and addres
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'SearchCustumer'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.SearchCustumer
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE SearchCustumer
(
    @dat VARCHAR(100)
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(50),
    @msg VARCHAR(50)
    BEGIN TRAN search_custumer
    BEGIN TRY
        SELECT * 
        FROM dbo.Persona p INNER JOIN dbo.Cliente c 
        ON p.IdPersona = c.IdPersona
        WHERE p.Nombre LIKE '%'+@dat+'%' OR p.Apellido LIKE '%'+@dat+'%' OR c.Usuario LIKE '%'+@dat+'%' OR c.Correo LIKE '%'+@dat+'%'
        COMMIT TRAN search_custumer
        SET @target = 1
    END TRY
    BEGIN CATCH
        SET @target = 2
        SET @msg = 'A problem has occurred ' + ERROR_MESSAGE()
        ROLLBACK TRAN search_custumer
    END CATCH
    SELECT @msg
END
GO