-- =============================================
-- Author:		Javier
-- Create date: April 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spUsersUpdateLastActivity
	@userId			INT=NULL,
	@lastActivity	DATETIME =NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Declare transaction and set to false
	DECLARE @TranStarted   BIT
	SET @TranStarted = 0

	--Check transaction count and Begin Transaction
	IF( @@TRANCOUNT = 0 )
		BEGIN
			BEGIN TRANSACTION -- Start transaction
			SET @TranStarted = 1
		END
	ELSE
			SET @TranStarted = 0


	BEGIN	-- (Start of update)
		
		UPDATE [Application.Users] SET
			LastActivity = @lastActivity
		WHERE
			PKID = @userId
		
		--Select users last Activity
		Select LastActivity
		FROM [Application.Users]
		WHERE
			PKID = @userId
			
		-- Check if error occured --
		IF (@@ERROR <> 0) 
		GOTO CLEANUP	
		
	END	-- (End of insert)

	-- No error Commit transaction --
	IF( @TranStarted = 1 )
	BEGIN
		SET @TranStarted = 0
		COMMIT TRANSACTION
	END

		-- ROLLBACK TRANSACTION --
	CLEANUP:
	IF (@TranStarted = 1)
	BEGIN
		SET @TranStarted = 0
		ROLLBACK TRANSACTION
	END
END