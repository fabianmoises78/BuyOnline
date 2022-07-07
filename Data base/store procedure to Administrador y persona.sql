IF EXISTS --store procedure to record folk and administrator
(
    SELECT type_Desc, type 
    FROM sys.procedures
    WHERE NAME = 'RecordAdminXFolk'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.RecordAdminXFolk 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE RecordAdminXFolk
(
    @name VARCHAR(100),
    @lastname VARCHAR(100),
    @old INT,
    @phone VARCHAR(12),
    @idcountry INT,
    ------------------------
    @user VARCHAR(100),
    @password VARCHAR(100)
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @idfolk INT, @target VARCHAR(50),@msg VARCHAR(50)
    BEGIN TRAN admin_folk_record
    BEGIN TRY
        INSERT INTO dbo.Persona(Nombre,Apellido,Edad,Telefono,IdPais,IdEstado)
        VALUES (@name,@lastname,@old,@phone,@idcountry,1)
        SET @idfolk = SCOPE_IDENTITY()

        INSERT INTO dbo.Administrador(Usuario,Contraseña,IdPersona, IdEstado)
        VALUES(@user,@password,@idfolk,1)

        COMMIT TRAN RecordAdminXFolk
        SET @target = 1
        SET @msg = 'Successful registered user'
    END TRY
    BEGIN CATCH
        SET @target = 0
        SET @msg = 'A problem has occurred ' + ERROR_MESSAGE()
        ROLLBACK TRAN RecordAdminXFolk
    END CATCH
    SELECT @msg
END
GO

IF EXISTS --store procedure to do update to folk
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'UpdatePersonaXAdmin'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.UpdatePersonaXAdmin 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE UpdatePersonaXAdmin
(
    @idfolk INT,
    @name VARCHAR(100),
    @lastname VARCHAR(100),
    @old INT,
    @phone VARCHAR(12),
    @idpais INT,
    @idestadoP INT,
    ----------------------
    @user VARCHAR(100),
    @password VARCHAR(50),
    @idestadoA INT
)
AS 
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(50), @idfolkU VARCHAR(20),@msg VARCHAR(50)
    SET @idfolkU = (SELECT IdPersona FROM dbo.Administrador
    WHERE IdPersona = @idfolk)
    BEGIN TRAN update_persona_admin
    BEGIN TRY
        UPDATE dbo.Persona SET 
        Nombre = @name,
        Apellido = @lastname,
        Edad = @old,
        Telefono = @phone,
        IdEstado = @idestadoP
        WHERE IdPersona = @idfolk

        UPDATE dbo.Administrador SET
        Usuario = @user,
        Contraseña = @password,
        IdPersona = @idfolkU,
        IdEstado = @idestadoA
        WHERE IdPersona = @idfolkU

        COMMIT TRAN persona_customer
        SET @target = 1
        SET @msg = 'successful update user.'
    END TRY 
    BEGIN CATCH
        SET @target = 0
        SET @msg = 'A problem has occurred ' + ERROR_MESSAGE() 
        ROLLBACK TRAN update_persona_admin
    END CATCH
    SELECT @msg
END
GO

IF EXISTS --store procedure to disable any administrator
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'DisableAdmin'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.DisableAdmin
GO 

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE DisableAdmin
(
    @idadmin INT,
    @idesta INT
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(50), @msg VARCHAR(50)
    BEGIN TRAN Disable_admin
    BEGIN TRY
        IF(@idesta = 2)
        BEGIN
            UPDATE dbo.Administrador SET
            IdEstado = 2
            WHERE IdAdmin = @idadmin
        END
        ELSE IF(@idesta = 3)
        BEGIN
            UPDATE dbo.Administrador SET
            IdEstado = 3
            WHERE IdAdmin = @idadmin
        END
        ELSE IF(@idesta = 1)
        BEGIN
            UPDATE dbo.Administrador SET
            IdEstado = 1
            WHERE IdAdmin = @idadmin
        END

        COMMIT TRAN Disable_admin
        SET @target = 1
        SET @msg = 'successfull admin disable.'
    END TRY
    BEGIN CATCH
        SET @target = 0
        SET @msg = 'A problem has occurred ' + ERROR_MESSAGE()
        ROLLBACK TRAN Disable_admin
    END CATCH
    SELECT @msg
END
GO

IF EXISTS --store procedure to search any target 
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'SearchAdmin'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.SearchAdmin 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE SearchAdmin
(
    @dat VARCHAR(100)
)
AS 
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(50), @msg VARCHAR(100)
    BEGIN TRAN search_admin
    BEGIN TRY
        SELECT * 
        FROM dbo.Administrador a INNER JOIN dbo.Persona p 
        ON a.IdPersona = p.IdPersona
        WHERE a.Usuario LIKE '%'+@dat+'%' OR p.Nombre LIKE '%'+@dat+'%' OR p.Apellido LIKE '%'+@dat+'%'

        COMMIT TRAN search_admin
        SET @target = 0
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN search_admin
        SET @target = 1
        SET @msg = 'A problem has occurred ' + ERROR_MESSAGE()
    END CATCH
    SELECT @msg
END
GO

IF EXISTS -- store procedure to show all targets
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'ShowadminXfolk'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.ShowadminXfolk 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE ShowadminXfolk
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @target VARCHAR(100), @msg VARCHAR(100)
    BEGIN TRAN show_admin_folk
    BEGIN TRY
        SELECT * FROM dbo.Persona p 
        INNER JOIN dbo.Administrador a 
        ON p.IdPersona = a.IdPersona

        COMMIT TRAN show_admin_folk
        SET @target = 1
    END TRY
    BEGIN CATCH
        SET @target = 0
        SET @msg = 'A problem has occurred ' + ERROR_MESSAGE()
        ROLLBACK TRAN show_admin_folk
    END CATCH
    SELECT @msg
END
GO