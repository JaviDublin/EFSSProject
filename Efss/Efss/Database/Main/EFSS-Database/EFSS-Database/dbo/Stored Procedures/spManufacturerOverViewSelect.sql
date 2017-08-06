-- =============================================
-- Author:		Javier
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spManufacturerOverViewSelect]
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
	t.[count] as 'Count', t.ManufacturerId, t.ManufacturerName,t.ModelsCount,t.IsBE, 
	t.IsFR,t.IsGE,t.IsIT,t.IsLU,t.IsNE,t.IsSP,t.IsSZ,t.IsUK
	FROM
	(
	SELECT 
	COUNT(u.ManufacturerId) OVER() AS 'Count',
	ROW_NUMBER() OVER
	(ORDER BY
		CASE WHEN @sortExpression = 'ManufacturerName' THEN u.ManufacturerName END ASC,
		CASE WHEN @sortExpression = 'ManufacturerName DESC' THEN u.ManufacturerName END DESC,
		CASE WHEN @sortExpression = 'ModelsCount' THEN u.ModelsCount END ASC,
		CASE WHEN @sortExpression = 'ModelsCount DESC' THEN u.ModelsCount END DESC,
		CASE WHEN @sortExpression = 'IsBE' THEN u.IsBE END ASC,
		CASE WHEN @sortExpression = 'IsBE DESC' THEN u.IsBE END DESC,
		CASE WHEN @sortExpression = 'IsFR' THEN u.IsFR END ASC,
		CASE WHEN @sortExpression = 'IsFR DESC' THEN u.IsFR END DESC,
		CASE WHEN @sortExpression = 'IsGE' THEN u.IsGE END ASC,
		CASE WHEN @sortExpression = 'IsGE DESC' THEN u.IsGE END DESC,
		CASE WHEN @sortExpression = 'IsIT' THEN u.IsIT END ASC,
		CASE WHEN @sortExpression = 'IsIT DESC' THEN u.IsIT END DESC,
		CASE WHEN @sortExpression = 'IsLU' THEN u.IsLU END ASC,
		CASE WHEN @sortExpression = 'IsLU DESC' THEN u.IsLU END DESC,
		CASE WHEN @sortExpression = 'IsNE' THEN u.IsNE END ASC,
		CASE WHEN @sortExpression = 'IsNE DESC' THEN u.IsNE END DESC,
		CASE WHEN @sortExpression = 'IsSP' THEN u.IsSP END ASC,
		CASE WHEN @sortExpression = 'IsSP DESC' THEN u.IsSP END DESC,
		CASE WHEN @sortExpression = 'IsSZ' THEN u.IsSZ END ASC,
		CASE WHEN @sortExpression = 'IsSZ DESC' THEN u.IsSZ END DESC,
		CASE WHEN @sortExpression = 'IsUK' THEN u.IsUK END ASC,
		CASE WHEN @sortExpression = 'IsUK DESC' THEN u.IsUK END DESC
	) AS ROW,
	u.ManufacturerId , u.ManufacturerName , u.ModelsCount , u.IsBE , u.IsFR , u.IsGE,
	u.IsIT , u.IsLU , u.IsNE, u.IsSP , u.IsSZ , u.IsUK
	FROM ViewManufacturers u
	GROUP BY u.ManufacturerId , u.ManufacturerName , u.ModelsCount , u.IsBE , u.IsFR , u.IsGE,
	u.IsIT , u.IsLU , u.IsNE, u.IsSP , u.IsSZ , u.IsUK
	) AS t
	WHERE (t.ROW BETWEEN @startRowIndex AND @maximumRows)



   
END