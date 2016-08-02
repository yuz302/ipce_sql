/* parse flat table on a row by row basis using cursor */

ALTER PROCEDURE dbo.cursor_orig 
as
begin
	-- declare local variables
	declare 
		@date_in_seconds int,
		@machine_name varchar(50),
		@fg_batch_number varchar(10),
		@fg_id varchar(6),
		@date_create_file date,
		@time_of_day int,
		@time_of_day_1 time,
		@operator_id varchar(10),
		@rm_id varchar(6),
		@rm_expiration_date varchar(20),
		@rm_batch_number varchar(10),
		@weight_added varchar(20),
		@counter int = 0;

	PRINT 'start parsing!'

	-- declare cursor object
	declare curs1 cursor
	for
	select
		[column 0], [column 1],[column 2],[column 3],[column 4],[column 5]
	from 
		dbo.ImportTest

	open curs1
	
	-- parse the first row
	fetch next from curs1 into @fg_batch_number, @fg_id, @machine_name, @date_in_seconds, @rm_batch_number, @weight_added
	set @date_create_file = CONVERT (datetime, @date_in_seconds /(24 * 3600) + 35429)	
	-- date_in_seconds is # seconds since 1997/01/01
	-- date in sql is # days since 1900/01/01
	
	-- need to do something, right now just printing to console
	print @fg_batch_number
	print @fg_id
	print @machine_name
	print @date_create_file
	
	-- fetch the next row
	fetch next from curs1 into @time_of_day, @rm_id, @rm_expiration_date, @rm_batch_number, @operator_id, @weight_added

	-- parse row by row
	while (@@FETCH_STATUS = 0)
	begin
		set @counter = @counter +1

		-- update all expiration date object to contain only numeric characters	
		set @rm_expiration_date = dbo.removeNonNumericChars (@rm_expiration_date)
		set @weight_added = dbo.removeNonNumericChars (@weight_added)
		set @time_of_day_1 = CONVERT(TIME, DATEADD( SECOND, @time_of_day, 0))

		insert into dbo.table_in (time_of_day, rm_id, rm_expiration_date, rm_batch_number, operator_id, weight_added, id ) 
		values (@time_of_day_1, @rm_id, @rm_expiration_date, @rm_batch_number, @operator_id, @weight_added, @counter)
		fetch next from curs1 into @time_of_day, @rm_id, @rm_expiration_date, @rm_batch_number, @operator_id, @weight_added
	end

	close curs1
	deallocate curs1
	PRINT 'done parsing!'
end

GO