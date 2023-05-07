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
JOIN movie_revenues mr ON m.movie_id = mr.movie_id;




-- Left Joins: returns all the rows of data in the left table and only the matching
-- rows of data in the right table. Also called Left Outer Join.

-- Right Joins: not very common; returns all the rows of data in the right table,
-- and only the matching rows of data in the left table. They are the opposite of 
-- left joins. Also called Right Outer Join.

-- Full Join: Will only return all rows of data in both tables, regardless of
-- commonality.










