-- =============================================
-- Author:		Javier
-- Create date: April 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spFleetOverViewSelectDay]
		@sortExpression		VARCHAR(50)=NULL,
		@maximumRows		INT=NULL,
		@startRowIndex		INT=NULL,
		@companyId			INT=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
	t.[count] as 'Count', t.VehicleId, t.Serial,t.Unit,t.Plate, 
	convert(varchar,t.Mileage) as 'Mileage', t.ModelDescription as 'Model', 
	t.ManufacturerName as 'Manufacturer', t.BuyerName, t.VehicleType, 
	convert(varchar(11),t.InServiceDate,103) as 'InServiceDate'
	FROM
	(
		SELECT COUNT(u.VehicleId) OVER() as 'Count' , 
		ROW_NUMBER() OVER 
			(ORDER BY
				CASE WHEN @sortExpression = 'Serial' THEN u.Serial END ASC,
				CASE WHEN @sortExpression = 'Serial DESC' THEN u.Serial END DESC,
				CASE WHEN @sortExpression = 'Unit' THEN u.Unit END ASC,
				CASE WHEN @sortExpression = 'Unit DESC' THEN u.Unit END DESC,
				CASE WHEN @sortExpression = 'Plate' THEN u.Plate END ASC,
				CASE WHEN @sortExpression = 'Plate DESC' THEN u.Plate END DESC,
				CASE WHEN @sortExpression = 'Mileage' THEN u.Mileage END ASC,
				CASE WHEN @sortExpression = 'Mileage DESC' THEN u.Mileage END DESC,
				CASE WHEN @sortExpression = 'Model' THEN d.ModelDescription END ASC,
				CASE WHEN @sortExpression = 'Model DESC' THEN d.ModelDescription END DESC,
				CASE WHEN @sortExpression = 'Manufacturer' THEN m.ManufacturerName END ASC,
				CASE WHEN @sortExpression = 'Manufacturer DESC' THEN m.ManufacturerName END DESC,
				CASE WHEN @sortExpression = 'BuyerName' THEN b.BuyerName END ASC,
				CASE WHEN @sortExpression = 'BuyerName DESC' THEN b.BuyerName END DESC,
				CASE WHEN @sortExpression = 'VehicleType' THEN u.VehicleType END ASC,
				CASE WHEN @sortExpression = 'VehicleType DESC' THEN u.VehicleType END DESC,
				CASE WHEN @sortExpression = 'InServiceDate' THEN u.InServiceDate END ASC,
				CASE WHEN @sortExpression = 'InServiceDate DESC' THEN u.InServiceDate END DESC
			) as ROW,
	u.VehicleId AS 'VehicleId', u.Serial,u.Unit, u.Plate, u.Mileage, d.ModelDescription, m.ManufacturerName ,
	b.BuyerName ,u.VehicleType , u.InServiceDate
	FROM [Staging.ActiveFleetDay] u
	LEFT JOIN [Dimension.Manufacturer] m ON u.ManufacturerId = m.ManufacturerId
	LEFT JOIN [Dimension.Buyers] b on u.BuyerId = b.BuyerId
	LEFT JOIN [Dimension.ModelDetails] d on u.ModelDetailid = d.ModelDetailId
	--WHERE u.CompanyId = @companyId
	GROUP BY 
	u.VehicleId , u.Serial,u.Unit, u.Plate, u.Mileage, d.ModelDescription, m.ManufacturerName ,
	b.BuyerName ,u.VehicleType , u.InServiceDate
	) AS t
	WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)
    
END