-- =============================================
-- Author:		Javier
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spReportsTaxFileSpainPricesById] 
	@rowId int
AS
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT
		COUNT(u.RowId) OVER() AS 'Count' ,
		u.RowId , u.Serial , CONVERT(varchar,u.CO2) as "CO2" , u.ITVSerial , 
		u.TaxCode , CONVERT(varchar,u.TaxPCT) as "TaxPCT" ,
		 vh.Unit , u.VehicleCode , sl.Plate
	FROM [Fact.FleetSP] u
	INNER JOIN 
		[Fact.Vehicles] AS vh ON u.VehicleId = vh.VehicleId
	INNER JOIN	
		[Archive.Sales] AS sl ON u.VehicleId = sl.VehicleId
	WHERE 
		u.RowId = @rowId
	
	GROUP BY 
		u.RowId , u.Serial , u.CO2 , u.ITVSerial , u.TaxCode , u.TaxPCT ,
		vh.Unit ,  u.VehicleCode , sl.Plate

   
END