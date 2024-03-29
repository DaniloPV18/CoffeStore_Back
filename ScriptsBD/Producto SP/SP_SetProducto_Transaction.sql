CREATE PROCEDURE [dbo].[SetProducto]
	-- Add the parameters for the stored procedure here
	@iTransaccion	as varchar(50), 
	@iXML			as XML	 = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @respuesta	AS VARCHAR(10);
	DECLARE @leyenda	AS VARCHAR(100);
	DECLARE @categoria as VARCHAR(20);
	DECLARE @id int;
	DECLARE @nombre AS VARCHAR (50);
	DECLARE @descripcion AS VARCHAR (500);
	DECLARE @imagenUrl  AS VARCHAR (500);
	DECLARE @precio FLOAT
	DECLARE @estado AS VARCHAR (50);
	DECLARE @createdAt DATETIME;
	DECLARE @updateadAt  DATETIME;
	BEGIN TRY
	---INSERT
BEGIN TRANSACTION TRX_DATOS
	IF(@iTransaccion = 'INSERT')
			BEGIN 
			SELECT
			 @nombre = LTRIM(RTRIM(DATO_XML.X.value('Nombre[1]', 'VARCHAR(20)'))),
			 @descripcion = LTRIM(RTRIM(DATO_XML.X.value('Descripcion[1]', 'VARCHAR(20)'))),
			 @imagenUrl = LTRIM(RTRIM(DATO_XML.X.value('ImagenUrl[1]', 'VARCHAR(50)'))),
			 @precio = CONVERT(float, DATO_XML.X.value('Precio[1]', 'FLOAT')),
			 @categoria = LTRIM(RTRIM(DATO_XML.X.value('Categoria[1]', 'VARCHAR(20)'))),
			 @estado = CONVERT(varchar, DATO_XML.X.value('Estado[1]', 'VARCHAR(20)')),
			 @createdAt = CONVERT(datetime, DATO_XML.X.value('CreatedAt[1]', 'DATETIME')),
			 @updateadAt = CONVERT(datetime, DATO_XML.X.value('CreatedAt[1]', 'DATETIME'))
			 FROM @iXML.nodes('/Producto') AS DATO_XML(X)

			 INSERT INTO Producto(Nombre, Descripcion,ImagenUrl, Precio, Categoria,Estado, CreatedAt, UpdatedAt)
			 VALUES (@nombre,@descripcion,@imagenUrl,@precio,@categoria,'A',@createdAt,null)
			 
			 SET @respuesta= 'OK';
			 SET @leyenda = 'SE HA INSETRADOm DE MANERA CORRECTA EL NUEVO PRODUCTO AL SISTEMA';
			END

----MOIDIFICAR
			IF(@iTransaccion = 'MODIFY')
			BEGIN 
	SELECT   @id = CONVERT(INT, DATO_XML.X.value('Codigo[1]','INT')),
			 @nombre = LTRIM(RTRIM(DATO_XML.X.value('Nombre[1]', 'VARCHAR(20)'))),
			 @descripcion = LTRIM(RTRIM(DATO_XML.X.value('Descripcion[1]', 'VARCHAR(20)'))),
			 @imagenUrl = LTRIM(RTRIM(DATO_XML.X.value('ImagenUrl[1]', 'VARCHAR(50)'))),
			 @precio = CONVERT(float, DATO_XML.X.value('Precio[1]', 'FLOAT')),
			 @categoria = CONVERT(varchar, DATO_XML.X.value('Categoria[1]', 'VARCHAR(20)')),
			 @estado = CONVERT(varchar, DATO_XML.X.value('Estado[1]', 'VARCHAR(20)')),
			 @updateadAt = CONVERT(datetime, DATO_XML.X.value('CreatedAt[1]', 'DATETIME'))
	         FROM @iXML.nodes('/Producto') AS DATO_XML(X)
	UPDATE Producto 
	SET 
			Nombre =@nombre,
			Descripcion =@descripcion,
			ImagenUrl = @imagenUrl,
			Precio = @precio,
			Categoria = @categoria,
			Estado= @estado,
			UpdatedAt = @updateadAt
			WHERE Id =@id

	SET @respuesta = 'OK';
	SET @leyenda= 'SE HA ACTUALIZADO UN REGISTRO';
	END


--ELIMINAR
	IF (@iTransaccion = 'DELETE')
		BEGIN 
		SELECT 
		@id = CONVERT(INT, DATO_XML.X.value('Codigo[1]','INT'))
		FROM @iXML.nodes('/Producto') AS DATO_XML(X)
		UPDATE Producto
		SET 
		Estado= 'I'
		WHERE id = @id
		SET @respuesta = 'OK';
		SET @leyenda= 'SE HA ELIMINADO UN REGISTRO';
	END


		IF @@TRANCOUNT > 0
				BEGIN 
				COMMIT TRANSACTION TRX_DATOS;
		END
					END TRY
					BEGIN CATCH
						IF  @@TRANCOUNT > 0
								BEGIN 
								ROLLBACK TRANSACTION TRX_DATOS;
								END
					   SET @respuesta	= 'Error';
						SET @leyenda	= ERROR_MESSAGE();
					END CATCH
	SELECT @respuesta as respuesta,  @leyenda as leyenda
END

