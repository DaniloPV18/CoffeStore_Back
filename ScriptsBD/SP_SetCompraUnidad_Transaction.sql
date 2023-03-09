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

	DECLARE @Id_forma_pago		AS INT
	DECLARE @codigo_forma_pago	AS VARCHAR(255)

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
							@cedula_usuario =		CONVERT(INT, DATO_XML.X.value('Cedula[1]','VARCHAR(255)'))
							FROM @iXML.nodes('/CompraUnidad/Usuario') AS DATO_XML(X)

					SELECT
							@codigo_forma_pago =	CONVERT(INT, DATO_XML.X.value('Codigo[1]','VARCHAR(255)'))
							FROM @iXML.nodes('/CompraUnidad/FormaPago') AS DATO_XML(X)

					SELECT
							@Id_producto =	CONVERT(INT, DATO_XML.X.value('Id[1]','INT'))
							FROM @iXML.nodes('/CompraUnidad/Producto') AS DATO_XML(X)



					INSERT INTO 
					Producto
					(Nombre, Descripcion, ImagenUrl, Precio,	Categoria, Estado, CreatedAt)
					VALUES 
					(@nombre,@descripcion,@imagen_url,@precio,	@categoria,@estado,@f_creacion)

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
			SET @leyenda	= 'Ha occurrido un error.'
	END CATCH

	SELECT @respuesta as Respuesta, @leyenda as Leyenda
GO