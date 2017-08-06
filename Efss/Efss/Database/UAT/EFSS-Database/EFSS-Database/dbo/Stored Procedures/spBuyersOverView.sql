-- =============================================
-- Author:		Javier
-- Create date: May 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBuyersOverView]
		@sortExpression		VARCHAR(50)=NULL,
		@maximumRows		INT=NULL,
		@startRowIndex		INT=NULL,
		@countryId			INT=NULL,
		@manufacturerCode	VARCHAR(50)=NULL,
		@buyerCode			VARCHAR(50) = NULL,
		@buyerName			VARCHAR(1000) = NULL
AS
BEGIN
	
	SET NOCOUNT ON;
	
	IF @buyerCode			= '0'   BEGIN SET @buyerCode = NULL END
	IF @manufacturerCode	= 'ALL' BEGIN SET @manufacturerCode = NULL END;

	
	WITH tb AS
	(
	
		select
			[Dimension.Buyers].BuyerId ,
			[Dimension.Buyers].CompanyCode,
			[Dimension.Buyers].BuyerCode ,
			[Dimension.Buyers].AreaCode ,
			[Dimension.Buyers].BuyerName,
			[Dimension.Manufacturer].ManufacturerName ,
			CONVERT(VARCHAR,COUNT([Archive.Sales].BuyerId)) as "TotalSales",
			CONVERT(VARCHAR(11),MAX([Archive.Sales].InvoiceDate),103) as "LastSaleDate",
			CONVERT(VARCHAR,CONVERT(MONEY,SUM([Archive.Sales].InvoiceTotal)),1) as "Total",
			[Dimension.BuyerTypes].BuyerType
		from [Dimension.Buyers]
		inner join [Dimension.ManufacturerVision] on
			[Dimension.Buyers].ManufacturerCode = [Dimension.ManufacturerVision].VisionCode
		inner join [Dimension.Manufacturer] on
			[Dimension.ManufacturerVision].ManufacturerId = [Dimension.Manufacturer].ManufacturerId
		left join [Archive.Sales] on 
			[Dimension.Buyers].BuyerId  = [Archive.Sales].BuyerId
		inner join [Dimension.BuyerTypes] on
			[Dimension.Buyers].BuyerTypeId = [Dimension.BuyerTypes].BuyerTypeId
		where 
			[Dimension.Buyers].CountryId = @countryId
		AND ((@manufacturerCode IS NULL) OR ([Dimension.Buyers].ManufacturerCode = @manufacturerCode))
		AND ((@buyerCode IS NULL) OR ([Dimension.Buyers].BuyerCode LIKE '%' + @buyerCode)) 
		AND ((@buyerName IS NULL) OR ([Dimension.Buyers].BuyerName LIKE '%' + @buyerName + '%')) 
		group by
			[Dimension.Buyers].BuyerId ,
			[Dimension.Buyers].CompanyCode,
			[Dimension.Buyers].BuyerCode ,
			[Dimension.Buyers].BuyerName, 
			[Dimension.Buyers].AreaCode ,
			[Dimension.Manufacturer].ManufacturerName ,
			[Dimension.BuyerTypes].BuyerType
	)

	 SELECT 
		t.[count] as 'Count', 
		t.BuyerId, t.CompanyCode, t.BuyerCode ,t.AreaCode, t.BuyerName, t.ManufacturerName, 
		t.TotalSales , t.LastSaleDate , t.Total , t.BuyerType
	FROM
	(
		SELECT 
			COUNT(u.BuyerId) OVER() as 'Count' , 
			ROW_NUMBER() OVER 
				(ORDER BY
					CASE WHEN @sortExpression = 'CompanyCode' THEN u.CompanyCode END ASC,
					CASE WHEN @sortExpression = 'CompanyCode DESC' THEN u.CompanyCode END DESC,
					CASE WHEN @sortExpression = 'BuyerCode' THEN u.BuyerCode END ASC,
					CASE WHEN @sortExpression = 'BuyerCode DESC' THEN u.BuyerCode END DESC,
					CASE WHEN @sortExpression = 'AreaCode' THEN u.AreaCode END ASC,
					CASE WHEN @sortExpression = 'AreaCode DESC' THEN u.AreaCode END DESC,
					CASE WHEN @sortExpression = 'BuyerName' THEN u.BuyerName END ASC,
					CASE WHEN @sortExpression = 'BuyerName DESC' THEN u.BuyerName END DESC,
					CASE WHEN @sortExpression = 'ManufacturerName' THEN u.ManufacturerName END ASC,
					CASE WHEN @sortExpression = 'ManufacturerName DESC' THEN u.ManufacturerName END DESC,
					CASE WHEN @sortExpression = 'TotalSales' THEN u.TotalSales END ASC,
					CASE WHEN @sortExpression = 'TotalSales DESC' THEN u.TotalSales END DESC,
					CASE WHEN @sortExpression = 'LastSaleDate' THEN u.LastSaleDate END ASC,
					CASE WHEN @sortExpression = 'LastSaleDate DESC' THEN u.LastSaleDate END DESC,
					CASE WHEN @sortExpression = 'Total' THEN u.Total END ASC,
					CASE WHEN @sortExpression = 'Total DESC' THEN u.Total END DESC,
					CASE WHEN @sortExpression = 'BuyerType' THEN u.BuyerType END ASC,
					CASE WHEN @sortExpression = 'BuyerType DESC' THEN u.BuyerType END DESC
				) as ROW,
		u.BuyerId AS 'BuyerId', u.CompanyCode,u.BuyerCode, u.AreaCode,  u.BuyerName, 
		u.ManufacturerName, u.TotalSales , u.LastSaleDate  , u.Total , u.BuyerType
		FROM tb u
	) AS t
	WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)
	
	
	

END