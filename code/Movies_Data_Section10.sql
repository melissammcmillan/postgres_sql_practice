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











