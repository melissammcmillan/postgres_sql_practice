-- Database: owners_pets

-- DROP DATABASE IF EXISTS owners_pets;

CREATE DATABASE owners_pets
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
-- create owners table as described in the video
-- next time, just use SERIAL instead of INT for the id column

CREATE TABLE owners (

	id INT PRIMARY KEY,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	city VARCHAR(30),
	state CHAR(2)
	
);

SELECT * FROM owners;

-- create the pets table as described in the video
-- next time, just use SERIAL instead of INT for the id column

CREATE TABLE pets (

	id INT PRIMARY KEY,
	species VARCHAR(30),
	full_name VARCHAR(30),
	age INT,
	owner_id INT REFERENCES owners(id)
);

SELECT * FROM pets;

-- Add an email column to owners table

ALTER TABLE owners
ADD COLUMN email VARCHAR(50) UNIQUE;

SELECT * FROM owners;

-- change the data type of the last_name column in the owners
-- table to VARCHAR(50)

ALTER TABLE owners
ALTER COLUMN last_name TYPE VARCHAR(50);

SELECT * FROM owners;













