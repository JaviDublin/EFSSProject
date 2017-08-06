-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportBuyersParse]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @FileId	INT
	SET @FileId = (SELECT FileId FROM [Application.Files] WHERE FileCode = 'FBVND')
	
	
	TRUNCATE TABLE [Staging.Buyers]
	
	DELETE FROM [Import.BuyersVNDL] WHERE CompanyCode not in 
		(SELECT CompanyCode FROM [Dimension.Companies])
		
	UPDATE  [Import.BuyersVNDL] SET CompanyCode		= NULL WHERE LTRIM(RTRIM(CompanyCode))	= ''
	UPDATE  [Import.BuyersVNDL] SET BuyerCode		= NULL WHERE LTRIM(RTRIM(BuyerCode))	= ''
	UPDATE  [Import.BuyersVNDL] SET BuyerName		= NULL WHERE LTRIM(RTRIM(BuyerName))	= ''
	UPDATE  [Import.BuyersVNDL] SET BuyerName		= REPLACE(BuyerName,CHAR(32) + CHAR(32),CHAR(32))
	UPDATE  [Import.BuyersVNDL] SET BuyerAddress1	= NULL WHERE LTRIM(RTRIM(BuyerAddress1)) = '' OR 
															 LTRIM(RTRIM(BuyerAddress1)) = '-'
	UPDATE  [Import.BuyersVNDL] SET BuyerAddress2	= NULL WHERE LTRIM(RTRIM(BuyerAddress2)) = '' OR 
															 LTRIM(RTRIM(BuyerAddress2)) = '-'
	UPDATE  [Import.BuyersVNDL] SET BuyerAddress3	= NULL WHERE LTRIM(RTRIM(BuyerAddress3)) = '' OR 
															 LTRIM(RTRIM(BuyerAddress3)) = '-'
	UPDATE  [Import.BuyersVNDL] SET BuyerAddress4	= NULL WHERE LTRIM(RTRIM(BuyerAddress4)) = '' OR 
															 LTRIM(RTRIM(BuyerAddress4)) = '-'
	UPDATE  [Import.BuyersVNDL] SET BuyerAddress5	= NULL WHERE LTRIM(RTRIM(BuyerAddress5)) = '' OR 
															 LTRIM(RTRIM(BuyerAddress5)) = '-'
	UPDATE  [Import.BuyersVNDL] SET BuyerAddress6	= NULL WHERE LTRIM(RTRIM(BuyerAddress6)) = '' OR 
															 LTRIM(RTRIM(BuyerAddress6)) = '-'
	UPDATE  [Import.BuyersVNDL] SET BuyerTaxCode	= NULL WHERE LTRIM(RTRIM(BuyerTaxCode))	 = '' OR 
															 LTRIM(RTRIM(BuyerTaxCode))	 = '-'
	UPDATE  [Import.BuyersVNDL] SET BuyerFiscalCode = NULL WHERE LTRIM(RTRIM(BuyerFiscalCode)) = '' OR 
															 LTRIM(RTRIM(BuyerFiscalCode)) = '-'
	UPDATE  [Import.BuyersVNDL] SET BuyerEmail		= NULL WHERE LTRIM(RTRIM(BuyerEmail)) = '' OR 
																LTRIM(RTRIM(BuyerEmail)) = '-'
																		
	UPDATE [Import.BuyersVNDL] SET BuyerEmail = REPLACE(BuyerEmail,',','-')
	UPDATE [Import.BuyersVNDL] SET BuyerEmail = REPLACE(BuyerEmail,';','-')		
	
	
	
	INSERT INTO [Staging.Buyers] 
		(
			CompanyCode		, BuyerCode		, BuyerName			, BuyerTaxCode	, BuyerFiscalCode	, 
			BuyerAddress1	, BuyerAddress2 , BuyerAddress3		, BuyerAddress4 , BuyerAddress5		, BuyerAddress6,
			ContactEmail	, ShortName		, ManufacturerCode	, ContactName
		)
			
			
	SELECT 
		CompanyCode , BuyerCode , BuyerName , BuyerTaxCode , BuyerFiscalCode , 
		BuyerAddress1 , BuyerAddress2 , BuyerAddress3 , BuyerAddress4 , BuyerAddress5 , BuyerAddress6,
		LTRIM(RTRIM(SUBSTRING(BuyerEmail,1,80))),
		LTRIM(RTRIM(SUBSTRING(BuyerEmail,82,6))),
		LTRIM(RTRIM(SUBSTRING(BuyerEmail,89,3))),
		LTRIM(RTRIM(SUBSTRING(BuyerEmail,93,LEN(BuyerEmail))))
	FROM [Import.BuyersVNDL]
	GROUP BY 
		CompanyCode , BuyerCode , BuyerName , BuyerTaxCode , BuyerFiscalCode , 
		BuyerAddress1 , BuyerAddress2 , BuyerAddress3 , BuyerAddress4 , BuyerAddress5 , BuyerAddress6,
		SUBSTRING(BuyerEmail,1,80) ,
		SUBSTRING(BuyerEmail,82,6),
		SUBSTRING(BuyerEmail,89,3),
		SUBSTRING(BuyerEmail,93,LEN(BuyerEmail))
		
	
	--2.1 Fisx Errors
	--------------------------------------------------------------------------------------------
		UPDATE [Staging.Buyers] SET 
			ManufacturerCode	= LTRIM(RTRIM(ManufacturerCode)),
			ShortName			= LTRIM(RTRIM(ShortName)),
			ContactEmail		= LTRIM(RTRIM(ContactEmail)),
			ContactName			= LTRIM(RTRIM(ContactName))
			
			
		UPDATE [Staging.Buyers] SET ContactName = REPLACE(ContactName,'-','')
		
		
		UPDATE  [Staging.Buyers] SET ManufacturerCode	= NULL WHERE LTRIM(RTRIM(ManufacturerCode)) = '' OR 
																	 LTRIM(RTRIM(ManufacturerCode)) = '-'
		UPDATE  [Staging.Buyers] SET ShortName			= NULL WHERE LTRIM(RTRIM(ShortName)) = '' OR 
																	 LTRIM(RTRIM(ShortName)) = '-'
		UPDATE  [Staging.Buyers] SET ContactEmail		= NULL WHERE LTRIM(RTRIM(ContactEmail)) = '' OR 
																	 LTRIM(RTRIM(ContactEmail)) = '-'
		UPDATE  [Staging.Buyers] SET ContactName		= NULL WHERE LTRIM(RTRIM(ContactName))	 = '' OR 
																	 LTRIM(RTRIM(ContactName))	 = '-'
																	 
																	 
		UPDATE [Staging.Buyers] SET ContactPhone= NULL WHERE ContactPhone LIKE  '%0000000000%'
		UPDATE [Staging.Buyers] SET ContactEmail= LOWER(ContactEmail)
		UPDATE [Staging.Buyers] SET ContactEmail= NULL WHERE ContactEmail LIKE 'www.%'
		UPDATE [Staging.Buyers] SET ContactName	= NULL WHERE ContactName LIKE 'XX%'
		UPDATE [Staging.Buyers] SET ContactName	= NULL WHERE LTRIM(RTRIM(ContactName)) = '`'
		UPDATE [Staging.Buyers] SET ContactName	= NULL WHERE LTRIM(RTRIM(ContactName)) = ';'
		UPDATE [Staging.Buyers] SET ContactPhone= NULL WHERE LTRIM(RTRIM(ContactPhone)) = ';'
		UPDATE [Staging.Buyers] SET ContactFax	= NULL WHERE LTRIM(RTRIM(ContactFax)) = ';'
		UPDATE [Staging.Buyers] SET ContactEmail= NULL WHERE ContactEmail NOT LIKE '%@%'
		
		UPDATE [Staging.Buyers] SET BuyerName = REPLACE(BuyerName,'#','Ñ')WHERE BuyerName like '%#%' and 
									CompanyCode = 'SP'
		
		UPDATE [Staging.Buyers] SET BuyerAddress1 = REPLACE(BuyerAddress1,'#','Ñ') 
			WHERE BuyerAddress1 like '%#%' and CompanyCode = 'SP'
			
		UPDATE [Staging.Buyers] SET BuyerAddress2 = REPLACE(BuyerAddress2,'#','Ñ') 
			WHERE BuyerAddress2 like '%#%' and CompanyCode = 'SP'
			
		UPDATE [Staging.Buyers] SET BuyerAddress3 = REPLACE(BuyerAddress3,'#','Ñ') 
			WHERE BuyerAddress3 like '%#%' and CompanyCode = 'SP'
			
		UPDATE [Staging.Buyers] SET BuyerAddress4 = REPLACE(BuyerAddress4,'#','Ñ') 
			WHERE BuyerAddress4 like '%#%' and CompanyCode = 'SP'
			
		UPDATE [Staging.Buyers] SET BuyerAddress5 = REPLACE(BuyerAddress5,'#','Ñ') 
			WHERE BuyerAddress5 like '%#%' and CompanyCode = 'SP'
			
		UPDATE [Staging.Buyers] SET BuyerAddress6 = REPLACE(BuyerAddress6,'#','Ñ') 
			WHERE BuyerAddress6 like '%#%' and CompanyCode = 'SP'
			
		UPDATE [Staging.Buyers] SET ContactName = REPLACE(ContactName,'#','Ñ') 
			WHERE ContactName like '%#%' and CompanyCode = 'SP'
		
		
		--2.2 Add Log id
		--------------------------------------------------------------------------------------------
		DECLARE @NEWLOGID INT	
		INSERT INTO [Application.FileLog] 
		VALUES (@FileId , GETDATE())
		SET @NEWLOGID = @@IDENTITY
		
		UPDATE [Staging.Buyers] SET LogId = @NEWLOGID
	
END