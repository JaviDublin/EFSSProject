-- =============================================
-- Author:		Javier
-- Create date: August 2011
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION GermanMoneyFormat
(
	@amt money
)
RETURNS varchar(50)
AS
BEGIN
	--declare @amt money
	--set @amt = 123456.789
	declare @amtvar varchar(50)
	set @amtvar = (select convert(varchar,@amt,1))
	--select @amtvar
	declare @amtlen int
	set @amtlen = (select len(@amtvar))
	--select @amtlen
	declare @amtint varchar(50)
	set @amtint = (select substring(@amtvar,0,@amtlen - 2))
	set @amtint = (select replace(@amtint,',','.'))
	--select @amtint
	declare @amtdec varchar(2)
	set @amtdec = (select substring(@amtvar,@amtlen - 1,2))
	--select @amtdec
	declare @total varchar(50)
	set @total = (select @amtint + ',' + @amtdec)
	--select @total
	

	-- Return the result of the function
	RETURN @total

END