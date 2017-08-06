-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spReportsDashboardUpdate]
		@manufacturerId  INT,
		@countryName     VARCHAR(100),  
		@docsubtype      VARCHAR(100),
		@notes			 VARCHAR(2000) = NULL,
		@CNK             VARCHAR(50) = NULL
AS
BEGIN
	
	UPDATE [Fact.DashboardReport] SET
		Notes = @notes ,
		CNK   = @CNK
	WHERE
		ManufacturerId = @manufacturerId
	AND CountryName    = @countryName
	AND DocSubType     = @docsubtype
	
	
	
END