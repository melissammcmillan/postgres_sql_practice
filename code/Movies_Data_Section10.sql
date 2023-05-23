-- Practicing String Functions- Section 10

-- Remember we already learned the CONCAT function that concatenated strings together

-- First we will learn how to clone or copy a database so we don't mess up the original

-- I am now using my movie_data_clone database. Note that in order to use the old
-- database as a template, I had to right click on the name of the old database and
-- select "Disconnect from Database". Otherwise PGAdmin wouldn't let me use it as a
-- template.

-- UPPER AND LOWER FUNCTIONS

/*
SELECT UPPER('string');

SELECT LOWER('string');

SELECT UPPER(column_name) FROM table_name;

SELECT LOWER(column_name) FROM table_name;
*/


SELECT UPPER('stop shouting');

-- use our movies database
SELECT first_name, UPPER(last_name) FROM actors;

-- set a column name alias
SELECT first_name, UPPER(last_name) AS last_name FROM actors;
-- this doesn't change the table, it just changes the data in the results

-- now use the LOWER function
SELECT LOWER('my STRING');

-- use our movies table
SELECT LOWER(movie_name) FROM movies;

-- INITCAP STRING FUNCTION
-- INITCAP is short for 'Initial Capitalization'
/*
SELECT INITCAP('example string');

SELECT INITCAP(column_name) FROM table_name;
*/

-- see how the capitalization changes
SELECT INITCAP('examPLE sTring');

-- apply to movie_name column
SELECT movie_name FROM movies;
-- Notice that the column already has some capitalization, but City of God has a lowercase 'of'
SELECT INITCAP(movie_name) FROM movies;
-- And now we can see the middle word of the movie titles is not capitalized in the movie names

-- LEFT and RIGHT string functions
-- This is not related to joins at all. These functions only apply to strings and column names.

/*
-- this takes a string and returns a number of characters in that string, starting from the left side of the string.
SELECT LEFT('string', int);

SELECT LEFT(column_name, int) FROM table_name;

SELECT RIGHT('string', int);

SELECT RIGHT(column_name, int) FROM table_name;
*/

-- an example- return 'str'
SELECT LEFT('string', 3);

-- can use negative numbers
SELECT LEFT('string', -4);
-- this returned 'st', so it returned the remaining numbers after counting 4 from the right
-- the counting starts at 1 here, not 0 like in python- remember that
-- so this is a way of popping off the last X number of letters or characters of a string

-- use it on a column
SELECT LEFT(movie_name, 5) FROM movies;
-- returns the first 5 characters of the movie names, including the spaces in the name

-- use the right function now
SELECT RIGHT('example', 5);

-- try with negative int
SELECT RIGHT('example', -3);

-- try on actors table
SELECT RIGHT(first_name, 2) FROM actors;

-- REVERSE FUNCTION
/*
SELECT REVERSE('string');

SELECT REVERSE(column_name) FROM table_name;
*/

-- try it on a string
SELECT REVERSE('reverse');

-- apply it on our movie table
SELECT REVERSE(movie_name) FROM movies;

-- Challenge
-- Select the directors first and last names and movie names in upper case.
SELECT * FROM directors;
SELECT * FROM movies;

SELECT UPPER(d.first_name), UPPER(d.last_name), UPPER(mo.movie_name) FROM directors d
JOIN movies mo ON d.director_id = mo.director_id;

-- Select the first and last names, in initial capitalization format, of all
-- the actors who have starred in a Chinese or Korean movie.
SELECT * FROM actors;
SELECT * FROM movies;
SELECT * FROM movies_actors;

SELECT INITCAP(ac.first_name) AS first_name, INITCAP(ac.last_name) AS last_name, mo.movie_lan FROM actors ac
JOIN movies_actors ma ON ac.actor_id = ma.actor_id
JOIN movies mo ON ma.movie_id = mo.movie_id
WHERE mo.movie_lan = 'Chinese' OR mo.movie_lan = 'Korean';

-- Can also use IN in the WHERE clause
SELECT INITCAP(ac.first_name) AS first_name, INITCAP(ac.last_name) AS last_name, mo.movie_lan FROM actors ac
JOIN movies_actors ma ON ac.actor_id = ma.actor_id
JOIN movies mo ON ma.movie_id = mo.movie_id
WHERE mo.movie_lan IN ('Chinese','Korean');

-- If we don't want any duplicate actors, we need to use DISTINCT
SELECT DISTINCT INITCAP(ac.first_name) AS first_name, INITCAP(ac.last_name) AS last_name, mo.movie_lan FROM actors ac
JOIN movies_actors ma ON ac.actor_id = ma.actor_id
JOIN movies mo ON ma.movie_id = mo.movie_id
WHERE mo.movie_lan IN ('Chinese','Korean');


-- Retrieve the reversed first and last names of each director and the first three characters of their nationality
SELECT * FROM directors;

SELECT REVERSE(first_name) AS rev_first_name, REVERSE(last_name) AS rev_last_name, LEFT(nationality, 3) FROM directors;

-- Retrieve the initials of each director and display it in one column named 'initials'
SELECT * FROM directors;

SELECT CONCAT(LEFT(first_name,1), LEFT(last_name,1)) AS initials FROM directors;

-- Could also separate the initials with a separator
SELECT CONCAT_WS('.', LEFT(first_name,1), LEFT(last_name,1)) AS initials FROM directors;

-- SUBSTRING FUNCTION
-- This selects a section of a string, depending on the from and count arguments

/*
SELECT SUBSTRING('string', from, count);

SELECT SUBSTRING(column_name, from, count) FROM table_name;
*/

SELECT SUBSTRING('long string', 2, 6);
-- returns 'ong st', so it started on the second character and returned 6 characters starting from 
-- the second character

-- can also use this on columns in a table
SELECT first_name, SUBSTRING(first_name, 3, 4) FROM actors;

-- REPLACE FUNCTION

/*
SELECT REPLACE('source_string', 'old_string', 'new_string');

SELECT REPLACE(column_name, 'old_string', 'new_string') FROM table_name;

UPDATE table_name
SET column_name = REPLACE(column_name, 'old_string', 'new_string')
WHERE column_name = 'value';
*/

-- example
SELECT REPLACE('a cat plays with another cat', 'cat', 'dog');

-- try on a database
SELECT * FROM actors;

-- replace the F or M in gender column with full strings spelled out
SELECT first_name, last_name, REPLACE(gender, 'M', 'Male') FROM actors;
-- This replaces 'Male' for each 'M' in the gender column
-- but this still doesn't change the actors table, only the output

-- To change the actual table, use the UPDATE statement
SELECT * FROM directors;
-- Change American nationality to read 'USA' instead
UPDATE directors
SET nationality = REPLACE(nationality, 'American', 'USA')
WHERE nationality = 'American';

SELECT * FROM directors;

-- Didnt actually need to use a replace for that one, could have just done this:
UPDATE directors
SET nationality = 'USA'
WHERE nationality = 'American';
-- But sometimes we actually do need to use a REPLACE() function, here is an exmaple
-- If we wanted to change the 'British' nationality to 'English' AND use a shortcut,
-- we could do this:
UPDATE directors
SET nationality = REPLACE(nationality, 'Brit', 'Engl')
WHERE nationality = 'British';
-- So this would just take advantage of the 'ish' parts of the British and English strings

SELECT * FROM directors;

-- SPLIT_PART FUNCTION
-- Takes a string and two other parameters and splits a string according to the delimiter
/*
SELECT SPLIT_PART('string', 'delimiter', field_number);

SELECT SPLIT_PART(column_name, 'delimiter', field_number) FROM table_name;
*/

-- split apart an email to get the first and last name of the customer
SELECT SPLIT_PART('first_name.last_name@gmail.com', '@', 1);
-- this returns the first_name.last_name part of the split string
-- if we change the field_number to 2, we get the gmail.com part of the split string
SELECT SPLIT_PART('first_name.last_name@gmail.com', '@', 2);

-- try splitting on the . and see what we get
SELECT SPLIT_PART('first_name.last_name@gmail.com', '.', 3);

-- use on our movie database
-- try to get the first work of each movie name
SELECT movie_name, SPLIT_PART(movie_name, ' ', 1) AS first_word FROM movies;

-- Using Casting to apply String Functions to Non String Data Types
-- Can apply string functions to non data types using casting
-- It converts one datatype to another
-- The cast operator is the double ::
/*
SELECT column_name::DATATYPE FROM table_name;
*/

SELECT * FROM directors;
-- cannot currently use string operators on the date_of_birth column because
-- it is a date column

-- but we can cast the date_of_birth column to a string and then perform string operations
SELECT date_of_birth::TEXT FROM directors;

-- Use the SPLIT_PART function on DOB column so that we only return the year
SELECT SPLIT_PART(date_of_birth::TEXT, '-', 1) FROM directors;

-- can also cast as VARCHAR
SELECT SPLIT_PART(date_of_birth::VARCHAR, '-', 1) FROM directors;

-- can also cast as VARCHAR with set amount of characters
SELECT SPLIT_PART(date_of_birth::VARCHAR(3), '-', 1) FROM directors;

-- We can't cast a DOB column to an integer
-- can also cast as VARCHAR
SELECT SPLIT_PART(date_of_birth::INT, '-', 1) FROM directors;
-- throws an error because there are dashes in the values

-- Challenge!
-- Use the substring function to retrieve the first 6 characters of each movie name
-- and the year they released

SELECT SUBSTRING(movie_name, 1, 6) AS movie_name, 
	SUBSTRING(release_date::TEXT, 1, 4) FROM movies;

-- Retrieve the first name initial and last name of every actor born in May
SELECT * FROM actors;

SELECT SUBSTRING(first_name, 1, 1), last_name, date_of_birth FROM actors
WHERE date_of_birth::TEXT ILIKE '%-05-%';

-- Can also do this with a split_part function for date of birth:
SELECT SUBSTRING(first_name, 1, 1) AS fn_initial, last_name, date_of_birth FROM actors
WHERE SPLIT_PART(date_of_birth::TEXT, '-', 2) = '05';

-- Replace the movie language for all English language movies, with age certificate 
-- rating 18, to 'Eng'.
SELECT * FROM movies;

SELECT REPLACE(movie_lan, 'English', 'Eng'), * FROM movies
WHERE age_certificate = '18';














