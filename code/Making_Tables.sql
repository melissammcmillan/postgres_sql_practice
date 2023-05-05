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

-- using the scripts provided by the course, I copied and pasted the data below
/* 
Insert data into directors table
*/

INSERT INTO DIRECTORS (first_name, last_name, date_of_birth, nationality) VALUES ('Tomas','Alfredson','1965-04-01','Swedish'),
('Paul','Anderson','1970-06-26','American'),
('Wes','Anderson','1969-05-01','American'),
('Richard','Ayoade','1977-06-12','British'),
('Luc','Besson','1959-03-18','French'),
('James','Cameron','1954-08-16','American'),
('Guillermo','del Toro','1964-10-09','Mexican'),
('Victor','Fleming','1889-02-23','American'),
('Francis','Ford Coppola','1939-04-07','American'),
('Kinji','Fukasaku','1930-07-03','Japanese'),
('Florian ','Henckel von Donnersmarck','1973-05-02','German'),
('Terry','Jones','1942-02-01','British'),
('Stanley','Kubrick','1928-07-26','American'),
('John','Lasseter','1957-01-12','American'),
('Ang','Lee','1954-10-23','Chinese'),
('Bruce','Lee','1940-11-27','Chinese'),
('George','Lucas','1944-05-14','American'),
('Martin','McDonagh','1970-03-26','British'),
('James','McTeigue','1967-12-29','Australian'),
('Fernando','Meirelles','1955-11-09','Brazilian'),
('Hayao ','Miyazaki','1941-01-05','Japanese'),
('Paulo','Morelli','1966-03-10','Brazilian'),
('Chan-wook','Park','1963-08-23','South Korean'),
('Sam','Raimi','1959-10-23','American'),
('Mark','Romanek','1959-09-18','American'),
('Martin','Scorsese','1942-11-17','American'),
('Ridley','Scott','1937-11-30','British'),
('Tony','Scott','1944-06-21','British'),
('Zack','Snyder','1966-03-01','American'),
('Sion','Sono','1961-12-18','Japanese'),
('Steven','Spielberg','1946-12-18','American'),
('Robert','Stevenson','1905-03-31','British'),
('Quentin','Tarantino','1963-03-27','American'),
('Robert','Wise','1914-09-10','American'),
('Kar Wai','Wong','1958-07-17','Chinese'),
('Robert','Zemeckis','1952-05-14','American'),
('Yimou','Zhang','1950-04-02','Chinese');

SELECT * FROM directors;

-- now do the actors data
/* 
Insert data into actors table
*/

INSERT INTO actors (first_name, last_name, gender, date_of_birth) VALUES ('Malin','Akerman','F','1978-05-12'),
('Tim','Allen','M','1953-06-13'),
('Julie','Andrews','F','1935-10-01'),
('Ivana','Baquero','F','1994-06-11'),
('Lorraine','Bracco','F','1954-10-02'),
('Alice','Braga','F','1983-04-15'),
('Marlon','Brando','M','1924-04-03'),
('Adrien','Brody','M','1973-04-14'),
('Peter','Carlberg','M','1950-12-08'),
('Gemma','Chan','F','1982-11-29'),
('Chen','Chang','M','1976-10-14'),
('Graham','Chapman','M','1941-01-08'),
('Pei-pei','Cheng','F','1946-12-04'),
('Maggie ','Cheung','F','1964-09-20'),
('Min-sik','Choi','M','1962-05-30'),
('Yun-fat','Chow','M','1955-05-18'),
('John','Cleese','M','1939-10-27'),
('Paddy','Considine','M','1973-09-05'),
('Abbie','Cornish','F','1982-08-07'),
('Brian','Cox','M','1946-06-01'),
('Scatman','Crothers','M','1910-05-23'),
('Russell','Crowe','M','1964-04-07'),
('Tom','Cruise','M','1962-07-03'),
('Darlan','Cunha','M','1988-07-26'),
('Willem','Dafoe','M','1955-07-22'),
('Paul','Dano','M','1984-06-19'),
('Daniel','Day-Lewis','M','1957-04-29'),
('Robert','De Niro','M','1943-08-17'),
(null,'Denden','M','1950-01-23'),
('Leonardo','DiCaprio','M','1974-11-11'),
('Peter','Dinklage','M','1969-06-11'),
('Hiroki','Doi','M','1999-08-10'),
('Kirsten','Dunst','F','1982-04-30'),
('Shelley','Duvall','F','1949-07-07'),
('Ralph','Fiennes','M','1962-12-22'),
('Leandro','Firmino','M','1978-06-23'),
('Carrie','Fisher','F','1956-10-21'),
('Harrison','Ford','M','1942-07-13'),
('Jodie','Foster','F','1962-11-19'),
('James','Franco','M','1978-04-19'),
('Dillon','Freasier','M','1996-03-06'),
('Tatsuya','Fujiwara','M','1982-05-15'),
('Mitsuru','Fukikoshi','M','1965-02-17'),
('Clark','Gable','M','1901-02-01'),
('Mason','Gamble','M','1986-01-16'),
('Xian','Gao','M',null),
('Andrew','Garfield','M','1983-08-20'),
('Judy','Garland','F','1922-06-10'),
('Martina','Gedeck','F','1961-09-14'),
('Jeff','Goldblum','M','1952-10-22'),
('Carla','Gugino','F','1971-08-29'),
('Alec','Guiness','M','1914-04-02'),
('Jackey','Haley','M','1961-07-14'),
('Mark','Hamill','M','1951-09-25'),
('Tom','Hanks','M','1956-07-09'),
('Daryl','Hannah','F','1958-12-03'),
('Woody','Harrelson','M','1961-07-23'),
('Rutger','Hauer','M','1944-01-23'),
('Sally','Hawkins','F','1976-04-27'),
('Kare','Hedebrant','M','1995-06-28'),
('Rumi','Hiiragi','F','1987-08-01'),
('Ian','Holm','M','1931-09-12'),
('Dennis','Hopper','M','1936-05-17'),
('Eric','Idle','M','1943-03-29'),
('Miyu','Irino','M','1988-02-19'),
('Samuel','Jackson','M','1948-12-21'),
('Terry','Jones','M','1942-02-01'),
('Milla','Jovovich','F','1975-12-17'),
('Megumi','Kagurazaka','F','1981-09-28'),
('Takeshi','Kaneshiro','M','1973-10-11'),
('Hei-Jung','Kang','F','1982-01-04'),
('Irfan','Khan','M','1967-01-07'),
('Nicole','Kidman','F','1967-06-20'),
('Val','Kilmer','M','1959-12-31'),
('Takeshi','Kitano','M','1947-01-18'),
('Keira','Knightley','F','1985-03-26'),
('Sebastian','Koch','M','1962-05-31'),
('Asuka','Kurosawa','F','1971-12-22'),
('Andy','Lau','M','1961-09-27'),
('Jude','Law','M','1972-12-29'),
('Lina','Leandersson','F','1995-09-27'),
('Bruce','Lee','M','1940-11-27'),
('Vivien','Leigh','F','1913-11-05'),
('Tony','Leung','M','1962-06-27'),
('Ray','Liotta','M','1954-12-18'),
('Danny','Lloyd','M','1972-10-13'),
('Sihung','Lung','M','1930-01-01'),
('Aki','Maeda','F','1985-07-11'),
('Tobey','Maguire','M','1975-06-27'),
('Francis','McDormand','F','1957-06-23'),
('Malcolm','McDowell','M','1943-06-13'),
('Alfred','Molina','M','1953-05-24'),
('Cathy','Moriarty','F','1960-11-29'),
('Ulrich','Muhe','M','1953-06-20'),
('Carey','Mulligan','F','1985-05-28'),
('Bill','Murray','M','1950-09-21'),
('Mari','Natsuki','F','1952-05-02'),
('Jack','Nicholson','M','1937-04-22'),
('Connie','Nielsen','F','1965-07-03'),
('Ika','Nord','F','1960-04-29'),
('Chuck','Norris','M','1940-03-10'),
('Edward','Norton','M','1969-08-18'),
('Gary','Oldman','M','1958-03-21'),
('Yasmin','Paige','F','1991-06-24'),
('Michael','Palin','M','1943-05-05'),
('Rebecca','Pan','F','1931-12-29'),
('Joe','Pesci','M','1943-02-09'),
('Joaquin','Phoenix','M','1974-10-28'),
('Natilie','Portman','F','1981-06-09'),
('Per','Ragnar','M','1941-05-29'),
('Oliver','Reed','M','1938-02-13'),
('Jean','Reno','M','1948-07-30'),
('Tony','Revolori','M','1996-04-28'),
('Craig','Roberts','M','1991-01-21'),
('Sam','Rockwell','M','1968-11-05'),
('Alexandre','Rodrigues','M','1983-05-21'),
('Saoirse','Ronan','F','1994-04-12'),
('Roy','Scheider','M','1932-11-10'),
('Jason','Schwartzmann','M','1980-06-26'),
('Suraj','Sharma','M','1993-03-21'),
('Martin','Sheen','M','1940-08-03'),
('Douglas','Silva','M','1988-09-27'),
('Dandan','Song','F','1961-08-25'),
('Rafe','Spall','M','1983-03-10'),
('Tilda','Swinton','F','1960-11-05'),
('George','Tokoro','M','1955-01-26'),
('Noah','Taylor','M','1969-09-04'),
('Uma','Thurman','F','1970-04-29'),
('John','Travolta','M','1954-02-18'),
('Chris','Tucker','M','1971-08-31'),
('Dick','Van Dyke','M','1925-12-13'),
('Hugo','Weaving','M','1960-04-04'),
('Olivia','Williams','F','1968-07-26'),
('Mykelti','Williamson','M','1957-03-04'),
('Bruce','Willis','M','1955-03-19'),
('Luke','Wilson','M','1971-09-21'),
('Owen','Wilson','M','1968-11-18'),
('Patrick','Wilson','M','1973-07-03'),
('Kate','Winslet','F','1975-10-05'),
('Faye','Wong','F','1969-08-08'),
('Robin','Wright','F','1966-04-08'),
('Michelle','Yeoh','F','1962-08-06'),
('Ji-tae','Yoo','M','1976-04-13'),
('Jin-seo','Yoon','F','1983-08-05'),
('Sean','Young','F','1959-11-20'),
('Billy','Zane','M','1966-02-24'),
('Ziyi','Zhang','F','1979-02-09');

SELECT * FROM actors;

-- now do the movies data
/* 
Insert data into movies table
*/

INSERT INTO movies (movie_name, movie_length, movie_lan, release_date, age_certificate, director_id) VALUES ('A Clockwork Orange','112','English','1972-02-02','18','13'),
('Apocalypse Now','168','English','1979-08-15','15','9'),
('Battle Royale ','111','Japanese','2001-01-04','18','10'),
('Blade Runner ','121','English','1982-06-25','15','27'),
('Chungking Express','113','Chinese','1996-08-03','15','35'),
('City of God','145','Portuguese','2003-01-17','18','20'),
('City of Men','140','Portuguese','2008-02-29','15','22'),
('Cold Fish','108','Japanese','2010-09-12','18','30'),
('Crouching Tiger Hidden Dragon','139','Chinese','2000-07-06','12','15'),
('Eyes Wide Shut','130','English','1999-07-16','18','13'),
('Forrest Gump','119','English','1994-07-06','PG','36'),
('Gladiator','165','English','2000-05-05','15','27'),
('Gone with the Wind','123','English','1939-12-15','PG','8'),
('Goodfellas','148','English','1990-09-19','15','26'),
('Grand Budapest Hotel','117','English','2014-07-03','PG','3'),
('House of Flying Daggers','134','Chinese','2004-03-12','12','37'),
('In the Mood for Love','124','Chinese','2001-02-02','12','35'),
('Jaws','134','English','1975-06-20','12','31'),
('Leon','123','English','1994-11-18','15','5'),
('Let the Right One In','128','Swedish','2008-10-24','15','1'),
('Life of Brian','126','English','1979-08-17','15','12'),
('Life of Pi','129','English','2012-11-21','PG','15'),
('Mary Poppins','87','English','1964-08-29','U','32'),
('Never Let Me Go','117','English','2010-09-15','15','25'),
('Oldboy','130','Korean','2005-03-25','18','23'),
('Pans Labyrinth','98','Spanish','2006-12-29','PG','7'),
('Ponyo','107','Japanese','2009-08-14','U','21'),
('Pulp Fiction','136','English','1994-10-14','15','33'),
('Raging Bull','132','English','1980-11-14','18','26'),
('Rushmore','104','English','1998-11-12','12','3'),
('Spider-Man','118','English','2002-05-03','PG','24'),
('Spider-Man 2','115','English','2004-06-30','PG','24'),
('Spider-Man 3','112','English','2007-05-04','PG','24'),
('Spirited Away','120','Japanese','2001-06-19','U','21'),
('Star Wars: A New Hope','123','English','1977-05-25','PG','17'),
('Star Wars: Empire Strikes Back','150','English','1980-05-21','PG','17'),
('Star Wars: Return of the Jedi','139','English','1983-05-25','PG','17'),
('Submarine','115','English','2011-06-03','15','4'),
('Taxi Driver','117','English','1976-02-7','15','26'),
('The Darjeeling Limited','119','English','2007-09-29','PG','3'),
('The Fifth Element','149','English','1997-05-09','12','5'),
('The Lives of Others','165','German','2007-02-09','15','11'),
('The Shining','126','English','1980-05-23','18','13'),
('The Sound of Music','91','English','1965-03-02','U','34'),
('The Wizard of Oz','120','English','1939-08-25','U','8'),
('There Will Be Blood','168','English','2007-12-26','15','2'),
('Three Billboards Outside Ebbing, Missouri ','134','English','2017-11-10','15','18'),
('Titanic','143','English','1997-12-19','12','6'),
('Top Gun','121','English','1986-05-16','12','28'),
('Toy Story','95','English','1995-11-22','U','14'),
('V for Vendetta','140','English','2006-03-17','12','19'),
('Watchmen','138','English','2009-03-06','12','29'),
('Way of the Dragon ','99','Chinese','1972-06-01','12','16');

SELECT * FROM movies;

/* 
Insert data into movies revenues table
*/

INSERT INTO movie_revenues (revenue_id, movie_id, domestic_takings, international_takings) VALUES ('1','45','22.2','1.3'),
('2','13','199.4','201.2'),
('3','23','102.1',null),
('4','44','158.7',null),
('6','1','27.1',null),
('7','53',null,null),
('17','18','260.3','210.9'),
('9','39','28.1',null),
('5','35','461.2','314.2'),
('13','2','83.4',null),
('15','21','19.6',null),
('8','36','290.3','247.8'),
('11','43','44.1',null),
('12','29','23.1',null),
('14','4','33.3',null),
('10','37','309.1','166.2'),
('16','49','180.1','177.3'),
('18','14','46.6',null),
('21','11','330.3','348.1'),
('20','28','107.9','106.2'),
('19','19',null,null),
('23','50','192.1','182.4'),
('22','5',null,null),
('27','41','64.1','200.3'),
('24','48','659.2','1528.1'),
('25','30','16.9',null),
('26','10','55.7','106.3'),
('30','12','188.2','273.4'),
('28','9','128.1','85.1'),
('29','3',null,null),
('32','17','2.9','10.2'),
('31','34','11.1','265.4'),
('33','31','404.1','418.1'),
('37','6','8.2','23.5'),
('35','16','11.1','82.5'),
('36','32','374.1','410.4'),
('34','25','1.1','13.8'),
('38','51','71.2','62.5'),
('40','26','37.8','46.4'),
('48','42','11.3','66.1'),
('39','33','337','554'),
('51','40','11.9','23.2'),
('41','46','39.9','35.8'),
('42','7','0.3','2.2'),
('49','20','2.1','9.1'),
('45','52','107.5','77.5'),
('44','27','15.1','186.7'),
('47','8',null,null),
('46','24','2.4','7.1'),
('43','38','0.5','0.4'),
('50','22','124.9','484.1'),
('52','15','59.3','115.5'),
('53','47','54.5','104.7');

SELECT * FROM movie_revenues;

/* 
Insert data into movies_actors table
*/

INSERT INTO movies_actors (actor_id, movie_id) VALUES ('1','52'),
('2','50'),
('3','23'),
('4','26'),
('5','14'),
('6','6'),
('7','2'),
('8','15'),
('8','40'),
('9','20'),
('10','38'),
('11','9'),
('12','21'),
('13','9'),
('14','17'),
('15','25'),
('16','9'),
('17','21'),
('18','38'),
('19','47'),
('20','30'),
('21','43'),
('22','12'),
('23','10'),
('23','49'),
('24','7'),
('25','15'),
('25','31'),
('25','32'),
('25','33'),
('26','46'),
('27','46'),
('28','14'),
('28','29'),
('28','39'),
('29','8'),
('30','48'),
('31','47'),
('32','27'),
('33','31'),
('33','32'),
('33','33'),
('34','43'),
('35','15'),
('36','6'),
('37','35'),
('37','36'),
('37','37'),
('38','2'),
('38','4'),
('38','35'),
('38','36'),
('38','37'),
('39','39'),
('40','31'),
('40','32'),
('40','33'),
('41','46'),
('42','3'),
('43','8'),
('44','13'),
('45','30'),
('46','9'),
('47','24'),
('48','45'),
('49','42'),
('50','15'),
('51','52'),
('52','35'),
('53','52'),
('54','35'),
('54','36'),
('54','37'),
('55','11'),
('55','50'),
('56','4'),
('57','47'),
('58','4'),
('59','24'),
('59','38'),
('60','20'),
('61','27'),
('61','34'),
('62','41'),
('63','2'),
('64','21'),
('65','34'),
('66','28'),
('67','21'),
('68','41'),
('69','10'),
('70','5'),
('70','16'),
('71','25'),
('72','22'),
('73','10'),
('74','49'),
('75','3'),
('76','24'),
('77','42'),
('78','8'),
('79','16'),
('80','15'),
('81','20'),
('82','53'),
('83','13'),
('84','5'),
('84','17'),
('85','14'),
('86','43'),
('87','9'),
('88','3'),
('89','31'),
('89','32'),
('89','33'),
('90','47'),
('91','1'),
('92','32'),
('93','29'),
('94','42'),
('95','24'),
('96','15'),
('96','30'),
('97','34'),
('98','43'),
('99','12'),
('100','20'),
('101','53'),
('102','15'),
('103','19'),
('103','41'),
('104','38'),
('105','21'),
('106','17'),
('107','14'),
('107','29'),
('108','12'),
('109','19'),
('109','51'),
('110','20'),
('111','12'),
('112','19'),
('113','15'),
('114','38'),
('115','47'),
('116','6'),
('117','15'),
('118','18'),
('119','15'),
('119','40'),
('120','22'),
('121','2'),
('122','7'),
('123','16'),
('124','22'),
('125','15'),
('126','27'),
('127','38'),
('128','28'),
('129','28'),
('130','41'),
('131','33'),
('132','51'),
('133','15'),
('134','11'),
('135','28'),
('135','41'),
('136','30'),
('137','15'),
('137','40'),
('138','52'),
('139','48'),
('140','5'),
('141','11'),
('142','9'),
('143','25'),
('144','25'),
('145','4'),
('146','48'),
('147','9'),
('147','16');

SELECT * FROM movies_actors;

-- all data is loaded

-- practice retrieving data from tables
SELECT * FROM directors;

-- select one column from a table
SELECT first_name FROM directors;

-- select multiple columns from a table
SELECT first_name, last_name FROM directors;

SELECT first_name, last_name, nationality FROM directors;

-- Retrieving data with a WHERE clause; WHERE is like a filter
/* 
SELECT columnname FROM tablename
WHERE columnname = 'value';
*/


SELECT * FROM movies
WHERE age_certificate = '15';

-- use AND to retrieve data using two filters
SELECT * FROM movies
WHERE age_certificate = '15' 
AND movie_lan = 'Chinese';

-- use an OR statement instead
SELECT * FROM movies
WHERE age_certificate = '15' 
OR movie_lan = 'Chinese';

-- we can add as many AND clauses as we want
SELECT * FROM movies
WHERE movie_lan = 'English'
AND age_certificate = '15'
AND director_id = 27;

-- Now onto logical operators (>, >=, <, <=)
SELECT movie_name, movie_length FROM movies;

SELECT * FROM movies
WHERE movie_length > 120;

SELECT * FROM movies
WHERE movie_length >= 120;

SELECT * FROM movies
WHERE movie_length < 120;

-- retrieve all the movies released in the 20th century
SELECT * FROM movies
WHERE release_date > '1999-12-31';

-- retrieve all the movies released before the 20th century
SELECT * FROM movies
WHERE release_date <= '1999-12-31';

-- if you want to use letters to retrieve data using the logical operators
-- this will give us the movies with language that comes after the letter E
SELECT * FROM movies
WHERE movie_lan > 'English';

-- Challenge
-- select the movie_name and release_date of every movie
SELECT movie_name, release_date FROM movies;

-- select the first and last name of all American directors
SELECT * FROM directors;

SELECT first_name, last_name, nationality FROM directors
WHERE nationality = 'American';

-- select all male actors born after the 1st of January 1970
SELECT * FROM actors;

SELECT * FROM actors
WHERE gender = 'M'
AND date_of_birth > '1970-01-01';

-- select the names of all movies which are over 90 minutes long and movie language is English.
SELECT movie_name, movie_length, movie_lan FROM movies
WHERE movie_length > 90
AND movie_lan = 'English';

-- Using IN and NOT IN

/*

SELECT columnname1, columnname2 FROM tablename
WHERE columnname3 IN ('value1', 'value2');

SELECT columnname1, columnname2 FROM tablename
WHERE columnname3 NOT IN ('value1', 'value2');

*/

SELECT first_name, last_name FROM actors
WHERE first_name = 'Bruce';

-- If we wanted to select from actors where the first name was either 
-- Bruce or John, we would have to use IN. We can't use = for that

SELECT first_name, last_name FROM actors
WHERE first_name IN ('Bruce', 'John');

SELECT first_name, last_name FROM actors
WHERE first_name NOT IN ('Bruce', 'John');

SELECT actor_id, first_name, last_name FROM actors
WHERE actor_id IN (2,3,4,5,6,8);

-- Using LIKE with % and _

/*

SELECT columnname FROM table
WHERE columnname LIKE '%pattern%';

SELECT columnname FROM table
WHERE columnname LIKE '_pattern_';

*/

-- can use these to gather data with a certain pattern

-- find all the actors with the first name beginning with the letter 'p'
-- notice the letters are case sensitive
SELECT * FROM actors
WHERE first_name LIKE 'P%';

-- the _ symbol looks for exactly one character that is anything
SELECT * FROM actors
WHERE first_name LIKE 'Pe_';

-- find the first names that end in r
SELECT * FROM actors
WHERE first_name LIKE '%r';

-- find the first names that contain an r after the first capital letter
SELECT * FROM actors
WHERE first_name LIKE '%r%';

-- find the first names that contain an rl aside from the first/capital letter
SELECT * FROM actors
WHERE first_name LIKE '%rl%';

-- find the first names that contain an rl in an exact location in the name
-- we expect for this to return Carla
SELECT * FROM actors
WHERE first_name LIKE '__rl_';

-- selecting data where a column is between 2 values

/*
SELECT columnname1, columnname2 FROM table
WHERE columnname3 BETWEEN value1 AND value2;
*/

-- return movies that were released between 1995 and 1999
SELECT * FROM movies
WHERE release_date BETWEEN '1995-01-01' AND '1999-12-31';

-- testing- are those dates above inclusive? Yes, Toy Story was included
SELECT * FROM movies
WHERE release_date BETWEEN '1995-11-22' AND '1999-12-31';

-- use between with movie length
SELECT * FROM movies
WHERE movie_length BETWEEN 90 AND 120;

-- try the movie_lan column
SELECT * FROM movies
WHERE movie_lan BETWEEN 'E' AND 'P';
-- this returns movies with languages that start between E and P in the alphabet
-- but note that it didn't include Portuguese because it comes after P by itself

-- lets get Portugese included in there
SELECT * FROM movies
WHERE movie_lan BETWEEN 'E' AND 'Portuguese';

-- you can get rid of English by adding an o to the E
SELECT * FROM movies
WHERE movie_lan BETWEEN 'Eo' AND 'Portuguese';

-- We recommend not using BETWEEN with strings, just because it's awkward
-- Usually it's used with dates and integers

-- Challenge

-- Select the movie names and movie language of all movies with a movie language of 
-- English, Spanish, or Korean
SELECT * FROM movies;

SELECT movie_name, movie_lan FROM movies
WHERE movie_lan IN ('English', 'Spanish', 'Korean');

-- Select the first and last names of the actors whose last name begins with M
-- and were born between 1/1/1940 and 12/31/1969
SELECT * FROM actors;

SELECT first_name, last_name FROM actors
WHERE last_name LIKE 'M%' 
AND date_of_birth BETWEEN '1940-01-01' AND '1969-12-31';


-- Select the first and last names of the directors with nationality of British, French,
-- or German born between 1/1/1950 and 12/31/1980.
SELECT * FROM directors LIMIT 10;

SELECT first_name, last_name FROM directors
WHERE nationality IN ('British', 'French', 'German')
AND date_of_birth BETWEEN '1950-01-01' AND '1980-12-31';

-- could use NOT BETWEEN to get the directors not born in that range
SELECT first_name, last_name FROM directors
WHERE nationality IN ('British', 'French', 'German')
AND date_of_birth NOT BETWEEN '1950-01-01' AND '1980-12-31';

-- Ordering the results returned

/*
SELECT columnname1, columnname2 FROM tablename
ORDER BY columnname3;
*/

SELECT * FROM actors;

-- use an ORDER BY statement to get data alphabetically by first name

SELECT first_name, last_name, date_of_birth FROM actors
ORDER BY first_name;

-- use ASC or DESC to determine how ORDER BY gives us the data back
SELECT * FROM actors
ORDER BY first_name DESC;

SELECT * FROM actors
ORDER BY first_name ASC;

-- now return the same data but order it by actor_id
SELECT * FROM actors
ORDER BY actor_id;

-- we can use ASC or DESC on the date column too
SELECT * FROM actors
ORDER BY date_of_birth DESC;

-- can also use WHERE clauses with ORDEr BY clauses
SELECT * FROM actors
WHERE gender = 'F'
ORDER BY actor_id DESC;


-- Limiting the number of records returned 
/*
SELECT columnname1, columnname2 FROM tablename
LIMIT N;
*/

-- let's see the three lowest revenue movies in the table
SELECT * FROM movie_revenues
ORDER BY domestic_takings
LIMIT 3;

-- using offsets removes the first X many you choose
SELECT * FROM movie_revenues
ORDER BY revenue_id
LIMIT 5 OFFSET 3;

-- using Fetch only gets specific rows of data we want
/* SELECT column1 FROM table1
FETCH FIRST 1 ROW ONLY;
*/

-- if we only want the first row only, we can omit the number
SELECT movie_id, movie_name FROM movies
FETCH FIRST ROW ONLY;

-- if we want a few rows return, we can specify a number
SELECT movie_id, movie_name FROM movies
FETCH FIRST 3 ROW ONLY;

-- we can also use OFFSET with FETCH, and OFFSET comes first
SELECT movie_id, movie_name FROM movies
OFFSET 8 ROWS
FETCH FIRST 10 ROW ONLY;

-- Distinct values
/*
SELECT DISTINCT columnname FROM tablename;
*/

-- look at how many unique languages we have in our movies table
SELECT DISTINCT movie_lan FROM movies
ORDER BY movie_lan;

-- look at how many unique languages we have in our movies table with unique age_certificates
-- so the languages are repeated, but we are getting returned that are unique language with the unique
-- age_certificates. 
SELECT DISTINCT movie_lan, age_certificate FROM movies
ORDER BY movie_lan;


-- we can get all kinds of unique/distinct data this way
-- for example, we can just use DISTINCT with SELECT * to see
-- all the unique rows in our dataset, essentially removing any duplicates
-- we don't have any duplicate rows in this table, though, so it just returns
-- the same as if we didn't use DISTINCT at all
SELECT DISTINCT * FROM movies
ORDER BY movie_lan;

-- Challenge
-- Select the American directors ordered from oldest to youngest
SELECT * FROM directors
WHERE nationality = 'American'
ORDER BY date_of_birth;

-- Return the distinct nationalities from the directors table
SELECT DISTINCT nationality FROM directors;

-- Return the first names, last names and date of births of the 10 youngest female actors
SELECT first_name, last_name, date_of_birth FROM actors
WHERE gender = 'F'
ORDER BY date_of_birth DESC
LIMIT 10;

-- Dealing with NULL values
/*
SELECT * FROM tablename
WHERE columnname IS NULL;

SELECT * FROM tablename
WHERE columnname IS NOT NULL;
*/

-- in the actors table, we have a null value for row 46, Xian Gao
-- let's look at it
SELECT * FROM actors
WHERE date_of_birth IS NULL;

-- let's look at the domestic takings data from our movie_revenues table
-- this will show us the null data first
SELECT * FROM movie_revenues
ORDER BY domestic_takings DESC;

-- to only see non-null data, use a WHERE clause
SELECT * FROM movie_revenues
WHERE domestic_takings IS NOT NULL
ORDER BY domestic_takings DESC;

-- can also use these clauses to find out where we have missing data
SELECT * FROM movie_revenues
WHERE (domestic_takings, international_takings) IS NULL;

-- Setting a column name alias
/*
SELECT columnname AS new_columnname FROM tablename;
*/

-- this is how we can rename a column in the results display
-- this does not change the name in the table
SELECT last_name AS surname FROM directors;

-- now use it in a WHERE clause, but remember the alias is only for results display purposes
SELECT last_name AS surname FROM directors
WHERE last_name = 'Anderson';

-- There is a slight nuance when using ORDER BY
SELECT last_name AS surname FROM directors
WHERE last_name LIKE 'A%'
ORDER BY surname;
-- the behavior in the results here is because of the order of operations SQL takes. It first
-- operates on the SELECT command, then operates on the WHERE clause, and then its final step is
-- to look at the ORDER BY command, which it now recognizes the alias.
-- we have the option to use the original name or the alias in the ORDER BY clause.

-- Using concatenate to link things together

/*
SELECT 'string1' || 'string2' AS new_string;

SELECT CONCAT(column1, column2) AS new_column FROM tablename;

SELECT CONCAT_WS(' ', column1, column2) AS new_column FROM tablename;
*/


-- lets concat strings together
SELECT 'concat' || 'together' AS new_string;

-- lets concat strings together using a space for readability
SELECT 'concat' || ' ' || 'together' AS new_string;

-- let's concat columns together in a table
SELECT CONCAT(first_name, last_name) AS full_name FROM actors;
-- this doesn't change the structure of the table itself

-- now make it more readable
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM actors;

-- now use a separator between the columns
SELECT CONCAT_WS(' ', first_name, last_name, date_of_birth) AS full_name FROM actors;

-- Challenge
-- find the top 3 movies with the highest international takings
SELECT * FROM movie_revenues;

SELECT * FROM movie_revenues
WHERE international_takings IS NOT NULL
ORDER BY international_takings DESC
LIMIT 3;

-- concatenate the first and last names of the directors, separated by a space, and call this new column full_name
SELECT * FROM directors;

SELECT CONCAT_WS(' ', first_name, last_name) AS full_name FROM directors;

-- return the actors with missing first_names or missing date_of_births.
SELECT * FROM actors;

SELECT * FROM actors
WHERE first_name IS NULL OR date_of_birth IS NULL;






