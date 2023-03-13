-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE SetCompraUnidad
	-- Add the parameters for the stored procedure here
	@iTransaccion	AS VARCHAR(50),
	@iXML			AS XML = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @Id					AS INT

	DECLARE @Id_usuario			AS INT
	DECLARE @cedula_usuario		AS VARCHAR(255)

	DECLARE @codigo_forma_pago	AS VARCHAR(255)
	DECLARE @nombre_forma_pago	AS VARCHAR(255)

	DECLARE @Id_producto		AS INT
	DECLARE @codigo_producto	AS VARCHAR(255)

	DECLARE @cantidad			AS INT

	DECLARE @respuesta AS VARCHAR(50)
	DECLARE @leyenda AS VARCHAR(50)

BEGIN TRY
		BEGIN TRANSACTION TRX
			IF(@iTransaccion = 'INSERT')
				BEGIN

					SELECT 
							@cedula_usuario =		LTRIM(RTRIM(DATO_XML.X.value('UsuarioCedula[1]','VARCHAR(255)'))),
							@nombre_forma_pago =	LTRIM(RTRIM(DATO_XML.X.value('FormaPagoNombre[1]','VARCHAR(255)'))),	
							@Id_producto	=		CONVERT(INT, DATO_XML.X.value('ProductoId[1]','INT')),
							@cantidad =				CONVERT(INT, DATO_XML.X.value('Cantidad[1]','INT'))
							FROM @iXML.nodes('/CompraUnidad') AS DATO_XML(X)
								
					SET @Id_usuario = (SELECT U.Id FROM Usuario AS U WHERE U.Cedula = @cedula_usuario)	
					SET @codigo_forma_pago = (SELECT F.Codigo FROM FormaPago AS F WHERE F.Metodo = @nombre_forma_pago)						

					DECLARE @email AS VARCHAR(255) = (SELECT U.Email FROM Usuario AS U WHERE U.Cedula = @cedula_usuario)

					PRINT @Id_Usuario
					PRINT @email

					INSERT INTO FormaPago_Usuario 
					(Usuario, FormaPago, Cuenta, CreatedAt) 
					VALUES 
					(@Id_usuario, 'PAY', @email, GETDATE())

					DECLARE @contador_FormaPago_Usuario AS INT = (SELECT COUNT(*) FROM FormaPago_Usuario)

					INSERT INTO CompraUnidad 
					(Producto,		Cantidad)
					VALUES
					(@Id_producto, @cantidad)

					DECLARE @contador_CompraUnidad AS INT = (SELECT COUNT(*) FROM CompraUnidad)

					PRINT @contador_FormaPago_Usuario
					PRINT @contador_CompraUnidad

					INSERT INTO CompraConjunto 
					(CompraUnidad,				FormaPago_Usuario)
					VALUES
					(@contador_CompraUnidad,	@contador_CompraUnidad)

					SET @respuesta	= 'Ok'
					SET @leyenda	= 'Se ha insertado un nuevo registro.'
				END		
			
			-- CONFIRMAR TRANSACTION
			IF @@TRANCOUNT > 0
				BEGIN 
					COMMIT TRANSACTION TRX;
				END
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0 
			BEGIN 
				ROLLBACK TRANSACTION TRX;
			END
			SET @respuesta	= 'Bad'
			SET @leyenda	= 'Ha occurrido un error.' + ERROR_MESSAGE()
	END CATCH

	SELECT @respuesta as Respuesta, @leyenda as Leyenda
END
GO