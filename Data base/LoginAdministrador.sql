IF EXISTS
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'LoginA'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.LoginA
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[LoginA]
(
    @User VARCHAR(100),
    @password VARCHAR(50)
)
AS 
BEGIN   
    IF (EXISTS(SELECT IdAdmin, Usuario, IdEstado FROM dbo.Administrador c WHERE Usuario = @User)) AND (EXISTS(SELECT IdAdmin, Usuario, IdEstado FROM dbo.Administrador c WHERE Contraseña = @password))
    BEGIN
        SELECT IdAdmin, Usuario, IdEstado FROM dbo.Administrador WHERE Usuario = @User AND Contraseña = @password
    END
        ELSE
    BEGIN
        SELECT IdAdmin = '0', Usuario = '0', IdEstado = '0' from Administrador WHERE Usuario = @User AND Contraseña = @password
    END
-- SELECT Usuario, IdEstado FROM dbo.Cliente c WHERE Usuario = @User AND Contraseña = @password and IdEstado = 1
END