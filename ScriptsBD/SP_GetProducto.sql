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
CREATE PROCEDURE GetProducto
	-- Add the parameters for the stored procedure here
	@iTransaccion	as varchar(50), 
	@iXML			as XML	 = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @categoria as VARCHAR(20);

	DECLARE @respuesta	AS VARCHAR(10);
	DECLARE @leyenda	AS VARCHAR(50);

    -- Insert statements for procedure here
	BEGIN TRY

		IF(@iTransaccion = 'CONSULTA_PRODUCTO_TODOS')
			BEGIN
				SELECT 
						P.Nombre,
						P.Descripcion,
						P.ImagenUrl,
						P.Precio,
						CP.Descripcion						
				FROM Producto AS P 
				INNER JOIN CategoriaProducto AS CP
				ON CP.Codigo = P.Categoria

				SET @respuesta	= 'ok';
				SET @leyenda	= 'Consulta exitosa';
			END

		IF(@iTransaccion = 'CONSULTA_PRODUCTO_CATEGORIA')
			BEGIN
				SELECT	@categoria = CONVERT(VARCHAR, DATO_XML.X.value('Categoria[1]', 'VARCHAR(20)'))
				FROM	@iXML.nodes('/Producto') AS DATO_XML(X)

				SELECT 
						P.Nombre,
						P.Descripcion,
						P.ImagenUrl,
						P.Precio,
						CP.Descripcion
				FROM Producto AS P 
				INNER JOIN CategoriaProducto AS CP
				ON CP.Codigo = P.Categoria
				WHERE P.Categoria = @categoria

				SET @respuesta	= 'ok';
				SET @leyenda	= 'Consulta exitosa';
			END 

	END TRY

	BEGIN CATCH
		SET @respuesta	= 'Error';
		SET @leyenda	= ERROR_MESSAGE();
	END CATCH

	SELECT @respuesta as respuesta, @leyenda as leyenda
END
GO