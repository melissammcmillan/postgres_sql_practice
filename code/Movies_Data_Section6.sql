-- Section 6: Aggregate Functions and Grouping Data

-- What are aggregate functions? They perform a calculation on a column
-- and return just one value
-- Examples are COUTN, SUM, MIN, MAX, and AVG

-- Aggregate function COUNT
/*
SELECT COUNT(columnname) FROM tablename;
*/

SELECT * FROM movie_revenues;

-- this counts all the rows in a table- there are 53
SELECT COUNT(*) FROM movie_revenues;

-- this counts all the rows in a column, minus the NULLS
SELECT COUNT(international_takings) FROM movie_revenues;

-- use a WHERE clause
SELECT COUNT(*) FROM movies
WHERE movie_lan = 'English';

-- Aggregate function SUM
SELECT SUM(domestic_takings) FROM movie_revenues;

-- now use a WHERE clause
SELECT SUM(domestic_takings) FROM movie_revenues
WHERE domestic_takings > 100.0;

SELECT SUM(movie_length) FROM movies
WHERE movie_lan = 'Chinese';

-- can't use SUM on dates or strings, only on number data types

-- Aggregate Functions Min and Max

-- get the longest movie from the table
SELECT MAX(movie_length) FROM movies;

SELECT MIN(movie_length) FROM movies;

SELECT MIN(movie_length) FROM movies
WHERE movie_lan = 'Japanese';

-- now let's try these on other data types
SELECT MAX(release_date) FROM movies;
-- it works! this is the newest movie in the table

SELECT MIN(release_date) FROM movies;
-- this is the oldest movie

-- this returns alphabetically the last movie if used on a VARCHAR column
SELECT MAX(movie_name) FROM movies;

SELECT MIN(movie_name) FROM movies;

-- Average aggregate function
-- takes the average of a column

-- movie_length is a numeric column
SELECT AVG(movie_length) FROM movies;

SELECT AVG(movie_length) FROM movies
WHERE age_certificate = '18';

-- Challenge
-- Count the number of actors born after the 1st of Jan 1970
SELECT COUNT(actors) FROM actors
WHERE date_of_birth > '1970-01-01';

-- What was the highest and lowest domestic takings for a movie?
SELECT * FROM movie_revenues;

SELECT MAX(domestic_takings) FROM movie_revenues;

SELECT MIN(domestic_takings) FROM movie_revenues;

-- What is the sum total movie length for movies rated 15?
SELECT * FROM movies;

SELECT SUM(movie_length) FROM movies
WHERE age_certificate = '15';


-- How many Japanese directors are in the directors table?
SELECT * FROM directors;

SELECT COUNT(director_id) FROM directors
WHERE nationality = 'Japanese';

-- What is the average movie length for Chinese movies?
SELECT AVG(movie_length) FROM movies
WHERE movie_lan = 'Chinese';

-- Grouping data: use Agg Functions along with GROUPBY clauses to group data 
-- by a column's value. Returns results with more than one value

/*
SELECT column1, AGGFUN(column2) FROM tablename
GROUP BY column1
*/

-- this is how to get one number
SELECT COUNT(movie_lan) FROM movies;

-- this is how to get one number for each unique row
SELECT movie_lan, COUNT(movie_lan) FROM movies
GROUP BY movie_lan;

-- another example
SELECT movie_lan, AVG(movie_length) FROM movies
GROUP BY movie_lan;

-- what happens if you do the same code as above but don't group
SELECT movie_lan, AVG(movie_length) FROM movies;
-- the error message is helpful here. 
-- what it's saying is that we have a conflict in our query request
-- we are asking it to return a column movie_lan with lots of rows
-- AND we are asking it to return just one number with the AVG() request,
-- so it needs us to choose which one we want. We need to either remove the AVG request 
-- or add a GROUP BY to it if we still want it, or we need to remove the other column name 
-- we asked for

-- you can use GROUP BY on multiple columns
-- this would answer the question: 'what is the average movie length for 
-- each movie langage and each age certificate?'
SELECT movie_lan, age_certificate, AVG(movie_length) FROM movies
GROUP BY movie_lan, age_certificate;

-- Now add a WHERE clasue too
SELECT movie_lan, age_certificate, AVG(movie_length) FROM movies
WHERE movie_length > 120
GROUP BY movie_lan, age_certificate;

-- you can select multipe agg functions in a query
SELECT movie_lan, MIN(movie_length), MAX(movie_length) FROM movies
WHERE age_certificate = '15'
GROUP BY movie_lan;

-- HAVING clauses: like WHERE clauses, but they can use AGG functions to filter the data
/*
SELECT column1, AGGFUN(column2) FROM tablename
GROUP BY column1
HAVING AGGFUN(column3) = value;
*/

-- let's say we want our count of movie languages like we have seen before,
-- but this time we only want them for languages that have more than one movie
-- for example, there is only one German movie, so we don't want that one
SELECT movie_lan, COUNT(movie_lan) FROM movies
GROUP BY movie_lan
HAVING COUNT(movie_lan) > 1;

-- we cannot use agg functions with WHERE clauses, so that is where HAVING comes in.
-- This is because WHERE clauses act on that actual values in a column, not on agg values

-- but we can use all of these together, in the proper order
SELECT movie_lan, COUNT(movie_lan) FROM movies
WHERE movie_length > 120
GROUP BY movie_lan
HAVING COUNT(movie_lan) > 1;

-- Challenge!
-- How many directors are there per nationality?
SELECT * FROM directors;

SELECT nationality, COUNT(nationality) FROM directors
GROUP BY nationality;

-- What is the sum total movie length for each age certificate and movie language combination?
SELECT * FROM movies;

SELECT age_certificate, movie_lan, SUM(movie_length) FROM movies
GROUP BY age_certificate, movie_lan
ORDER BY age_certificate;

-- Return the movie languages which have a sum total movie length of over 500 minutes?
SELECT movie_lan, SUM(movie_length) FROM movies
GROUP BY movie_lan
HAVING SUM(movie_length) > 500;

-- This is bonus on mathematical operators
/*
+ - / * %
*/

SELECT 5 + 6 AS addition;
SELECT 8 - 3 AS subtraction;

SELECT 30 / 3 AS division;

SELECT 8 % 2 AS modulus;

-- example using with a query
SELECT movie_id, (domestic_takings + international_takings) AS total_takings FROM movie_revenues;
-- note if one of those rows being added is null, SQL will make the result NULL









