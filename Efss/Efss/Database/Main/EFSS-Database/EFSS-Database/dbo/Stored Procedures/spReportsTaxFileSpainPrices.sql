-- =============================================
-- Author:		Javier
-- Create date: August 2009
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spReportsTaxFileSpainPrices]
		@sortExpression		VARCHAR(50)	= NULL,
		@maximumRows		INT			= NULL,
		@startRowIndex		INT			= NULL,
		@plate				VARCHAR(20) = NULL
AS
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT t.[count] as 'Count' , t.RowId , t.Serial ,
	CONVERT(varchar,t.CO2) as "CO2" , t.ITVSerial , t.TaxCode , 
	CONVERT(varchar,t.TaxPCT) as "TaxPCT" , 
	t.Unit , t.VehicleCode , t.Plate
	FROM
	(
	select 
	COUNT(u.RowId) OVER() AS 'Count' ,
	ROW_NUMBER() OVER 
	(ORDER BY
		CASE WHEN @sortExpression = 'Serial' THEN u.Serial END ASC,
		CASE WHEN @sortExpression = 'Serial DESC' THEN u.Serial END DESC,
		CASE WHEN @sortExpression = 'CO2' THEN u.CO2 END ASC,
		CASE WHEN @sortExpression = 'CO2 DESC' THEN u.CO2 END DESC,
		CASE WHEN @sortExpression = 'ITVSerial' THEN u.ITVSerial END ASC,
		CASE WHEN @sortExpression = 'ITVSerial DESC' THEN u.ITVSerial END DESC,
		CASE WHEN @sortExpression = 'TaxCode' THEN u.TaxCode END ASC,
		CASE WHEN @sortExpression = 'TaxCode DESC' THEN u.TaxCode END DESC,
		CASE WHEN @sortExpression = 'TaxPCT' THEN u.TaxPCT END ASC,
		CASE WHEN @sortExpression = 'TaxPCT DESC' THEN u.TaxPCT END DESC,
		CASE WHEN @sortExpression = 'Unit' THEN vh.Unit END ASC,
		CASE WHEN @sortExpression = 'Unit DESC' THEN vh.Unit END DESC,
		CASE WHEN @sortExpression = 'VehicleCode' THEN u.VehicleCode END ASC,
		CASE WHEN @sortExpression = 'VehicleCode DESC' THEN u.VehicleCode END DESC,
		CASE WHEN @sortExpression = 'Plate' THEN sl.Plate END ASC,
		CASE WHEN @sortExpression = 'Plate DESC' THEN sl.Plate END DESC

	) AS ROW,
	u.RowId , u.Serial ,u.CO2 , u.ITVSerial , u.TaxCode , u.TaxPCT ,
	vh.Unit , u.VehicleCode , sl.Plate
	from [Fact.FleetSP] u
	INNER JOIN 
		[Fact.Vehicles] AS vh ON u.VehicleId = vh.VehicleId
	INNER JOIN	
		[Archive.Sales] AS sl ON u.VehicleId = sl.VehicleId
	where
		((@plate IS NULL) OR (sl.Plate like '%' + @plate + '%'))
	group by 
	u.RowId , u.Serial , u.CO2 , u.ITVSerial , u.TaxCode , u.TaxPCT ,
	vh.Unit , u.VehicleCode , sl.Plate
	) as t
	WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)
   
END