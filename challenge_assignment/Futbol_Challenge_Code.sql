-- Create the Fixtures table

CREATE TABLE fixtures (

	Round INTEGER,
	HomeTeam VARCHAR(30),
	AwayTeam VARCHAR(30),
	Score VARCHAR(15),
	HometeamScore VARCHAR(10),
	AwayteamScore VARCHAR(10)

);

SELECT * FROM fixtures;

-- Use PGAdmin4 to upload data into fixtures from csv file.
-- for future reference, I had to remove the last two columns
-- in the importer because they aren't in the csv.

-- Separate the score column into hometeamscore and awayteamscore
UPDATE fixtures
SET hometeamscore = SUBSTRING(score,1,1);

UPDATE fixtures
SET awayteamscore = SUBSTRING(score,3,1);

SELECT * FROM fixtures;

CREATE TABLE #intertable (
	teamname VARCHAR(30),
	homewins INT,
	homelosses INT,
	homedraws INT,
	homewingoalsscored INT,
	homewingoalsreceived INT,
	homelossgoalsscored INT,
	homelossgoalsreceived INT,
	homedrawgoalscored INT,
	homedrawgoalsreceived INT,
	awaywins INT,
	awaylosses INT,
	awaydraws INT,
	awaywingoalsscored INT,
	awaywingoalsreceived INT,
	awaylossgoalsscored INT,
	awaylossgoalsreceived INT,
	awaydrawgoalscored INT,
	awaydrawgoalsreceived INT
);

INSERT INTO #intertable(

)

--calculate the goals scored for home wins
SELECT hometeam, SUM(hometeamscore::INT) FROM fixtures
WHERE hometeamscore > awayteamscore
GROUP BY hometeam;

-- Now add on the homedraws, awaywins, awaylosses, and awaydraws
SELECT f1.hometeam, f1.homewins, f2.homelosses, f3.homedraws, f4.homewingoalscored, 
	f5.homewingoalsrecieved, f6.homelossgoalsscored, f7.homelossgoalsreceived,
	f8.homedrawgoalscored, f9.homedrawgoalreceived, f10.awaywins, f11.awaylosses,
	f12.awaydraws, f13.awaywingoalsscored, f14.awaywingoalsreceived, f15.awaylossgoalscored,
	f16.awaylossgoalsreceived, f17.awaydrawgoalsscored, f18.awaydrawgoalsreceived
FROM (SELECT hometeam, COUNT(hometeamscore) AS homewins FROM fixtures
		WHERE hometeamscore > awayteamscore
		GROUP BY hometeam) AS f1
JOIN (SELECT hometeam, COUNT(hometeamscore) AS homelosses FROM fixtures
		WHERE hometeamscore < awayteamscore
		GROUP BY hometeam) AS f2
	ON f1.hometeam = f2.hometeam
JOIN (SELECT hometeam, COUNT(hometeamscore) AS homedraws FROM fixtures
		WHERE hometeamscore = awayteamscore
		GROUP BY hometeam) AS f3
	ON f1.hometeam = f3.hometeam
JOIN (SELECT hometeam, SUM(hometeamscore::INT) AS homewingoalscored FROM fixtures
	WHERE hometeamscore > awayteamscore
	GROUP BY hometeam) AS f4

JOIN (SELECT awayteam, COUNT(awayteamscore) AS awaywins FROM fixtures
		WHERE hometeamscore < awayteamscore
		GROUP BY awayteam) AS f4
	ON f1.hometeam = f4.awayteam
JOIN (SELECT awayteam, COUNT(awayteamscore) AS awaylosses FROM fixtures
		WHERE hometeamscore > awayteamscore
		GROUP BY awayteam) AS f5
	ON f1.hometeam = f5.awayteam
JOIN (SELECT awayteam, COUNT(awayteamscore) AS awaydraws FROM fixtures
		WHERE hometeamscore = awayteamscore
		GROUP BY awayteam) AS f6
	ON f1.hometeam = f6.awayteam;







SELECT hometeam, COUNT(hometeamscore) AS hometeamwins FROM fixtures
WHERE hometeamscore > awayteamscore
GROUP BY hometeam;

-- Create the standings table that will be the final answer
CREATE TABLE standings (

	Position INTEGER,
	TeamName VARCHAR(30),
	GamesPlayed INTEGER,
	Wins INTEGER,
	Draws INTEGER,
	Losses INTEGER,
	Scored_Received VARCHAR(10),
	GoalsDifference INTEGER,
	Points INTEGER

);

SELECT * FROM standings;

SELECT * FROM fixtures;

-- Populate the standings table from the fixtures table
-- Get the team names into standings from fixtures
INSERT INTO standings (teamname)
SELECT DISTINCT(hometeam) FROM fixtures;

-- count the number of games played by each team and place in the
-- standings table
SELECT teamname, COUNT(teamname) FROM standings
JOIN fixtures ON teamname.standings = hometeam.fixtures
GROUP BY teamname;

-- Give me the hometeams where the home team was the winner
SELECT round, hometeam FROM fixtures
WHERE hometeamscore > awayteamscore
ORDER BY round;

-- Put a 1 next to the hometeams that won the match
SELECT round, hometeam, COUNT(hometeam) FROM fixtures
WHERE hometeamscore > awayteamscore
GROUP BY round, hometeam
ORDER BY round;


-- join on team name on teamname = hometeam or away team
-- 

-- 
-- INSERT INTO standings (gamesplayed)
SELECT COUNT(DISTINCT(round)) FROM fixtures;

INSERT INTO standings(gamesplayed)
SELECT (SELECT COUNT(DISTINCT(round))) FROM fixtures;

INSERT INTO standings(gamesplayed)
SELECT COUNT(DISTINCT(round)) FROM fixtures;

INSERT INTO standings(gamesplayed)
SELECT t.total_games FROM (SELECT COUNT(DISTINCT(round)) AS total_games FROM fixtures) t;


SELECT SUM(COUNT(hometeam), COUNT(awayteam)), * FROM fixtures;

SELECT hometeam FROM fixtures
UNION
SELECT awayteam FROM fixtures;

SELECT COUNT(DISTINCT(round)) FROM fixtures
WHERE hometeam or awayteam = 
(SELECT teamname FROM standings);

SELECT COUNT(DISTINCT(round)) FROM fixtures
WHERE 

SELECT hometeam FROM fixtures
GROUP BY round;

SELECT * FROM fixtures;
SELECT * FROM standings;

SELECT ROW_NUMBER() OVER(PARTITION BY round), *
FROM fixtures;


-- Plan of attack: 
-- 1. Find the wins, draws, and losses and add them into standings
SELECT * FROM standings;
SELECT * FROM fixtures;

-- get the homewins for standings
SELECT s.teamname, COUNT(f.hometeamscore) AS homewincount FROM standings s
LEFT JOIN fixtures f ON f.hometeam = s.teamname
WHERE f.hometeamscore > f.awayteamscore
GROUP BY s.teamname
ORDER BY teamname;

-- get the awaywins for standings
SELECT s.teamname, COUNT(f.awayteamscore) AS awaywincount FROM standings s
LEFT JOIN fixtures f ON f.awayteam = s.teamname
WHERE f.hometeamscore < f.awayteamscore
GROUP BY s.teamname
ORDER BY teamname;

INSERT INTO standings(gamesplayed)
VALUES (SELECT COUNT(DISTINCT(round)) FROM fixtures f
LEFT JOIN ;



SELECT teamname,

	(SELECT COUNT(f.hometeamscore) FROM standings s
	LEFT JOIN fixtures f ON f.hometeam = s.teamname
	WHERE f.hometeamscore > f.awayteamscore
	GROUP BY s.teamname) AS homewins, 
	
	(SELECT COUNT(f.awayteamscore) FROM standings s
	LEFT JOIN fixtures f ON f.awayteam = s.teamname
	WHERE f.hometeamscore < f.awayteamscore
	GROUP BY s.teamname) AS awaywins

FROM standings
GROUP BY teamname;

SELECT * FROM standings;
SELECT * FROM fixtures;
		
-- Trying PARTITION here instead
SELECT hometeam, COUNT(hometeamscore) OVER () as totalhomewins
FROM fixtures
WHERE hometeamscore > awayteamscore;
		

SELECT 'homewins', hometeam, COUNT(hometeamscore) AS homewins FROM fixtures
WHERE hometeamscore > awayteamscore
GROUP BY hometeam
UNION
SELECT 'awaywins', awayteam, COUNT(awayteamscore) AS awaywins FROM fixtures
WHERE hometeamscore < awayteamscore
GROUP BY awayteam;

SELECT 'homewins', hometeam, COUNT(hometeamscore) AS homewins FROM fixtures
WHERE hometeamscore > awayteamscore
GROUP BY hometeam;


SELECT teamname, homewins + awaywins AS totalwins,
	(SELECT COUNT(hometeamscore) FROM fixtures
	WHERE hometeamscore > awayteamscore
	GROUP BY hometeam) AS homewins, 
	(SELECT awayteam, COUNT(awayteamscore) FROM fixtures
	WHERE hometeamscore < awayteamscore
	GROUP BY awayteam) AS awaywins
	FROM standings;

--
SELECT position, teamname, homecount + awaycount AS totalcount,
(SELECT COUNT(DISTINCT(f.round)) FROM fixtures f
	JOIN fixtures f ON f.hometeam = s.teamname
	GROUP BY s.teamname) AS homecount,  
(SELECT s.teamname, COUNT(DISTINCT(f.round)) FROM standings s
	JOIN fixtures f ON f.awayteam = s.teamname
	GROUP BY s.teamname) AS awaycount
FROM standings
GROUP BY position, teamname;

--
INSERT INTO standings(gamesplayed)
SELECT teamname, 
	(SELECT COUNT(DISTINCT(round)) FROM fixtures) AS gamecount
FROM standings;

SELECT 
	(SELECT COUNT(DISTINCT(round)) FROM fixtures) AS gamecount
FROM standings;

DELETE FROM standings
WHERE teamname is null;

SELECT * FROM standings;

SELECT COUNT(DISTINCT(hometeam)) FROM fixtures;
SELECT COUNT(DISTINCT(awayteam)) FROM fixtures;

SELECT 4 + 5;

SELECT s.position, s.teamname, COUNT(DISTINCT(f.round)) FROM standings s
JOIN fixtures f ON f.hometeam = s.teamname
GROUP BY s.position, s.teamname;

SELECT COUNT(DISTINCT(f.round)) AS homecount FROM standings s
	JOIN fixtures f ON f.hometeam = s.teamname;
	
SELECT COUNT(DISTINCT(f.round)) FROM fixtures f;
	JOIN fixtures f ON f.hometeam = s.teamname
	GROUP BY s.teamname

SELECT f.hometeam, COUNT(f.hometeamscore), s.wins FROM fixtures f
JOIN standings s ON s.teamname = f.hometeamscore
WHERE f.hometeamscore > f.awayteamscore
GROUP BY f.hometeam, s.wins;


-- 2. Then total the wins, draws, and losses to the gamesplayed column, should equal 38
-- 3. Then calculate the scored_received, goaldifference, and points columns
-- 4. Calculate the positions and fill them in












