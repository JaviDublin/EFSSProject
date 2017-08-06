-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spReportsDashboardSelect]
		@sortExpression		VARCHAR(50)=NULL,
		@maximumRows		INT=NULL,
		@startRowIndex		INT=NULL,
		@countryName		VARCHAR(50)=NULL,
		@docsubtype			VARCHAR(50)=NULL
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT 
	t.[count] as 'Count', t.ManufacturerId, t.ManufacturerName,
	convert(varchar,t.[Current]) as "Current" , 
	convert(varchar,t.Payment) as "Payment" ,
	convert(varchar,t.[0-7]) as "Age_0_7", 
	convert(varchar,t.[8-30]) as "Age_8_30" , 
	convert(varchar,t.[31-60]) as "Age_31_60",
	convert(varchar,t.[61-90]) as "Age_61_90",
	convert(varchar,t.[91-120]) as "Age_91_120" ,
	convert(varchar,t.[121-180]) as "Age_121_180",
	convert(varchar,t.[181-360]) as "Age_181_360",
	convert(varchar,t.[360+]) as "Age_360"  , 
	t.Notes , t.CNK
	
	FROM
	(
	SELECT 
	COUNT(ManufacturerId) OVER() AS 'Count',
	ROW_NUMBER() OVER
	(ORDER BY
		CASE WHEN @sortExpression = 'ManufacturerName' THEN ManufacturerName END ASC,
		CASE WHEN @sortExpression = 'ManufacturerName DESC' THEN ManufacturerName END DESC,
		CASE WHEN @sortExpression = 'Current' THEN ISNULL(P.[NOT DUE],0) END ASC,
		CASE WHEN @sortExpression = 'Current DESC' THEN ISNULL(P.[NOT DUE],0) END DESC,
		CASE WHEN @sortExpression = 'Payment' THEN ISNULL(P.[NO INV],0) END ASC,
		CASE WHEN @sortExpression = 'Payment DESC' THEN ISNULL(P.[NO INV],0) END DESC,
		CASE WHEN @sortExpression = 'Age_0_7' THEN ISNULL(P.[0-7],0) END ASC,
		CASE WHEN @sortExpression = 'Age_0_7 DESC' THEN ISNULL(P.[0-7],0) END DESC,
		CASE WHEN @sortExpression = 'Age_8_30' THEN ISNULL(P.[8-30],0) END ASC,
		CASE WHEN @sortExpression = 'Age_8_30 DESC' THEN ISNULL(P.[8-30],0) END DESC,
		CASE WHEN @sortExpression = 'Age_31_60' THEN ISNULL(P.[31-60],0) END ASC,
		CASE WHEN @sortExpression = 'Age_31_60 DESC' THEN ISNULL(P.[31-60],0) END DESC,
		CASE WHEN @sortExpression = 'Age_61_90' THEN ISNULL(P.[61-90],0) END ASC,
		CASE WHEN @sortExpression = 'Age_61_90 DESC' THEN ISNULL(P.[61-90],0) END DESC,
		CASE WHEN @sortExpression = 'Age_91_120' THEN ISNULL(P.[91-120],0) END ASC,
		CASE WHEN @sortExpression = 'Age_91_120 DESC' THEN ISNULL(P.[91-120],0) END DESC,
		CASE WHEN @sortExpression = 'Age_121_180' THEN ISNULL(P.[121-180],0) END ASC,
		CASE WHEN @sortExpression = 'Age_121_180 DESC' THEN ISNULL(P.[121-180],0) END DESC,
		CASE WHEN @sortExpression = 'Age_181_360' THEN ISNULL(P.[181-360],0) END ASC,
		CASE WHEN @sortExpression = 'Age_181_360 DESC' THEN ISNULL(P.[181-360],0) END DESC,
		CASE WHEN @sortExpression = 'Age_360' THEN ISNULL(P.[360+],0) END ASC,
		CASE WHEN @sortExpression = 'Age_360 DESC' THEN ISNULL(P.[360+],0) END DESC
	
	) AS ROW,
	ManufacturerId ,ManufacturerName , 
	ISNULL(P.[NOT DUE],0) as "Current" , ISNULL(P.[NO INV],0)  as "Payment",
	ISNULL(P.[0-7],0) as "0-7", ISNULL(P.[8-30],0) as "8-30", ISNULL(P.[31-60],0) as "31-60" , 
	ISNULL(P.[61-90],0) as "61-90", ISNULL(P.[91-120],0) as "91-120" , 
	ISNULL(P.[121-180],0) as "121-180", 
	ISNULL(P.[181-360],0) as "181-360",
	ISNULL(P.[360+],0) as "360+"  , Notes , CNK
	FROM 
	(
		SELECT ManufacturerId , CountryName , ManufacturerName , DueDtAge ,  RecvAmt , DocSubType , Notes , CNK
		FROM [Fact.DashboardReport]
		GROUP BY ManufacturerId , CountryName , ManufacturerName , DueDtAge ,  RecvAmt , DocSubType , Notes , CNK
	)
	S
	PIVOT
	(SUM(RecvAmt) FOR DueDtAge IN 
		([0-7],[8-30],[31-60],[61-90],[91-120],[121-180],[181-360],[360+],[NO INV],[NOT DUE])) AS P
	WHERE DocSubType = @docsubtype and CountryName = @countryName
	) AS t
	WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)
    
END