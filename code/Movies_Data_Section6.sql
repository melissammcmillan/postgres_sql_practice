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

SELECT COUNT(movie_lan) FROM movies;






