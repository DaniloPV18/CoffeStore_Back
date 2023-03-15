CREATE PROCEDURE [dbo].[Authentication]
	@iTransaccion	as varchar(50), 
	@iXML			as XML	 = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @rol					AS VARCHAR(20);
	DECLARE @email					AS VARCHAR(20);
	DECLARE @cedula					AS VARCHAR(255);
	DECLARE @contrasena				AS VARCHAR(255);
	DECLARE @nombres				AS VARCHAR(255)
	DECLARE @apellidos				AS VARCHAR(255)
	DECLARE @id						AS INT;
	DECLARE @fecha_nacimiento		AS DATE
	DECLARE @contador				AS INT = 0;

	DECLARE @respuesta				AS VARCHAR(10);
	DECLARE @leyenda				AS VARCHAR(50);
	DECLARE @validacion				AS VARCHAR(50);

	BEGIN TRY
		IF(@iTransaccion = 'LOGIN')
		BEGIN
			SELECT	@email = CONVERT(VARCHAR, DATO_XML.X.value('Email[1]', 'VARCHAR(255)'))
			FROM	@iXML.nodes('/Usuario') AS DATO_XML(X)

			SELECT U.Id, U.Nombres, U.Apellidos, U.Rol, U.Contrasena
			FROM Usuario AS U
			WHERE U.Email = @email

			SET @respuesta	= 'ok';
			SET @leyenda	= 'Consulta exitosa';
		END
		IF(@iTransaccion = 'REGISTER')
		BEGIN
			SELECT 
				@nombres =				LTRIM(RTRIM(DATO_XML.X.value('Nombres[1]','VARCHAR(255)'))),
				@apellidos =			LTRIM(RTRIM(DATO_XML.X.value('Apellidos[1]','VARCHAR(255)'))),
				@fecha_nacimiento =		CONVERT(DATE, DATO_XML.X.value('FechaNacimiento[1]','DATE')),
				@email =				LTRIM(RTRIM(DATO_XML.X.value('Email[1]','VARCHAR(50)'))),
				@contrasena =			LTRIM(RTRIM(DATO_XML.X.value('Contrasena[1]','VARCHAR(255)'))),
				@rol =					LTRIM(RTRIM(DATO_XML.X.value('Rol[1]','VARCHAR(50)'))),
				@cedula =				LTRIM(RTRIM(DATO_XML.X.value('Cedula[1]','VARCHAR(255)')))
			FROM @iXML.nodes('/Usuario') AS DATO_XML(X)

			INSERT INTO Usuario
				(Nombres,	Apellidos, Cedula,	FechaNacimiento,	Email,	Contrasena,	Rol,	Estado,		CreatedAt)
			VALUES 
				(@nombres,	@apellidos, @cedula,	@fecha_nacimiento,	@email,	@contrasena,@rol,	'A',	GETDATE())

			SELECT U.Id, U.Nombres, U.Apellidos, U.Rol
			FROM Usuario AS U
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
