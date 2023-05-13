-- Inner Joins: only returns rows of data with matching values in both tables

/*
SELECT table1.column1, table1.column2, table2.column1 FROM table1
INNER JOIN table2 ON table1.column3 = table2.column3;
*/

-- we want to use inner join between movies table and directors table
-- but first we need insert and extra row of data
SELECT * FROM directors
ORDER BY nationality;
-- this won't have a match in the movies table on purpose
INSERT INTO directors (first_name, last_name, date_of_birth, nationality)
VALUES ('Christopher', 'Nolan', '1970-07-30', 'British');

-- check that there is no director id for christopher nolan
-- in the movies table
SELECT * FROM movies
WHERE director_id = 38;

SELECT directors.director_id, directors.first_name, directors.last_name, movies.movie_name FROM directors
INNER JOIN movies ON directors.director_id = movies.director_id;
-- Notice we don't get director_id 38 christopher nolan because there wasn't a match

-- Another example, using a where clause
SELECT directors.director_id, directors.first_name, directors.last_name, movies.movie_name FROM directors
INNER JOIN movies ON directors.director_id = movies.director_id
WHERE movies.movie_lan = 'Japanese';

-- experiment with shortening the names of the tables using an alias
SELECT d.director_id, d.first_name, d.last_name, m.movie_name FROM directors AS d
INNER JOIN movies AS m ON d.director_id = m.director_id
WHERE m.movie_lan = 'Japanese';

-- Another example, using a where clause and ORDER BY
SELECT d.director_id, d.first_name, d.last_name, m.movie_name FROM directors AS d
INNER JOIN movies AS m ON d.director_id = m.director_id
WHERE m.movie_lan = 'Japanese'
ORDER BY m.movie_length;

-- An important thing to know is that for inner joins, it doesn't matter which table comes first
-- SQL is simply looking for matches between the two. This is not the case for left and right joins.

-- There is a slightly shorter way to write inner join queries.
-- experiment with shortening the names of the tables using an alias
-- you don't need to write AS for assigning the alias
-- you can just use JOIN instead of INNER JOIN
SELECT d.director_id, d.first_name, d.last_name, m.movie_name FROM directors d
JOIN movies m ON d.director_id = m.director_id;

-- practice by joining the movies table and the movies_revenues table
SELECT * FROM movies;

SELECT * FROM movie_revenues;

SELECT m.movie_name, m.release_date, mr.domestic_takings, mr.international_takings FROM movies m
JOIN movie_revenues mr ON m.movie_id = mr.movie_id
ORDER BY mr.domestic_takings;

-- INNER JOINS with USING, which us used only when the joining columns have the same name
/*
SELECT t1.column1, t1.column2, t2.column1 FROM table1 t1
JOIN table t2 USING (column3);
*/

SELECT m.movie_name, mr.domestic_takings FROM movies m
JOIN movie_revenues mr USING (movie_id)
WHERE m.age_certificate IN ('12', '15', '18')
ORDER BY mr.domestic_takings DESC;

-- Challenge
-- Select the directors first and last names, the movie names and release dates for all 
-- Chinese, Korean, and Japanese movies
SELECT * FROM movies;
SELECT * FROM directors;

SELECT d.first_name, d.last_name, m.movie_name, m.release_date, m.movie_lan FROM directors d
JOIN movies m USING (director_id)
WHERE m.movie_lan IN ('Chinese', 'Korean', 'Japanese');

-- Select the movie names, release dates and international takings of all English language movies
SELECT * FROM movies;
SELECT * FROM movie_revenues;

SELECT m.movie_name, m.release_date, m.movie_lan, mr.international_takings FROM movies m
JOIN movie_revenues mr USING (movie_id)
WHERE m.movie_lan = 'English';

-- Select the movie names, domestic takings and international takings for all movies with either missing 
-- domestic takings or missing international takings and order the results by movie name
SELECT m.movie_name, mr.domestic_takings, mr.international_takings FROM movies m
JOIN movie_revenues mr USING (movie_id)
WHERE mr.domestic_takings IS NULL OR mr.international_takings IS NULL
ORDER BY m.movie_name;




-- Left Joins: returns all the rows of data in the left table and only the matching
-- rows of data in the right table. Also called Left Outer Join.
/*
SELECT t1.column1, t1.column2, t2.column1 FROM table1 t1
LEFT JOIN table2 t2 ON t1.column3 = t2.column3;
*/

-- get all the directors and the movies they are in
SELECT d.director_id, d.first_name, d.last_name, mo.movie_name FROM directors d
LEFT JOIN movies mo ON d.director_id = mo.director_id;
-- note that we have christopher nolan even though his movie is null
-- if we were to do an inner join, we wouldnt get him

-- we will get a different result if we switch table 1 and table 2 
SELECT d.director_id, d.first_name, d.last_name, mo.movie_name FROM movies mo
LEFT JOIN directors d ON d.director_id = mo.director_id;
-- we don't get christopher nolan in this result

-- run another example query
SELECT d.director_id, d.first_name, d.last_name, mo.movie_name FROM directors d
LEFT JOIN movies mo ON d.director_id = mo.director_id
WHERE nationality = 'British';

-- Right Joins: not very common; returns all the rows of data in the right table,
-- and only the matching rows of data in the left table. They are the opposite of 
-- left joins. Also called Right Outer Join.

-- right joins return all the data from table 2 and only the matching data from table 1
SELECT d.director_id, d.first_name, d.last_name, mo.movie_name FROM directors d
RIGHT JOIN movies mo ON d.director_id = mo.director_id;
-- this will not return christopher nolan

-- now if we were to switch table1 and table 2, it would be similar to the left join above
SELECT d.director_id, d.first_name, d.last_name, mo.movie_name FROM movies mo
RIGHT JOIN directors d ON d.director_id = mo.director_id;
-- and we get christoper nolan

-- with a WHERE clause
SELECT d.director_id, d.first_name, d.last_name, mo.movie_name FROM movies mo
RIGHT JOIN directors d ON d.director_id = mo.director_id
WHERE mo.age_certificate = '18';

-- note that right joins are fairly rare to see in SQL because they are just the
-- equivalent of left joins with the tables switched, but it's good to be aware.

-- FULL JOIN or FULL OUTER JOIN: Will only return all rows of data in both tables, regardless of
-- commonality.
/*
SELECT t1.column1, t1.column2, t2.column1 FROM table1 t1
FULL JOIN table2 t2 ON t1.column3 = t2.column3;
*/

SELECT d.director_id, d.first_name, d.last_name, mo.movie_name FROM movies mo
FULL JOIN directors d ON d.director_id = mo.director_id;

-- now if I switch table one and table two, we will see we get the exact same result
SELECT d.director_id, d.first_name, d.last_name, mo.movie_name FROM directors d
FULL JOIN movies mo ON d.director_id = mo.director_id;

-- we can add any WHERE clauses we want
SELECT d.director_id, d.first_name, d.last_name, mo.movie_name FROM movies mo
FULL JOIN directors d ON d.director_id = mo.director_id
WHERE movie_lan in ('German', 'Korean')
ORDER BY d.last_name;

-- Challenge
-- Use a left join to select the first and last names of all British directors and the 
-- names and age certificates of the movies that they directed.
SELECT d.first_name, d.last_name, mo.movie_name, mo.age_certificate FROM directors d
LEFT JOIN movies mo USING (director_id)
WHERE d.nationality = 'British';

-- Count the number of movies that each director has directed.
SELECT d.first_name, d.last_name, COUNT(mo.movie_id) FROM directors d
LEFT JOIN movies mo USING (director_id)
GROUP BY d.first_name, d.last_name;
-- you need to add each column that you put in SELECT that is NOT an agg function to the GROUP BY clause. 


-- Joining more than two tables
/*
SELECT t1.column, t2.column, t3.column FROM table t1
JOIN table2 t2 ON t1.column = t2.column
JOIN table3 t3 ON t3.column = t2.column;
*/

-- let's write a query to see data from three of our movie tables
SELECT d.first_name, d.last_name, mo.movie_name, mr.international_takings, mr.domestic_takings FROM directors d
JOIN movies mo ON d.director_id = mo.director_id
JOIN movie_revenues mr ON mr.movie_id = mo.movie_id;

-- we haven't queried data from our movies and actors table together yet because we haven't utilized our junction table. lets do that.
SELECT ac.first_name, ac.last_name, mo.movie_name FROM actors ac
JOIN movies_actors ma ON ac.actor_id = ma.actor_id
JOIN movies mo ON mo.movie_id = ma.movie_id;

-- can also use a WHERE clause and an ORDER BY
SELECT ac.first_name, ac.last_name, mo.movie_name FROM actors ac
JOIN movies_actors ma ON ac.actor_id = ma.actor_id
JOIN movies mo ON mo.movie_id = ma.movie_id
WHERE mo.movie_lan = 'English'
ORDER BY movie_name;

-- now select directors and actors and movies in a query
SELECT d.first_name, d.last_name, mo.movie_name, ac.first_name, ac.last_name,
mr.domestic_takings, mr.international_takings FROM directors d
JOIN movies mo ON d.director_id = mo.director_id
JOIN movies_actors ma ON ma.movie_id = mo.movie_id
JOIN actors ac ON ac.actor_id = ma.actor_id
JOIN movie_revenues mr ON mr.movie_id = mo.movie_id;

-- Challenge for joining multiple tables
-- Select the first and last names of all the actors who have starred in movies
-- directed by Wes Anderson
SELECT * FROM actors;

SELECT * FROM directors
WHERE directors.first_name = 'Wes' AND directors.last_name = 'Anderson';

SELECT * FROM movies_actors;

SELECT * FROM movies
LIMIT 5;

SELECT ac.first_name, ac.last_name, mo.movie_name, d.last_name FROM actors ac
JOIN movies_actors ma ON ma.actor_id = ac.actor_id
JOIN movies mo ON mo.movie_id = ma.movie_id
JOIN directors d ON d.director_id = mo.director_id
WHERE d.first_name = 'Wes' AND d.last_name = 'Anderson';


-- Which director has the highest total domestic takings.
SELECT * FROM movie_revenues;

SELECT * FROM directors;

SELECT * FROM movies;

SELECT d.first_name, d.last_name, SUM(mr.domestic_takings) FROM directors d
JOIN movies mo ON mo.director_id = d.director_id
JOIN movie_revenues mr ON mr.movie_id = mo.movie_id
WHERE mr.domestic_takings IS NOT NULL
GROUP BY d.first_name, d.last_name
ORDER BY SUM(mr.domestic_takings) DESC
LIMIT 1;


-- Union statements return the results of two or more select queries in a single results set
/*
SELECT column1, column2 FROM table1
UNION
SELECT column1, column2 FROM table2;
*/

-- Some rules: 
-- 1. select the same number of columns in each SELECT statement
-- 2. the corresponding columns between each table must have compatable data types
-- so column1 from table1 and column1 from table2 must both be the same data type

-- an example
SELECT d.first_name, d.last_name FROM directors d
UNION
SELECT ac.first_name, ac.last_name FROM actors ac;

-- Can also use WHERE clauses in each SELECT statement
SELECT d.first_name, d.last_name FROM directors d
WHERE d.nationality = 'American'
UNION
SELECT ac.first_name, ac.last_name FROM actors ac
WHERE ac.gender = 'F';

-- Can also use ORDER BY clauses in each SELECT statement
SELECT d.first_name, d.last_name FROM directors d
WHERE d.nationality = 'American'
UNION
SELECT ac.first_name, ac.last_name FROM actors ac
WHERE ac.gender = 'F'
ORDER BY first_name;
-- note that if we want the ORDER BY to apply to both tables, we need to put it
-- at the end of the query. Putting it before doesn't guarantee that it will apply 
-- to the whole table

-- Can also use ORDER BY clauses in each SELECT statement
SELECT d.first_name, d.last_name, d.date_of_birth FROM directors d
WHERE d.nationality = 'American'
UNION
SELECT ac.first_name, ac.last_name, ac.date_of_birth FROM actors ac
WHERE ac.gender = 'F'
ORDER BY first_name;

-- what happens if we don't have the same data type between the SELECT statements?
SELECT d.date_of_birth, d.last_name FROM directors d
UNION
SELECT ac.first_name, ac.last_name FROM actors ac;
-- we get an error statement about matching data types


-- UNION ALL statements: they are mostly the same as UNION except
-- UNION ALL does not remove duplicated values the way that UNION
-- by itself does

/*
SELECT column1, column2 FROM table1
UNION ALL
SELECT column1, column2 FROM table2;
*/

-- so if we have directors and actors with both name Tom here, UNION
-- will remove the duplicates and we will have missing data
SELECT first_name FROM directors
UNION
SELECT first_name FROM actors;
-- 163 rows of data are returned here

SELECT first_name FROM directors
UNION ALL
SELECT first_name FROM actors;
-- 186 rows of data are returned here, because it has not removed duplicates

-- Can use an ORDER BY
SELECT first_name FROM directors
UNION ALL
SELECT first_name FROM actors
ORDER BY first_name;

-- Challenge
-- Select the first_names, last names and dates of birth from directors and actors
-- Order results by date_of_birth.
SELECT first_name, last_name, date_of_birth FROM directors
UNION ALL
SELECT first_name, last_name, date_of_birth FROM actors
ORDER BY date_of_birth;
-- Using UNION ALL is a safe thing to do to make sure you aren't removing data accidentally

-- Select the first and last names of all directors and actors born in the 1960s. Order the results by last name.
SELECT d.first_name, d.last_name FROM directors d
UNION ALL
SELECT ac.first_name, ac.last_name FROM actors ac
WHERE date_of_birth > '1959-12-31' AND date_of_birth < '1970-01-01'
ORDER BY last_name;
-- 70 rows, starting with Tomas Alfredson

-- Another way to solve above
SELECT d.first_name, d.last_name FROM directors d
UNION ALL
SELECT ac.first_name, ac.last_name FROM actors ac
WHERE date_of_birth BETWEEN '1960-01-01' AND '1969-12-31'
ORDER BY last_name;
-- 70 rows, starting with Romas Alfredson

SELECT d.first_name, d.last_name FROM directors d
WHERE date_of_birth BETWEEN '1960-01-01' AND '1969-12-31'
UNION ALL
SELECT ac.first_name, ac.last_name FROM actors ac
WHERE date_of_birth BETWEEN '1960-01-01' AND '1969-12-31'
ORDER BY last_name;
-- 72 rows, starting with Tomas Alfredson
-- I'm not sure why we get two extra rows of data in this one
-- but be safe and apply WHERE clauses to each SELECT query not at the end

-- checking my work
SELECT d.first_name, d.last_name, d.date_of_birth FROM directors d
WHERE date_of_birth BETWEEN '1960-01-01' AND '1969-12-31'
ORDER BY last_name;
-- 9 rows
SELECT ac.first_name, ac.last_name, ac.date_of_birth FROM actors ac
WHERE date_of_birth BETWEEN '1960-01-01' AND '1969-12-31'
ORDER BY last_name;
-- 31 rows

-- now I'm so confused!

-- Intersect: this also combines data from two or more tables like UNION and UNION ALL
-- but this only returns rows that are in both SELECT statements
/*
SELECT column1 FROM table1
INTERSECT
SELECT column1 FROM table2;
*/

-- example using first_name columns
SELECT first_name FROM directors
INTERSECT
SELECT first_name FROM actors;
-- this gives us all the unique first names that are found in both tables

-- what is difference in using DISTINCT? 
SELECT * FROM directors;

SELECT * FROM actors;

SELECT * FROM movies;

SELECT * FROM movies_actors;


SELECT DISTINCT(d.first_name) FROM directors d
JOIN ;
-- Okay, I think I have figured out the value of INTERSECT: in order to find the commonality
-- between director and actor first names, I would have to do a few JOINS and a pretty
-- complicated query to return what INTERSECT can provide for me.

-- can also use ORDER BY
SELECT first_name FROM directors
INTERSECT
SELECT first_name FROM actors
ORDER BY first_name;
-- 12 rows returned

-- can also use ORDER BY
SELECT first_name FROM directors
WHERE nationality = 'American'
INTERSECT
SELECT first_name FROM actors
ORDER BY first_name;
-- 9 rows returned


-- EXCEPT statements only returns data found in table 1 and not found in table 2.
-- this returns data from Table1, if it's not returned by table2
/*
SELECT column1 FROM table1
EXCEPT
SELECT column1 FROM table2;
*/

-- example
SELECT first_name FROM directors
EXCEPT
SELECT first_name FROM actors;
-- so this is selecting the first names from directors, unless that name
-- is found in the actors table

-- can use an ORDER BY
SELECT first_name FROM directors
EXCEPT
SELECT first_name FROM actors
ORDER BY first_name;

-- can use WHERE clauses and an ORDER BY
SELECT first_name FROM directors
WHERE nationality = 'American'
EXCEPT
SELECT first_name FROM actors
ORDER BY first_name;

-- now compare to our query above
-- here was what we did above that yielded two different results
-- Another way to solve above
SELECT d.first_name, d.last_name, d.date_of_birth FROM directors d
UNION ALL
SELECT ac.first_name, ac.last_name, ac.date_of_birth FROM actors ac
WHERE date_of_birth BETWEEN '1960-01-01' AND '1969-12-31'
ORDER BY last_name;
-- 70 rows, starting with Romas Alfredson

SELECT d.first_name, d.last_name, d.date_of_birth FROM directors d
WHERE date_of_birth BETWEEN '1960-01-01' AND '1969-12-31'
UNION ALL
SELECT ac.first_name, ac.last_name, ac.date_of_birth FROM actors ac
WHERE date_of_birth BETWEEN '1960-01-01' AND '1969-12-31'
ORDER BY last_name;
-- 72 rows, starting with Tomas Alfredson
-- I'm not sure why we get two extra rows of data in this one
-- but be safe and apply WHERE clauses to each SELECT query not at the end

SELECT d.first_name, d.last_name, d.date_of_birth FROM directors d
WHERE date_of_birth BETWEEN '1960-01-01' AND '1969-12-31'
ORDER BY last_name;
-- 9 rows
SELECT ac.first_name, ac.last_name, ac.date_of_birth FROM actors ac
WHERE date_of_birth BETWEEN '1960-01-01' AND '1969-12-31'
ORDER BY last_name;
-- 31 rows

-- Challenge
-- Intersect the first_name, last name and date of birth columns in the directors and actors tables
SELECT first_name, last_name, date_of_birth FROM directors
INTERSECT
SELECT first_name, last_name, date_of_birth FROM actors;
-- I think this found all the directors who are also actors


-- Retrieve the first names of male actors unless they have the same first name as any British directors
SELECT first_name, gender FROM actors
WHERE gender = 'M'
EXCEPT
SELECT first_name, nationality FROM directors
WHERE nationality = 'British';
-- this returned 92 values

SELECT first_name FROM actors
WHERE gender = 'M'
EXCEPT
SELECT first_name FROM directors
WHERE nationality = 'British';
-- this returned 88 values
-- I don't know why this is!




