CREATE database preblend;
use preblend;

# create table by hand
drop table if exists raw_materials;
create table raw_materials(
raw_material char(6) not null,
rm_batch_number char(10) not null,
rm_expiration_date date not null,
weight_added float unsigned not null,
fg_name char(6) not null,
fg_batch_number char(8) not null,
date_created date not null,
rm_id int unsigned not null auto_increment primary key);
describe raw_materials;
show tables;
insert into raw_materials value('FL3030', '2015000395', "2016-05-27", 2.0, 'MH0510', '55100034', "2016-01-01", null);
insert into raw_materials values('FL0154', '2016001187', '2017-04-01', 12, 'MH0510', '55100034', "2016-01-01", null), 
('AC4695', '2016001143', '2017-04-06', 12, 'MH0510', '55100034', "2016-01-01", null);
# select * from raw_materials where rm_expiration_date>"2017-01-01";
select * from raw_materials into outfile '/tmp/result.txt' fields terminated by ',' lines terminated by '\n' ;

# automatically import from csv files
drop table if exists table_in;
create table table_in(
timeordate varchar(5),
raw_material varchar(6),
rm_expiration_date varchar(20),
rm_batch_number char(10),
weight_added varchar(10),
rm_id int unsigned not null auto_increment primary key);
/*
delimiter $$
create procedure load_data()
begin
	declare v_max int unsigned default 2;
	declare v_counter int unsigned default 1;
    declare curr varchar(20);
	while v_counter < v_max do
		set @curr= concat("C:/Users/dzhou/Desktop/55100034in", v_counter, '.csv');
		load data local infile '@curr' into table preblend.table_in fields terminated by ',';
	
    end while;
end $$
delimiter ;

call load_data();
*/

load data local infile 'C:/Users/dzhou/Desktop/55100034in1.csv' into table preblend.table_in fields terminated by ',';
select * from table_in;



