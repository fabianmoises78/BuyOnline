IF EXISTS
(
    SELECT type_desc, type 
    FROM sys.procedures
    WHERE NAME = 'LoginU'
    AND TYPE = 'p'
)
DROP PROCEDURE dbo.LoginU 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[LoginU]
(
    @User VARCHAR(100),
    @password VARCHAR(50)
)
AS 
BEGIN   
    IF (EXISTS(SELECT IdCliente, Usuario, IdEstado FROM dbo.Cliente c WHERE Usuario = @User)) AND (EXISTS(SELECT IdCliente, Usuario, IdEstado FROM dbo.Cliente c WHERE Contraseña = @password))
    BEGIN
        SELECT IdCliente, Usuario, IdEstado FROM dbo.Cliente WHERE Usuario = @User AND Contraseña = @password
    END
        ELSE
    BEGIN
        SELECT IdCliente = '0', Usuario = '0', IdEstado = '0' from Cliente WHERE Usuario = @User AND Contraseña = @password
    END
-- SELECT Usuario, IdEstado FROM dbo.Cliente c WHERE Usuario = @User AND Contraseña = @password and IdEstado = 1
END