USE [master]
GO
/****** Object:  StoredProcedure [dbo].[GetCategoria]    Script Date: 11/3/2023 12:57:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetCategoria]
	-- Add the parameters for the stored procedure here
    @iTransaccion	AS VARCHAR(50),
	@iXML			AS XML = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @respuesta		AS VARCHAR(50)
	DECLARE @leyenda		AS VARCHAR(50)
    -- Insert statements for procedure here

			IF(@iTransaccion = 'CONSULTA_CATEGORIA_TODOS')
			BEGIN
				SELECT * FROM CategoriaProducto 

				SET @respuesta	= 'ok';
				SET @leyenda	= 'Consulta exitosa';
			END	
END
