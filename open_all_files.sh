#!/bin/bash
for f in C:/Users/dzhou/Desktop/5*.csv
do
	mysql -e "LOAD DATA INFILE" '"$f"' into table 
