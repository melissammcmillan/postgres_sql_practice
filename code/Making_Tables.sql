-- Database: udemy_course_movies_db

-- DROP DATABASE IF EXISTS udemy_course_movies_db;

CREATE DATABASE udemy_course_movies_db
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
	
	
-- create the directors table
	
CREATE TABLE directors (

	director_id SERIAL PRIMARY KEY,
	first_name VARCHAR(30),
	last_name VARCHAR(30) NOT NULL,
	date_of_birth DATE,
	nationality VARCHAR(20)
);	

SELECT * FROM directors;

-- create the actors table

CREATE TABLE actors (
	actor_id SERIAL PRIMARY KEY,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	gender CHAR(1),
	date_of_birth DATE
);

SELECT * FROM actors;

-- if you need to delete a table

DROP TABLE actors;


-- creating the movies table with a foreign key
-- NOT NULL means it must have data in it
-- references makes a foreign key to the directors table to the director_id column

CREATE TABLE movies (
	movie_id SERIAL PRIMARY KEY,
	movie_name VARCHAR(50) NOT NULL,
	movie_length INT,
	movie_lan VARCHAR(20),
	release_date DATE,
	age_certificate VARCHAR(5),
	director_id INT REFERENCES directors (director_id)
);

SELECT * FROM movies;

-- creating the movies revenue table

CREATE TABLE movie_revenues (
	revenue_id SERIAL PRIMARY KEY,
	movie_id INT REFERENCES movies (movie_id),
	domestic_takings NUMERIC(6,2),
	international_takings NUMERIC(6,2)
);

SELECT * FROM movie_revenues;

-- make the movies_actors table
-- this kind of table is called a junction table
-- because it relates two tables together
-- primary key column is a combination of the movie_id
-- and actor_id columns

CREATE TABLE movies_actors (
	movie_id INT REFERENCES movies (movie_id),
	actor_id INT REFERENCES actors (actor_id),
	PRIMARY KEY (movie_id,actor_id)
);

SELECT * FROM movies_actors;

-- this is how we can modify existing databases
-- we will create a new database for this since we don't
-- want to modify this existing one
-- we created the test_database
-- right click on test_database and select CREATE script





