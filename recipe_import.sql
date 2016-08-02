if object_id ('dbo.recipe_in', 'U') is not null
drop table dbo.recipe_in;

create table dbo.recipe_in(
	rm_id varchar(50),
	order_weight float
)
insert into dbo.recipe_in values('FL2734', 2600);
insert into dbo.recipe_in values('RE0066', 610);
insert into dbo.recipe_in values('AC4695', 30);
insert into dbo.recipe_in values('FL0154', 45);
select rm_id, order_weight from dbo.recipe_in where order_weight > 45.2;

:!!sqlcmd -S PRODUCTION\SQLEXPRESS -d preblend -E -s, -W -w 65535 -Q "SET NOCOUNT on; SELECT * FROM dbo.recipe_in where order_weight>45.2" -o "C:\Users\diana\Documents\recipe_test3.tmp"
:!! find /v "---" < "C:\Users\diana\Documents\recipe_test3.tmp" > "C:\Users\diana\Documents\LCB.csv" & del "C:\Users\diana\Documents\recipe_test3.tmp"

:!!sqlcmd -S PRODUCTION\SQLEXPRESS -d preblend -E -s, -W -w 65535 -Q "SET NOCOUNT on; SELECT * FROM dbo.recipe_in where order_weight<=45.2" -o "C:\Users\diana\Documents\recipe_test3.tmp"
:!! find /v "---" < "C:\Users\diana\Documents\recipe_test3.tmp" > "C:\Users\diana\Documents\SSB.csv" & del "C:\Users\diana\Documents\recipe_test3.tmp"
