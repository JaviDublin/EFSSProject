-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportActiveFleetMonthReport]
	
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @FileId	INT
	SET @FileId	= (SELECT FileId FROM [Application.Files]	WHERE FileCode = 'FAFRM')
	
	DECLARE @Month VARCHAR(2),
			@Year  VARCHAR(4)
				
		SET @Month = convert(varchar,MONTH(GETDATE()))
		SET @Year  = convert(varchar,YEAR(GETDATE()))
		
		DELETE FROM [Import.ActiveFleetMonthReport] WHERE DateYear = @Year AND DateMonth = @Month
	
		INSERT INTO [Import.ActiveFleetMonthReport] (CountryId , CompanyId , Total , Active , Conversion ,
		Delivered , Inactive , [Suspend] , Future_ISD , Other , FileId , LogId , DateCreated , DateYear , DateMonth)
	
		SELECT 
		dcc.CountryId			,
		dcc.CompanyId			, 
		TC.TotalCars			, 
		AC.TotalCarsActive		, 
		CO.TotalCarsConversion  ,
		DE.TotalCarsDelivered	,
		IC.TotalCarsInactive	,
		SC.TotalCarsSuspend		, 
		FU.TotalCarsFuture		,
		OC.TotalCarsOther		,
		@FileId					,
		AFD.LogId				,
		FLD.DateLog				,
		@Year,
		@Month
		FROM [Dimension.Companies] dcc
		LEFT JOIN [Staging.ActiveFleetMonth] AS AFD ON 
			dcc.CompanyId = AFD.CompanyId
		LEFT JOIN [Application.FileLog] AS FLD ON 
			 AFD.LogId = FLD.LogId
		LEFT JOIN 
		(	SELECT CompanyId , COUNT(*) AS "TotalCars"
			FROM [Staging.ActiveFleetMonth]
			GROUP BY CompanyId) AS TC ON AFD.CompanyId = TC.CompanyId
		LEFT JOIN 
		(	SELECT CompanyId , COUNT(*) AS "TotalCarsActive"
			FROM [Staging.ActiveFleetMonth]
			WHERE VehicleStatus = 'A'
			GROUP BY CompanyId) AS AC ON AFD.CompanyId = AC.CompanyId
		LEFT JOIN 
		(	SELECT CompanyId , COUNT(*) AS "TotalCarsInactive"
			FROM [Staging.ActiveFleetMonth]
			WHERE VehicleStatus = 'I'
			GROUP BY CompanyId) AS IC ON AFD.CompanyId = IC.CompanyId
		LEFT JOIN 
		(	SELECT CompanyId , COUNT(*) AS "TotalCarsSuspend"
			FROM [Staging.ActiveFleetMonth]
			WHERE VehicleStatus = 'S'
			GROUP BY CompanyId) AS SC ON AFD.CompanyId = SC.CompanyId
		LEFT JOIN 
		(	SELECT CompanyId , COUNT(*) AS "TotalCarsDelivered"
			FROM [Staging.ActiveFleetMonth]
			WHERE VehicleStatus = 'E'
			GROUP BY CompanyId) AS DE ON AFD.CompanyId = DE.CompanyId
		LEFT JOIN 
		(	SELECT CompanyId , COUNT(*) AS "TotalCarsFuture"
			FROM [Staging.ActiveFleetMonth]
			WHERE VehicleStatus = 'F'
			GROUP BY CompanyId) AS FU ON AFD.CompanyId = FU.CompanyId
		LEFT JOIN 
		(	SELECT CompanyId , COUNT(*) AS "TotalCarsConversion"
			FROM [Staging.ActiveFleetMonth]
			WHERE VehicleStatus = 'C'
			GROUP BY CompanyId) AS CO ON AFD.CompanyId = CO.CompanyId
		LEFT JOIN
		(	SELECT CompanyId , COUNT(*) AS "TotalCarsOther"
			FROM [Staging.ActiveFleetMonth]
			WHERE VehicleStatus not in ('A','S','I','F','E','C')
			GROUP BY CompanyId) AS OC ON AFD.CompanyId = OC.CompanyId

		GROUP BY 
			dcc.CountryId , dcc.CompanyId , TC.TotalCars , AC.TotalCarsActive , 
			IC.TotalCarsInactive , SC.TotalCarsSuspend , OC.TotalCarsOther , DE.TotalCarsDelivered , 
			FU.TotalCarsFuture , CO.TotalCarsConversion , AFD.LogId	, FLD.DateLog	
		ORDER BY dcc.CompanyId
													
													
		UPDATE [Import.ActiveFleetMonthReport] SET Total		= 0 WHERE Total IS NULL
		UPDATE [Import.ActiveFleetMonthReport] SET Active		= 0 WHERE Active IS NULL
		UPDATE [Import.ActiveFleetMonthReport] SET Conversion	= 0 WHERE Conversion IS NULL
		UPDATE [Import.ActiveFleetMonthReport] SET Delivered	= 0 WHERE Delivered IS NULL
		UPDATE [Import.ActiveFleetMonthReport] SET Inactive		= 0 WHERE Inactive IS NULL
		UPDATE [Import.ActiveFleetMonthReport] SET [Suspend]	= 0 WHERE [Suspend] IS NULL
		UPDATE [Import.ActiveFleetMonthReport] SET Future_ISD	= 0 WHERE Future_ISD IS NULL
		UPDATE [Import.ActiveFleetMonthReport] SET Other		= 0 WHERE Other IS NULL
  
END