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










