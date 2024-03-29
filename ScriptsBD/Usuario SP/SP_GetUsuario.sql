CREATE PROCEDURE [dbo].[GetUsuario]
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
	DECLARE @cedula		AS VARCHAR(50);
	DECLARE @id			AS INT;

	DECLARE @contador	AS INT = 0;

	DECLARE @respuesta	AS VARCHAR(10);
	DECLARE @leyenda	AS VARCHAR(50);
	DECLARE @validacion	AS VARCHAR(50);
    -- Insert statements for procedure here
	BEGIN TRY

		IF(@iTransaccion = 'CONSULTA_USUARIO_TODOS')
			BEGIN
				SELECT 
						U.Id,
						U.Cedula,
						U.Nombres,
						U.Apellidos,
						U.FechaNacimiento,
						U.Email,
						R.Descripcion					
				FROM Usuario AS U 
				INNER JOIN RolUsuario AS R
				ON U.Rol = R.Codigo
				WHERE U.Estado != 'I'

				SET @respuesta	= 'ok';
				SET @leyenda	= 'Consulta exitosa';
			END

		IF(@iTransaccion = 'CONSULTA_USUARIO_ID')
			BEGIN
				SELECT	@id = CONVERT(VARCHAR, DATO_XML.X.value('Id[1]', 'INT'))
				FROM	@iXML.nodes('/Usuario') AS DATO_XML(X)

				SELECT 
						U.Id,
						U.Cedula,
						U.Nombres,
						U.Apellidos,
						U.FechaNacimiento,
						U.Email,
						R.Descripcion			
				FROM Usuario AS U 
				INNER JOIN RolUsuario AS R
				ON U.Rol = R.Codigo
				WHERE U.id = @id

				SET @respuesta	= 'ok';
				SET @leyenda	= 'Consulta exitosa';
			END

		IF(@iTransaccion = 'CONSULTA_USUARIO_CEDULA')
			BEGIN
				SELECT	@cedula = CONVERT(VARCHAR, DATO_XML.X.value('Cedula[1]', 'VARCHAR(20)'))
				FROM	@iXML.nodes('/Usuario') AS DATO_XML(X)

				SELECT 
						U.Id,
						U.Cedula,
						U.Nombres,
						U.Apellidos,
						U.FechaNacimiento,
						U.Email,
						R.Descripcion					
				FROM Usuario AS U 
				INNER JOIN RolUsuario AS R
				ON U.Rol = R.Codigo
				WHERE U.Cedula = @cedula 

				SET @respuesta	= 'ok';
				SET @leyenda	= 'Consulta exitosa';
			END

		IF(@iTransaccion = 'CONSULTA_USUARIO_ROL')
			BEGIN
				SELECT	@rol = CONVERT(VARCHAR, DATO_XML.X.value('Descripcion[1]', 'VARCHAR(20)'))
				FROM	@iXML.nodes('/Usuario/Rol') AS DATO_XML(X)

				SELECT 
						U.Id,
						U.Cedula,
						U.Nombres,
						U.Apellidos,
						U.FechaNacimiento,
						U.Email,
						U.Estado,
						R.Descripcion
				FROM Usuario AS U 
				INNER JOIN RolUsuario AS R
				ON U.Rol = R.Codigo
				WHERE R.Descripcion = @rol

				SET @respuesta	= 'ok';
				SET @leyenda	= 'Consulta exitosa';
			END 

		IF(@iTransaccion = 'CONSULTA_USUARIO_CORREO_EXISTE')
			BEGIN
				SELECT	
						@email		= CONVERT(VARCHAR, DATO_XML.X.value('Email[1]', 'VARCHAR(50)')),
						@contrasena = CONVERT(VARCHAR, DATO_XML.X.value('Contrasena[1]', 'VARCHAR(50)'))
				FROM	@iXML.nodes('/Usuario') AS DATO_XML(X)

				IF EXISTS(
					SELECT *
					FROM Usuario AS U
					WHERE U.Email = @email
					--AND U.Contrasena = @contrasena
				)
				BEGIN 
					-- SI EXISTE LA CUENTA Y LA CONTRASEÑA ESTA BIEN SE DEVUELVE 1
					SET @contador = 1;
					SET @validacion = 'EXISTE';
				END
				ELSE
					BEGIN 
						-- SI NO EXISTE LA CUENTA O LA CONTRASEÑA SE DEVUELVE O
						SET @contador = 0;
						SET @validacion = 'NO EXISTE';
					END

				SET @respuesta	= 'ok';
				SET @leyenda	= 'Consulta exitosa';
			END
		
		IF(@iTransaccion = 'CONSULTA_USUARIO_CORREO')
			BEGIN
				SELECT @email = CONVERT(VARCHAR, DATO_XML.X.value('Email[1]', 'VARCHAR(50)'))
				FROM	@iXML.nodes('/Usuario') AS DATO_XML(X)

				SELECT 
						*					
				FROM Usuario AS U 
				INNER JOIN RolUsuario AS R
				ON U.Rol = R.Codigo
				WHERE U.Email = @email

				SET @respuesta	= 'ok';
				SET @leyenda	= 'Consulta exitosa';
			END

	END TRY

	BEGIN CATCH
		SET @respuesta	= 'Error';
		SET @leyenda	= ERROR_MESSAGE();
	END CATCH

	SELECT @respuesta as respuesta, @leyenda as leyenda, @contador as contador, @validacion as validacion
END
