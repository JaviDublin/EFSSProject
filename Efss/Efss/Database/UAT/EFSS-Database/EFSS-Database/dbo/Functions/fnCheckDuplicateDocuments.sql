-- =============================================
-- Author:		Javier
-- Create date: June 2011
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION fnCheckDuplicateDocuments
(	
	@companyId		INT,
	@vehicleId		INT,
	@documentTypeId INT,
	@amount			VARCHAR(50)
	
)
RETURNS @TABLEDOCUMENTS TABLE 
	(DocItemId INT , CompanyId INT , ItemId INT , DescriptionId INT , Value VARCHAR(50),
	 DocumentId INT , DocumentTypeId INT , BuyerId INT)
AS
BEGIN
	
INSERT INTO @TABLEDOCUMENTS
SELECT [Fact.DocumentItems].DocItemId	,
[Fact.DocumentItems].CompanyId			,
[Fact.Items].ItemId						,
[Fact.Items].DescriptionId				,
CONVERT(VARCHAR,[Fact.Items].Value)		,
[Fact.Documents].DocumentId				,
[Fact.Documents].DocumentTypeId			,
[Fact.Documents].BuyerId
FROM [Fact.DocumentItems]
INNER JOIN [Fact.Items]		ON [Fact.DocumentItems].ItemId		= [Fact.Items].ItemId
INNER JOIN [Fact.Documents]	ON [Fact.DocumentItems].DocumentId	= [Fact.Documents].DocumentId
WHERE 
		[Fact.DocumentItems].CompanyId	= @companyId
AND		[Fact.Documents].DocumentTypeId = @documentTypeId
AND		[Fact.Items].DescriptionId		= @vehicleId
AND CONVERT(VARCHAR,[Fact.Items].Value) = @amount
GROUP BY [Fact.DocumentItems].DocItemId	,
[Fact.DocumentItems].CompanyId			,
[Fact.Items].ItemId						,
[Fact.Items].DescriptionId				,
[Fact.Items].Value						,
[Fact.Documents].DocumentId				,
[Fact.Documents].DocumentTypeId			,
[Fact.Documents].BuyerId
   
   

	-- return all controls associated with user in group
	RETURN
END