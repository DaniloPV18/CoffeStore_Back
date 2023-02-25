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
ALTER PROCEDURE SetUsuario
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
							@nombres =				LTRIM(RTRIM(DATO_XML.X.value('Nombres[1]','VARCHAR(255)'))),
							@apellidos =			LTRIM(RTRIM(DATO_XML.X.value('Apellidos[1]','VARCHAR(255)'))),
							@fecha_nacimiento =		CONVERT(DATE, DATO_XML.X.value('FechaNacimiento[1]','DATE')),
							@email =				LTRIM(RTRIM(DATO_XML.X.value('Email[1]','VARCHAR(50)'))),
							@contrasena =			PWDENCRYPT(LTRIM(RTRIM(DATO_XML.X.value('Contrasena[1]','VARCHAR(50)')))),
							@rol =					LTRIM(RTRIM(DATO_XML.X.value('Rol[1]','VARCHAR(50)'))),
							@estado =				LTRIM(RTRIM(DATO_XML.X.value('Estado[1]','VARCHAR(50)'))),
							@f_creacion =			GETDATE()
							FROM @iXML.nodes('/Usuario') AS DATO_XML(X)

					INSERT INTO Usuario
					(Nombres,	Apellidos,	FechaNacimiento,	Email,	Contrasena,	Rol,	Estado,		CreatedAt)
					VALUES 
					(@nombres,	@apellidos,	@fecha_nacimiento,	@email,	@contrasena,@rol,	@estado,	@f_creacion)

					SET @respuesta	= 'Ok'
					SET @leyenda	= 'Se ha insertado un nuevo registro.'
				END

			IF(@iTransaccion = 'UPDATE')
				BEGIN
					SELECT 
							@nombres =				LTRIM(RTRIM(DATO_XML.X.value('Nombres[1]','VARCHAR(255)'))),
							@apellidos =			LTRIM(RTRIM(DATO_XML.X.value('Apellidos[1]','VARCHAR(255)'))),
							@fecha_nacimiento =		CONVERT(DATE, DATO_XML.X.value('FechaNacimiento[1]','DATE')),
							@email =				LTRIM(RTRIM(DATO_XML.X.value('Email[1]','VARCHAR(50)'))),
							@contrasena =			LTRIM(RTRIM(DATO_XML.X.value('Contrasena[1]','VARCHAR(50)'))),
							@rol =					LTRIM(RTRIM(DATO_XML.X.value('Rol[1]','VARCHAR(50)'))),
							@estado =				LTRIM(RTRIM(DATO_XML.X.value('Estado[1]','VARCHAR(50)'))),
							@f_actualizado =		GETDATE()
							FROM @iXML.nodes('/Usuario') AS DATO_XML(X)

					UPDATE Usuario
					SET 
						Nombres			= @nombres, 
						Apellidos		= @apellidos,
						FechaNacimiento	= @fecha_nacimiento,
						Email			= @email,
						Contrasena		= @contrasena,
						Rol				= @rol,
						UpdateAt		= @f_actualizado
					WHERE Id = @id;

					SET @respuesta	= 'Ok'
					SET @leyenda	= 'Se ha actualizado un registro.'
				END

			IF(@iTransaccion = 'CHANGE_STATUS')
				BEGIN
					SELECT 
							@Id=				CONVERT(INT, DATO_XML.X.value('Id[1]','INT')),							
							@estado =			LTRIM(RTRIM(DATO_XML.X.value('Estado[1]','VARCHAR(255)')))
							FROM @iXML.nodes('/Usuario') AS DATO_XML(X)

					UPDATE Usuario
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