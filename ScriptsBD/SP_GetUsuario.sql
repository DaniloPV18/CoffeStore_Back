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
CREATE PROCEDURE GetUsuario
	-- Add the parameters for the stored procedure here
	@iTransaccion	as varchar(50), 
	@iXML			as XML	 = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @rol		AS VARCHAR(20);
	DECLARE @email		AS VARCHAR(20);
	DECLARE @contrasena	AS VARCHAR(50);

	DECLARE @contador	AS INT = 0;

	DECLARE @respuesta	AS VARCHAR(10);
	DECLARE @leyenda	AS VARCHAR(50);

    -- Insert statements for procedure here
	BEGIN TRY

		IF(@iTransaccion = 'CONSULTA_USUARIO_TODOS')
			BEGIN
				SELECT 
						U.Nombres,
						U.Apellidos,
						U.FechaNacimiento,
						U.Email,
						U.Estado,
						R.Descripcion					
				FROM Usuario AS U 
				INNER JOIN RolUsuario AS R
				ON U.Rol = R.Codigo

				SET @respuesta	= 'ok';
				SET @leyenda	= 'Consulta exitosa';
			END

		IF(@iTransaccion = 'CONSULTA_USUARIO_ROL')
			BEGIN
				SELECT	@rol = CONVERT(VARCHAR, DATO_XML.X.value('Rol[1]', 'VARCHAR(20)'))
				FROM	@iXML.nodes('/Usuario') AS DATO_XML(X)

				SELECT 
						U.Nombres,
						U.Apellidos,
						U.FechaNacimiento,
						U.Email,
						U.Estado,
						R.Descripcion
				FROM Usuario AS U 
				INNER JOIN RolUsuario AS R
				ON U.Rol = R.Codigo
				WHERE R.Codigo = @rol

				SET @respuesta	= 'ok';
				SET @leyenda	= 'Consulta exitosa';
			END 

		IF(@iTransaccion = 'CONSULTA_USUARIO_CUENTA_EXISTE')
			BEGIN
				SELECT	
						@email		= CONVERT(VARCHAR, DATO_XML.X.value('Email[1]', 'VARCHAR(50)')),
						@contrasena = CONVERT(VARCHAR, DATO_XML.X.value('Contrasena[1]', 'VARCHAR(50)'))
				FROM	@iXML.nodes('/Usuario') AS DATO_XML(X)

				IF EXISTS(
					SELECT *
					FROM Usuario AS U
					WHERE U.Email = @email
					AND U.Contrasena = PWDENCRYPT(@contrasena)
				)
				BEGIN 
					-- SI EXISTE LA CUENTA Y LA CONTRASEÑA ESTA BIEN SE DEVUELVE 1
					SET @contador = 1;
				END
				ELSE
					BEGIN 
						-- SI NO EXISTE LA CUENTA O LA CONTRASEÑA SE DEVUELVE O
						SET @contador = 0;
					END

				SET @respuesta	= 'ok';
				SET @leyenda	= 'Consulta exitosa';
			END


	END TRY

	BEGIN CATCH
		SET @respuesta	= 'Error';
		SET @leyenda	= ERROR_MESSAGE();
	END CATCH

	SELECT @respuesta as respuesta, @leyenda as leyenda, @contador as contador
END
GO