
USE preblend;

/* create table that holds input csv file */
IF OBJECT_ID('dbo.table_in', 'U') IS NOT NULL
DROP TABLE dbo.table_in;

CREATE TABLE table_in(
time_of_day TIME,
rm_id VARCHAR(6),
rm_expiration_date DATE,
rm_batch_number VARCHAR(10),
operator_id VARCHAR(10),
weight_added FLOAT,
id INT PRIMARY KEY);

GO


/* list of csv file names to be opened */
/*
IF OBJECT_ID('dbo.csvfiles', 'U') IS NOT NULL
DROP TABLE dbo.csvfiles;

CREATE TABLE dbo.csvfiles(
	filenames varchar(255) NULL,
	processed char(1) NOT NULL,
	error varchar(max) NULL
)
GO

exec master..xp_cmdshell 'dir C:\Users\diana\Documents\test_folder /b /a-d'
select * from dbo.csvfiles
GO
*/

/* import csv raw files automatically */
IF OBJECT_ID('dbo.ImportTest', 'U') IS NOT NULL
DROP TABLE dbo.ImportTest;

CREATE TABLE dbo.ImportTest(
[column 0] varchar(50),
[column 1] varchar(50),
[column 2] varchar(50),
[column 3] varchar(50),
[column 4] varchar(50),
[column 5] varchar(50)
);

/* hard coding file name currently //TODO */
DECLARE @file_name varchar(500)
SET @file_name = '''C:\Users\diana\Documents\test_folder\63000318.CSV'''
DECLARE @sql varchar(500)
SET @sql = 'BULK INSERT dbo.ImportTest
FROM ' + @file_name + 
' WITH (FIELDTERMINATOR ='','', FIRSTROW = 1)'
print @sql
exec (@sql)
GO


/*translate input table and insert into output table*/
EXEC cursor_orig;
GO

/*generate output table as csv file*/
/*
insert into openrowset('PRODUCTION\SQLEXPRESS', 
    'Database=preblend;', 
    'SELECT * FROM dbo.table_in') select * from dbo.table_in
*/
declare @addr varchar(200);
set @addr = 'C:\Users\diana\Documents\out_test2.csv'

:!!sqlcmd -S PRODUCTION\SQLEXPRESS -d preblend -E -s, -W -w 65535 -Q "SET NOCOUNT on; SELECT * FROM dbo.table_in" -o "C:\Users\diana\Documents\out_test2.tmp"
:!! find /v "---" < "C:\Users\diana\Documents\out_test2.tmp" > "C:\Users\diana\Documents\out_test2.csv" & del "C:\Users\diana\Documents\out_test2.tmp"

