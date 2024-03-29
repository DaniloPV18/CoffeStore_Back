CREATE PROCEDURE [dbo].[SetUsuario]
	-- Add the parameters for the stored procedure here
	@iTransaccion	AS VARCHAR(50),
	@iXML			AS XML = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @Id						AS INT
	DECLARE @cedula					AS VARCHAR(255)
	DECLARE @nombres				AS VARCHAR(255)
	DECLARE @apellidos				AS VARCHAR(255)
	DECLARE @fecha_nacimiento		AS DATE
	DECLARE @email					AS VARCHAR(50)
	DECLARE @contrasena				AS VARCHAR(50)
	DECLARE @rol					AS VARCHAR(50)
	DECLARE @estado					AS VARCHAR(50)
	DECLARE @f_creacion				AS DATETIME = NULL
	DECLARE @f_actualizado			AS DATETIME = NULL

	DECLARE @respuesta		AS VARCHAR(50)
	DECLARE @leyenda		AS VARCHAR(50)

	BEGIN TRY
		BEGIN TRANSACTION TRX
			IF(@iTransaccion = 'INSERT')
				BEGIN
					SELECT 
							@cedula =				LTRIM(RTRIM(DATO_XML.X.value('Cedula[1]','VARCHAR(255)'))),
							@nombres =				LTRIM(RTRIM(DATO_XML.X.value('Nombres[1]','VARCHAR(255)'))),
							@apellidos =			LTRIM(RTRIM(DATO_XML.X.value('Apellidos[1]','VARCHAR(255)'))),
							@fecha_nacimiento =		CONVERT(DATE, DATO_XML.X.value('FechaNacimiento[1]','DATE')),
							@email =				LTRIM(RTRIM(DATO_XML.X.value('Email[1]','VARCHAR(50)'))),
							@contrasena =			LTRIM(RTRIM(DATO_XML.X.value('Contrasena[1]','VARCHAR(50)'))),
							@rol =					LTRIM(RTRIM(DATO_XML.X.value('Rol[1]','VARCHAR(50)'))),
							--@estado =				LTRIM(RTRIM(DATO_XML.X.value('Estado[1]','VARCHAR(50)'))),
							@f_creacion =			GETDATE()
							FROM @iXML.nodes('/Usuario') AS DATO_XML(X)

					INSERT INTO Usuario
					(Nombres,	Apellidos,	FechaNacimiento,	Email,	Contrasena,	Rol,	Estado,		CreatedAt, Cedula)
					VALUES 
					(@nombres,	@apellidos,	@fecha_nacimiento,	@email,	@contrasena,@rol,	'A',	@f_creacion, @cedula)

					SET @respuesta	= 'Ok'
					SET @leyenda	= 'Se ha insertado un nuevo registro.'
				END

			IF(@iTransaccion = 'UPDATE')
				BEGIN
					SELECT 
							@Id=					CONVERT(INT, DATO_XML.X.value('Id[1]','INT')),
							@cedula =				LTRIM(RTRIM(DATO_XML.X.value('Cedula[1]','VARCHAR(255)'))),
							@nombres =				LTRIM(RTRIM(DATO_XML.X.value('Nombres[1]','VARCHAR(255)'))),
							@apellidos =			LTRIM(RTRIM(DATO_XML.X.value('Apellidos[1]','VARCHAR(255)'))),
							@fecha_nacimiento =		CONVERT(DATE, DATO_XML.X.value('FechaNacimiento[1]','DATE')),
							@email =				LTRIM(RTRIM(DATO_XML.X.value('Email[1]','VARCHAR(50)'))),
							--@contrasena =			LTRIM(RTRIM(DATO_XML.X.value('Contrasena[1]','VARCHAR(50)'))),
							@rol =					LTRIM(RTRIM(DATO_XML.X.value('Rol[1]','VARCHAR(50)'))),
							--@estado =				LTRIM(RTRIM(DATO_XML.X.value('Estado[1]','VARCHAR(50)'))),
							@f_actualizado =		GETDATE()
							FROM @iXML.nodes('/Usuario') AS DATO_XML(X)

					UPDATE Usuario
					SET 
						Cedula			= @cedula,
						Nombres			= @nombres, 
						Apellidos		= @apellidos,
						--FechaNacimiento	= @fecha_nacimiento,
						Email			= @email,
						--Contrasena		= @contrasena,
						Rol				= @rol,
						UpdateAt		= @f_actualizado
					WHERE Id = @id;
					--WHERE Cedula = @cedula;

					SET @respuesta	= 'Ok'
					SET @leyenda	= 'Se ha actualizado un registro.'
				END

			IF(@iTransaccion = 'DELETE')
				BEGIN
					SELECT 
							@Id=				CONVERT(INT, DATO_XML.X.value('Id[1]','INT')),		
							@cedula =			LTRIM(RTRIM(DATO_XML.X.value('Cedula[1]','VARCHAR(255)'))),
							@estado =			LTRIM(RTRIM(DATO_XML.X.value('Estado[1]','VARCHAR(255)')))
							FROM @iXML.nodes('/Usuario') AS DATO_XML(X)

					UPDATE Usuario
					SET 
						Estado			= 'I'
					WHERE Id = @id;
					--WHERE Cedula = @cedula;

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
			SET @leyenda	= 'Ha occurrido un error.'  + ERROR_MESSAGE()
	END CATCH

	SELECT @respuesta as Respuesta, @leyenda as Leyenda
END
