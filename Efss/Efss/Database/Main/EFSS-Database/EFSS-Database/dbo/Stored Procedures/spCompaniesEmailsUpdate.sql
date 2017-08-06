-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE spCompaniesEmailsUpdate
		@messageId INT,
		@title	   VARCHAR(255)  = NULL,
		@header	   VARCHAR(255)  = NULL,
		@body	   VARCHAR(4000) = NULL,
		@footer    VARCHAR(1000) = NULL
AS
BEGIN
	
		UPDATE [Dimension.CompanyMessages] SET
			Title  = @title , 
			Header = @header ,
			Body   = @body ,
			Footer = @footer
		WHERE
			MessageId = @messageId
		

END