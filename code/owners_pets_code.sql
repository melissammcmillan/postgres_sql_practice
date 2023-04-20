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

-- challenge for Section 4 learnings

-- insert data into the owners table
-- we don't need to include the id column in the INSERT clause, but I did anyway
-- we don't need to include the id # in the VALUES, but I did anyway
SELECT * FROM owners;

INSERT INTO owners (id, first_name, last_name, city, state, email)
VALUES (1, 'Samuel', 'Smith', 'Boston', 'MA', 'samsmith@gmail.com'),
(2, 'Emma', 'Johnson', 'Seattle', 'WA', 'emjohnson@gmail.com'),
(3, 'John', 'Oliver', 'New York', 'NY', 'johnoliver@gmail.com'),
(4, 'Olivia', 'Brown', 'San Francisco', 'CA', 'oliviabrown@gmail.com'),
(5, 'Simon', 'Smith', 'Dallas', 'TX', 'sismith@gmail.com'),
(7, null, 'Maxwell', null, 'CA', 'lordmaxwell@gmail.com');

-- insert data into the pets table
SELECT * FROM pets;

INSERT INTO pets(id, species, full_name, age, owner_id)
VALUES (1, 'Dog', 'Rex', 6, 1),
(2, 'Rabbit', 'Fluffy', 2, 5),
(3, 'Cat', 'Tom', 8, 2),
(4, 'Mouse', 'Jerry', 2, 2),
(5, 'Dog', 'Biggles', 4, 1),
(6, 'Tortoise', 'Squirtle', 42, 3);

-- update the rabbit Fluffly's age to 3

UPDATE pets
SET age = 3
WHERE id = 2;

-- delete Mr Maxwell from the owners table

DELETE FROM owners
WHERE id = 7;








