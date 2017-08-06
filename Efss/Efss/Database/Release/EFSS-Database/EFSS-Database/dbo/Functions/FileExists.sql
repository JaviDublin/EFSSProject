
CREATE FUNCTION [dbo].[FileExists](@File varchar(255)) RETURNS BIT AS
BEGIN
DECLARE @i int
EXEC master..xp_fileexist @File, @i out
RETURN @i
END