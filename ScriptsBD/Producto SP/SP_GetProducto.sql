CREATE PROCEDURE [dbo].[GetProducto]
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
	BEGIN TRY
	---INSERT
BEGIN TRANSACTION TRX_DATOS
-----------CONSULTA PRODUCTOS
		IF(@iTransaccion = 'CONSULTA_PRODUCTO_TODOS')
			BEGIN
				SELECT          P.Id,
						P.Nombre,
						P.Descripcion,
						P.ImagenUrl,
						P.Precio,
						CP.Descripcion AS Categoria					
				FROM Producto AS P 
				INNER JOIN CategoriaProducto AS CP
				ON CP.Codigo = P.Categoria
				WHERE P.Estado != 'I'
				SET @respuesta	= 'ok';
				SET @leyenda	= 'Consulta exitosa';
			END	

--------CONSULTA_PRODUCTO_CATEGORIA
	IF(@iTransaccion = 'CONSULTA_PRODUCTO_CATEGORIA')
			BEGIN
				SELECT	@categoria = CONVERT(VARCHAR, DATO_XML.X.value('Categoria[1]', 'VARCHAR(20)'))
				FROM	@iXML.nodes('/Producto') AS DATO_XML(X)

				SELECT  P.Id,
						P.Nombre,
						P.Descripcion,
						P.ImagenUrl,
						P.Precio,
						CP.Descripcion AS Categoria
				FROM Producto AS P 
				INNER JOIN CategoriaProducto AS CP
				ON CP.Codigo = P.Categoria
				WHERE P.Categoria = @categoria AND P.Estado != 'I'

				SET @respuesta	= 'ok';
				SET @leyenda	= 'Consulta exitosa';
			END 


-------------CONSULTA ID POR CATEGORIA
		IF(@iTransaccion = 'CONSULTA_PRODUCTO_ID')
			BEGIN
				SELECT 
				@id = CONVERT(INT, DATO_XML.X.value('Id[1]','INT'))
				FROM @iXML.nodes('/Producto') AS DATO_XML(X)
				SELECT  P.Id,
						P.Nombre,
						P.Descripcion,
						P.ImagenUrl,
						P.Precio,
						CP.Codigo AS CodigoCategoria,
						CP.Descripcion AS Categoria					
				FROM Producto AS P 
				INNER JOIN CategoriaProducto AS CP
				ON CP.Codigo = P.Categoria
				WHERE Id = @id
				SET @respuesta	= 'ok';
				SET @leyenda	= 'Consulta exitosa';
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
	SELECT @respuesta as respuesta, @leyenda as leyenda
END

