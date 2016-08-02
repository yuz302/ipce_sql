/* function to get rid of the O in expiration date, keep only numeric characters*/
ALTER FUNCTION dbo.removeNonNumericChars(@temp varchar(50)) returns varchar(50)
as
begin

	declare @keepvalues as varchar(50)
	set @keepvalues = '%[^0-9/.]%'

	while PATINDEX(@keepvalues, @temp) > 0   -- find pattern index
		begin
			set @temp = stuff(@temp, patindex(@keepvalues, @temp), 1, '')  -- find and replace
		end
	return @temp
end

GO