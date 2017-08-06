-- =============================================
-- Author:		Javier
-- Create date: July 2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDBImportDashboardReport]
	
AS
BEGIN
	
	SET NOCOUNT ON;
	
	TRUNCATE TABLE [Fact.DashboardReport]
	
	INSERT INTO [Fact.DashboardReport] 
	(CountryName , ManufacturerName , DueDtAge , RecvAmt , DocSubType ,LogId , ManufacturerId)

		SELECT UPPER(cm.GroupName) , mf.ManufacturerName , dh.DueDtAge , 
		SUM(dh.RecvAmt) as "RecvAmt" , rt.DocSubType , dh.LogId , dh.ManufacturerId
		FROM [Staging.Dashboard] dh
		INNER JOIN [Dimension.Manufacturer] AS mf ON
			dh.ManufacturerId = mf.ManufacturerId
		INNER JOIN [Dimension.ReceivableTypes] AS rt ON
			dh.RecvTypeId = rt.RecvTypeId
		INNER JOIN 
		(
			SELECT GroupId , GroupName 
			FROM [Dimension.Companies]
			GROUP BY GroupId , GroupName 
		)
		AS cm ON
			dh.GroupId = cm.GroupId
		WHERE rt.DocSubType = 'BUYBACK'
		GROUP BY cm.GroupName ,  mf.ManufacturerName , dh.DueDtAge , rt.DocSubType , 
		dh.LogId , dh.ManufacturerId

		UNION
		
		SELECT UPPER(cm.GroupName) , mf.ManufacturerName , dh.DueDtAge , 
		SUM(dh.RecvAmt) as "RecvAmt" , rt.DocSubType , dh.LogId , dh.ManufacturerId
		FROM [Staging.Dashboard] dh
		INNER JOIN [Dimension.Manufacturer] AS mf ON
			dh.ManufacturerId = mf.ManufacturerId
		INNER JOIN [Dimension.ReceivableTypes] AS rt ON
			dh.RecvTypeId = rt.RecvTypeId
		INNER JOIN 
		(
			SELECT GroupId , GroupName 
			FROM [Dimension.Companies]
			GROUP BY GroupId , GroupName 
		)
		AS cm ON
			dh.GroupId = cm.GroupId
		WHERE rt.DocSubType = 'VOLUME BONUS'
		GROUP BY cm.GroupName ,  mf.ManufacturerName , dh.DueDtAge , rt.DocSubType , 
		dh.LogId , dh.ManufacturerId

		UNION

		SELECT UPPER(cm.GroupName) , mf.ManufacturerName , dh.DueDtAge , 
		SUM(dh.RecvAmt) as "RecvAmt" , rt.DocSubType , dh.LogId , dh.ManufacturerId
		FROM [Staging.Dashboard] dh
		INNER JOIN [Dimension.Manufacturer] AS mf ON
			dh.ManufacturerId = mf.ManufacturerId
		INNER JOIN [Dimension.ReceivableTypes] AS rt ON
			dh.RecvTypeId = rt.RecvTypeId
		INNER JOIN 
		(
			SELECT GroupId , GroupName 
			FROM [Dimension.Companies]
			GROUP BY GroupId , GroupName 
		)
		AS cm ON
			dh.GroupId = cm.GroupId
		WHERE rt.DocSubType = 'NON RETURN BONUS'
		GROUP BY cm.GroupName ,  mf.ManufacturerName , dh.DueDtAge , rt.DocSubType , 
		dh.LogId , dh.ManufacturerId


		--SELECT cn.CountryName , mf.ManufacturerName , dh.DueDtAge , 
		--SUM(dh.RecvAmt) as "RecvAmt" , rt.DocSubType , dh.LogId , dh.ManufacturerId
		--FROM [Staging.Dashboard] dh
		--INNER JOIN [Dimension.Countries]  AS cn ON 
		--	dh.CountryId = cn.CountryId
		--INNER JOIN [Dimension.Manufacturer] AS mf ON
		--	dh.ManufacturerId = mf.ManufacturerId
		--INNER JOIN [Dimension.ReceivableTypes] AS rt ON
		--	dh.RecvTypeId = rt.RecvTypeId
		--WHERE rt.DocSubType = 'BUYBACK'
		--GROUP BY cn.CountryName ,  mf.ManufacturerName , dh.DueDtAge , rt.DocSubType , 
		--dh.LogId , dh.ManufacturerId

		--UNION

		--SELECT cn.CountryName , mf.ManufacturerName , dh.DueDtAge , 
		--SUM(dh.RecvAmt)as "RecvAmt" , rt.DocSubType , dh.LogId , dh.ManufacturerId
		--FROM [Staging.Dashboard] dh
		--INNER JOIN [Dimension.Countries]  AS cn ON 
		--	dh.CountryId = cn.CountryId
		--INNER JOIN [Dimension.Manufacturer] AS mf ON
		--	dh.ManufacturerId = mf.ManufacturerId
		--INNER JOIN [Dimension.ReceivableTypes] AS rt ON
		--	dh.RecvTypeId = rt.RecvTypeId
		--WHERE rt.DocSubType = 'VOLUME BONUS'
		--GROUP BY cn.CountryName ,  mf.ManufacturerName , dh.DueDtAge , rt.DocSubType , 
		--dh.LogId, dh.ManufacturerId

		--UNION

		--SELECT cn.CountryName , mf.ManufacturerName , dh.DueDtAge , 
		--SUM(dh.RecvAmt) as "RecvAmt", rt.DocSubType , dh.LogId, dh.ManufacturerId
		--FROM [Staging.Dashboard] dh
		--INNER JOIN [Dimension.Countries]  AS cn ON 
		--	dh.CountryId = cn.CountryId
		--INNER JOIN [Dimension.Manufacturer] AS mf ON
		--	dh.ManufacturerId = mf.ManufacturerId
		--INNER JOIN [Dimension.ReceivableTypes] AS rt ON
		--	dh.RecvTypeId = rt.RecvTypeId
		--WHERE rt.DocSubType = 'NON RETURN BONUS'
		--GROUP BY cn.CountryName ,  mf.ManufacturerName , dh.DueDtAge , rt.DocSubType, 
		--dh.LogId, dh.ManufacturerId
			
	UPDATE [Fact.DashboardReport] SET DateCreated = GETDATE()
	
	UPDATE [Fact.DashboardReport] SET GroupName = CountryName
		
		
	--UPDATE [Fact.DashboardReport] SET
	--	GroupName = GN.GroupName
	--FROM [Fact.DashboardReport]
	--INNER JOIN
	--(
	--	select top (9) [Fact.DashboardReport].CountryName , upper([Dimension.Companies].GroupName) AS "GroupName"
	--	from [Fact.DashboardReport]
	--	right outer join [Dimension.Countries] on [Fact.DashboardReport].CountryName = [Dimension.Countries].CountryName
	--	right outer join [Dimension.Companies] on [Dimension.Countries].CountryId	 = [Dimension.Companies].CountryId
	--	group by [Fact.DashboardReport].CountryName , [Dimension.Companies].GroupName
	--) AS GN
	--ON [Fact.DashboardReport].CountryName = GN.CountryName
  
END