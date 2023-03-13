USE [master]
GO
/****** Object:  StoredProcedure [dbo].[GetUsuario]    Script Date: 3/6/2023 9:11:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetRol]
	-- Add the parameters for the stored procedure here
	@iTransaccion	as varchar(50), 
	@iXML			as XML	 = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @respuesta		AS VARCHAR(10);
	DECLARE @leyenda		AS VARCHAR(50);

    -- Insert statements for procedure here
	BEGIN TRY

		IF(@iTransaccion = 'CONSULTA_ROLES_TODOS')
			BEGIN
				SELECT 
					R.Codigo, 
					R.Descripcion 
				FROM RolUsuario AS R 

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
