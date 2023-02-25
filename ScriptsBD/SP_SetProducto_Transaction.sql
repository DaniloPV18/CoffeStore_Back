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
CREATE PROCEDURE SetProducto
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
	DECLARE @nombre				AS VARCHAR(50)
	DECLARE @descripcion		AS VARCHAR(50)
	DECLARE @imagen_url			AS VARCHAR(50)
	DECLARE @precio				AS VARCHAR(50)
	DECLARE @categoria			AS FLOAT
	DECLARE @estado				AS VARCHAR(50)
	DECLARE @f_creacion			AS DATETIME = NULL
	DECLARE @f_actualizado		AS DATETIME = NULL

	DECLARE @respuesta AS VARCHAR(50)
	DECLARE @leyenda AS VARCHAR(50)

	BEGIN TRY
		BEGIN TRANSACTION TRX
			IF(@iTransaccion = 'INSERT')
				BEGIN
					SELECT 
							@nombre =			LTRIM(RTRIM(DATO_XML.X.value('Nombre[1]','VARCHAR(255)'))),
							@descripcion =		LTRIM(RTRIM(DATO_XML.X.value('Descripcion[1]','VARCHAR(255)'))),
							@imagen_url =		LTRIM(RTRIM(DATO_XML.X.value('ImagenUrl[1]','VARCHAR(255)'))),
							@precio =			CONVERT(FLOAT, DATO_XML.X.value('Precio[1]','FLOAT')),
							@categoria =		LTRIM(RTRIM(DATO_XML.X.value('Categoria[1]','VARCHAR(20)'))),
							@estado =			LTRIM(RTRIM(DATO_XML.X.value('Estado[1]','VARCHAR(255)'))),
							@f_creacion =		GETDATE()
							FROM @iXML.nodes('/Producto') AS DATO_XML(X)

					INSERT INTO 
					Producto
					(Nombre, Descripcion, ImagenUrl, Precio,	Categoria, Estado, CreatedAt)
					VALUES 
					(@nombre,@descripcion,@imagen_url,@precio,	@categoria,@estado,@f_creacion)

					SET @respuesta	= 'Ok'
					SET @leyenda	= 'Se ha insertado un nuevo registro.'
				END

			IF(@iTransaccion = 'UPDATE')
				BEGIN
					SELECT 
							@Id=				CONVERT(INT, DATO_XML.X.value('Id[1]','INT')),
							@nombre =			LTRIM(RTRIM(DATO_XML.X.value('Nombre[1]','VARCHAR(255)'))),
							@descripcion =		LTRIM(RTRIM(DATO_XML.X.value('Descripcion[1]','VARCHAR(255)'))),
							@imagen_url =		LTRIM(RTRIM(DATO_XML.X.value('ImagenUrl[1]','VARCHAR(255)'))),
							@precio =			CONVERT(FLOAT, DATO_XML.X.value('Precio[1]','FLOAT')),
							@categoria =		LTRIM(RTRIM(DATO_XML.X.value('Categoria[1]','VARCHAR(20)'))),
							@estado =			LTRIM(RTRIM(DATO_XML.X.value('Estado[1]','VARCHAR(255)'))),
							@f_actualizado =	GETDATE()
							FROM @iXML.nodes('/Producto') AS DATO_XML(X)

					UPDATE Producto
					SET 
						Nombre			= @nombre, 
						Descripcion		= @descripcion,
						ImagenUrl		= @imagen_url,
						Precio			= @precio,
						Categoria		= @categoria,
						UpdatedAt		= @f_actualizado
					WHERE Id = @id;

					SET @respuesta	= 'Ok'
					SET @leyenda	= 'Se ha actualizado un registro.'
				END

			IF(@iTransaccion = 'CHANGE_STATUS')
				BEGIN
					SELECT 
							@Id=				CONVERT(INT, DATO_XML.X.value('Id[1]','INT')),							
							@estado =			LTRIM(RTRIM(DATO_XML.X.value('Estado[1]','VARCHAR(255)')))
							FROM @iXML.nodes('/Producto') AS DATO_XML(X)

					UPDATE Producto
					SET 
						Estado			= @estado
					WHERE Id = @id;

					SET @respuesta	= 'Ok'
					SET @leyenda	= 'Se ha actualizado un registro.'
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
END
GO