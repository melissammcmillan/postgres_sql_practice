-- Subqueries Section 9
-- subqueries are nested queries

-- For example: find the movies and their length that are longer than the 
-- average movie length
SELECT movie_name, movie_length FROM movies
WHERE movie_length > (SELECT AVG(movie_length) FROM movies);

-- the inner select query is the nested query, and they are executed first in the 
-- statement.

-- Subqueries can be nested inside a select, insert, update or delete query.
-- Subqueries can be used after FROM or WHERE statements.

-- There are two types of subqueries: Uncorrelated and Correlated Subqueries
-- Uncorrelated: the inner query could be executed independently from the outer query
-- example:
SELECT movie_name, movie_length FROM movies
WHERE movie_length > (SELECT AVG(movie_length) FROM movies);

-- Correlated: the inner query references a table from the outer query. So the inner
-- query can't be executed independently from the outer query.
-- example:
SELECT d1.first_name, d1.last_name, d1.date_of_birth, d1.nationality FROM directors d1
WHERE date_of_birth = 
(SELECT MIN(date_of_birth) FROM directors d2
WHERE d2.nationality = d1.nationality);

-- Uncorrelated Subqueries
-- example
SELECT movie_name, movie_length FROM movies
WHERE movie_length >
(SELECT AVG(movie_length) FROM movies);

-- just run the inner query on its own to see that it is uncorrelated
SELECT AVG(movie_length) FROM movies;

-- So I would have been tempted to run this to get the above result, 
-- but it throws an error.
SELECT movie_name, movie_length FROM movies
WHERE movie_length > AVG(movie_length);

-- another example: return the first names and last names of all the directors
-- who are younger than James Cameron
SELECT first_name, last_name, date_of_birth FROM directors
WHERE date_of_birth > 
(SELECT date_of_birth FROM directors 
 WHERE first_name = 'James' AND last_name = 'Cameron');
 
--Confirming James Cameron's date of birth
SELECT date_of_birth FROM directors 
 WHERE first_name = 'James' AND last_name = 'Cameron';
 
-- the inner query table doesn't have to be the same as the outer query table
-- example: return the directors' first and last names and date of birth who are younger 
-- than Tom Cruise
SELECT first_name, last_name, date_of_birth FROM directors
WHERE date_of_birth >
(SELECT date_of_birth FROM actors
WHERE first_name = 'Tom' AND last_name = 'Cruise');

SELECT date_of_birth FROM actors
WHERE first_name = 'Tom' AND last_name = 'Cruise';

-- Uncorrelated Subqueries Part 2
-- we can pass multiple values from the inner query to the outer query using IN

-- select the movie name from the movies where the movie has intl takings greater 
-- than the domestic takings

-- start with inner query
SELECT movie_id FROM movie_revenues
WHERE international_takings > domestic_takings;

--now write the outer query with the inner query
SELECT movie_name FROM movies
WHERE movie_id IN
(SELECT movie_id FROM movie_revenues
WHERE international_takings > domestic_takings);
-- so this was a little bit like a join, but instead of joining tables
-- we just referenced one table to give us information about another table

-- Can also use JOIN calls with these subqueries too to retrieve even more
-- information
SELECT mo.movie_name, mo.movie_id, d.first_name, d.last_name FROM movies mo
JOIN directors d ON mo.director_id = d.director_id
WHERE mo.movie_id IN
(SELECT movie_id FROM movie_revenues
WHERE international_takings > domestic_takings);

-- Challenge on uncorrelated subqueries 
-- Select the first and last names of all the actors older than Marlon Brando
SELECT first_name, last_name, date_of_birth FROM actors
WHERE date_of_birth < 
(SELECT date_of_birth FROM actors
WHERE first_name = 'Marlon' AND last_name = 'Brando');

-- Select the movie names of all movies that have domestic takings above 300 million.
SELECT movie_name, movie_id FROM movies
WHERE movie_id IN 
(SELECT movie_id FROM movie_revenues
WHERE domestic_takings > 300);
-- I wanted to put the = sign in the first WHERE clause, so I just need to remember that it needs to
-- be IN, not =

-- You can get this result by using a JOIN instead, just FYI
SELECT mo.movie_name, mo.movie_id FROM movies mo
JOIN movie_revenues mr ON mo.movie_id = mr.movie_id
WHERE mr.domestic_takings > 300;

-- Return the shortest and longest movie length for movies with an above average domestic taking.
SELECT MIN(movie_length), MAX(movie_length) FROM movies
WHERE movie_id IN 
(SELECT movie_id FROM movie_revenues
WHERE domestic_takings >
	(SELECT AVG(domestic_takings) FROM movie_revenues));












