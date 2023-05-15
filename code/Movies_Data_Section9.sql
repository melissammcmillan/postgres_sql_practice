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













