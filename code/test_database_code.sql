-- Database: test_database

-- DROP DATABASE IF EXISTS test_database;

CREATE DATABASE test_database
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
-- modifying tables and add a column

CREATE TABLE examples (
	
	example_id SERIAL PRIMARY KEY,
	first_name VARCHAR(30),
	last_name VARCHAR(30)
);

SELECT * FROM examples;

-- now to modify this table and add a new column
-- we have constraint on the email column we are adding
-- such that it has to be unique from the other entries 
-- in this column

ALTER TABLE examples
ADD COLUMN email VARCHAR(50) UNIQUE;

-- we can modify multiple columns in one SQL query

ALTER TABLE examples
ADD COLUMN nationality VARCHAR(30),
ADD COLUMN age INT NOT NULL;

-- modifying an existing column data type

/* 
ALTER TABLE tablename
ALTER COLUMN columnname TYPE new_data_type;
*/

-- we are going to change the nationality columns from 
-- VARCHAR(30) to a CHAR(3)

ALTER TABLE examples
ALTER COLUMN nationality TYPE CHAR(3);

-- We can alter multiple columns at once

ALTER TABLE examples
ALTER COLUMN last_name TYPE VARCHAR(50),
ALTER COLUMN email TYPE VARCHAR(80);

-- We can delete a table from a database
-- first we will create the table to delete

CREATE TABLE practice (
	
	id SERIAL PRIMARY KEY,
	product_name VARCHAR(50),		
	product_price NUMERIC(4, 2)

);

SELECT * FROM practice;

-- now to delete

DROP TABLE practice;

-- the error we get says relation practice does not exist
-- "relation" means table

-- Insert data into table
SELECT * FROM examples;

-- To insert data into a table, use
/*

INSERT INTO tablename (columnname1, columnname2, columnname3)
VALUES ('value1', 'value2', 'value3');

*/

-- now add data into examples table
-- exampled_id column doesn't need to be stated in the code
-- because it's a serial data type and will be filled in automatically
-- use single quotes or double quotes for strings

INSERT INTO examples(first_name, last_name, email, nationality, age)
VALUES ('David', 'Mitchell', 'dmitch@gmail.com', 'GBR', 43);

-- now we will update data in a table
/*

UPDATE tablename
SET columnname = 'newvalue'
WHERE primarykeycolumnname = 'value';

*/

-- change David Mitchells email address
-- best to use the primary key column name in the WHERE clause
-- so that the entire column doesn't get replaced with the SET clause

UPDATE examples
SET email = 'davidmitchell@gmail.com'
WHERE example_id = 1;

SELECT * FROM examples;

-- since we update the david mitchell row, it is now at the bottom of the table

-- to update multiple rows at once
-- this will replace all the USA entries in the nationality column to CAN(ada)

UPDATE examples
SET nationality = 'CAN'
WHERE nationality = 'USA';

-- we can also update multiple columns in a single row
-- we will update Jim Burr to be named James and fix his age from 54 to 55

UPDATE examples
SET first_name = 'James', age = 55
WHERE example_id = 5;

-- Deleting data from a table
/* 

DELETE FROM tablename
WHERE columnname = 'value';

*/

-- this will delete one row of data

DELETE FROM examples
WHERE example_id = 2;

SELECT * FROM examples;

-- if you wanted to delete all the British people from the table, use a WHERE clause
-- that the rows have in common

DELETE FROM examples
WHERE nationality = 'GBR';

-- if you want to delete all the data from a table at once,
-- don't use a WHERE clause

DELETE FROM examples; 



