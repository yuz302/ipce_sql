CREATE database preblend;
use preblend;
create table raw_materials(
raw_material char(6) not null,
rm_batch_number char(10) not null,
rm_expiration_date date not null,
weight_added float unsigned not null,
fg_name char(6) not null,
fg_batch_number char(8) not null,
date_created date not null,
rm_id int unsigned not null auto_increment primary key);
