
:!!sqlcmd -S PRODUCTION\SQLEXPRESS -d preblend -E -s, -W -w 65535 -Q "SET NOCOUNT on; SELECT * FROM dbo.table_in" -o "C:\Users\diana\Documents\out_test1.tmp"
:!! find /v "---" < "C:\Users\diana\Documents\out_test1.tmp" > "C:\Users\diana\Documents\out_test1.csv" & del "C:\Users\diana\Documents\out_test1.tmp"

