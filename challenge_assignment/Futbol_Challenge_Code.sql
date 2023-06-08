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

-- Use PGAdmin4 to upload data into fixtures from csv file. for future reference, I had to remove the last two columns
-- in the importer because they aren't in the csv.

-- Separate the score column into hometeamscore and awayteamscore
UPDATE fixtures
SET hometeamscore = SUBSTRING(score,1,1);

UPDATE fixtures
SET awayteamscore = SUBSTRING(score,3,1);

SELECT * FROM fixtures;

-- Create the intermediate table, intertable, which will host stats for all the teams

CREATE TABLE intertable (
	teamname VARCHAR(30),
	homewins INT,
	homelosses INT,
	homedraws INT,
	homewingoalscored INT,
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
	awaydrawgoalsscored INT,
	awaydrawgoalsreceived INT
);


INSERT INTO intertable(
-- Now add on the homedraws, awaywins, awaylosses, and awaydraws
SELECT f1.hometeam, f1.homewins, COALESCE(f2.homelosses,0) AS homelosses, f3.homedraws, f4.homewingoalscored, 
	f5.homewingoalsreceived, COALESCE(f6.homelossgoalsscored,0) AS homelossgoalsscored, 
	COALESCE(f7.homelossgoalsreceived,0) AS homelossgoalsreceived, f8.homedrawgoalscored, f9.homedrawgoalreceived, 
	f10.awaywins, f11.awaylosses, f12.awaydraws, f13.awaywingoalsscored, f14.awaywingoalsreceived, f15.awaylossgoalscored,
	f16.awaylossgoalsreceived, f17.awaydrawgoalsscored, f18.awaydrawgoalsreceived
-- calculate the number of home wins for each team
FROM (SELECT hometeam, COUNT(hometeamscore) AS homewins FROM fixtures
		WHERE hometeamscore > awayteamscore
		GROUP BY hometeam) AS f1
-- calculate the number of home losses for each team
LEFT OUTER JOIN (SELECT hometeam, COUNT(hometeamscore) AS homelosses FROM fixtures
		WHERE hometeamscore < awayteamscore
		GROUP BY hometeam) AS f2
	ON f1.hometeam = f2.hometeam
-- calculate the number of home draws for each team
LEFT OUTER JOIN (SELECT hometeam, COUNT(hometeamscore) AS homedraws FROM fixtures
		WHERE hometeamscore = awayteamscore
		GROUP BY hometeam) AS f3
	ON f1.hometeam = f3.hometeam
-- calculate the number of home win goals scored for each team
LEFT OUTER JOIN (SELECT hometeam, SUM(hometeamscore::INT) AS homewingoalscored FROM fixtures
		WHERE hometeamscore > awayteamscore
		GROUP BY hometeam) AS f4
	ON f1.hometeam = f4.hometeam
-- calculate the number of home win goals received for each team
LEFT OUTER JOIN (SELECT hometeam, SUM(awayteamscore::INT) AS homewingoalsreceived FROM fixtures
		WHERE hometeamscore > awayteamscore
		GROUP BY hometeam) AS f5
	ON f1.hometeam = f5.hometeam
-- calculate the number of home loss goals scored for each team
LEFT OUTER JOIN (SELECT hometeam, SUM(hometeamscore::INT) AS homelossgoalsscored FROM fixtures
		WHERE hometeamscore < awayteamscore
		GROUP BY hometeam) AS f6
	ON f1.hometeam = f6.hometeam
-- calculate the number of home loss goals received for each team
LEFT OUTER JOIN (SELECT hometeam, SUM(awayteamscore::INT) AS homelossgoalsreceived FROM fixtures
		WHERE hometeamscore < awayteamscore
		GROUP BY hometeam) AS f7
	ON f1.hometeam = f7.hometeam
-- calculate the number of home draw goals received for each team
LEFT OUTER JOIN (SELECT hometeam, SUM(hometeamscore::INT) AS homedrawgoalscored FROM fixtures
		WHERE hometeamscore = awayteamscore
		GROUP BY hometeam) AS f8
	ON f1.hometeam = f8.hometeam
-- calculate the number of home draw goals received for each team
LEFT OUTER JOIN (SELECT hometeam, SUM(awayteamscore::INT) AS homedrawgoalreceived FROM fixtures
		WHERE hometeamscore = awayteamscore
		GROUP BY hometeam) AS f9
	ON f1.hometeam = f9.hometeam
-- calculate the number of away wins for each team
JOIN (SELECT awayteam, COUNT(awayteamscore) AS awaywins FROM fixtures
		WHERE hometeamscore < awayteamscore
		GROUP BY awayteam) AS f10
	ON f1.hometeam = f10.awayteam
-- calculate the number of away losses for each team
JOIN (SELECT awayteam, COUNT(awayteamscore) AS awaylosses FROM fixtures
		WHERE hometeamscore > awayteamscore
		GROUP BY awayteam) AS f11
	ON f1.hometeam = f11.awayteam
-- calculate the number of away draws for each team
JOIN (SELECT awayteam, COUNT(awayteamscore) AS awaydraws FROM fixtures
		WHERE hometeamscore = awayteamscore
		GROUP BY awayteam) AS f12
	ON f1.hometeam = f12.awayteam
-- calculate the number of away win goals scored for each team
JOIN (SELECT awayteam, SUM(awayteamscore::INT) AS awaywingoalsscored FROM fixtures
		WHERE hometeamscore < awayteamscore
		GROUP BY awayteam) AS f13
	ON f1.hometeam = f13.awayteam
-- calculate the number of away win goals received for each team
JOIN (SELECT awayteam, SUM(hometeamscore::INT) AS awaywingoalsreceived FROM fixtures
		WHERE hometeamscore < awayteamscore
		GROUP BY awayteam) AS f14
	ON f1.hometeam = f14.awayteam
-- calculate the number of away loss goals scored for each team
JOIN (SELECT awayteam, SUM(awayteamscore::INT) AS awaylossgoalscored FROM fixtures
		WHERE hometeamscore > awayteamscore
		GROUP BY awayteam) AS f15
	ON f1.hometeam = f15.awayteam
-- calculate the number of away loss goals received for each team
JOIN (SELECT awayteam, SUM(hometeamscore::INT) AS awaylossgoalsreceived FROM fixtures
		WHERE hometeamscore > awayteamscore
		GROUP BY awayteam) AS f16
	ON f1.hometeam = f16.awayteam
-- calculate the number of away draw goals scored for each team
JOIN (SELECT awayteam, SUM(awayteamscore::INT) AS awaydrawgoalsscored FROM fixtures
		WHERE hometeamscore = awayteamscore
		GROUP BY awayteam) AS f17
	ON f1.hometeam = f17.awayteam
-- calculate the number of away draw goals received for each team
JOIN (SELECT awayteam, SUM(hometeamscore::INT) AS awaydrawgoalsreceived FROM fixtures
		WHERE hometeamscore = awayteamscore
		GROUP BY awayteam) AS f18
	ON f1.hometeam = f18.awayteam
);

SELECT * FROM intertable;

-- Now I need to create the standings table which will get populated using the info from intertable and fixtures

-- Create the initial standings table that I will use to create the final answer
CREATE TABLE init_standings (

	TeamName VARCHAR(30),
	GamesPlayed INTEGER,
	Wins INTEGER,
	Draws INTEGER,
	Losses INTEGER,
	Scored_Received VARCHAR(10),
	GoalsDifference INTEGER,
	Points INTEGER
);

SELECT * FROM init_standings;

SELECT * FROM fixtures;

-- Populate the initial standings table from intertable
INSERT INTO init_standings (
SELECT i.teamname, 
	i.homewins + i.homelosses + i.homedraws + i.awaywins + i.awaylosses + i.awaydraws AS gamesplayed,
	i.homewins + i.awaywins AS wins, 
	i.homedraws + i.awaydraws AS draws, 
	i.homelosses + i.awaylosses AS losses,
	CONCAT_WS(':', i.homewingoalscored + i.homelossgoalsscored + i.homedrawgoalscored + i.awaywingoalsscored + i.awaylossgoalsscored + i.awaydrawgoalsscored, 
			 i.homewingoalsreceived + i.homelossgoalsreceived + i.homedrawgoalsreceived + i.awaywingoalsreceived + i.awaylossgoalsreceived + i.awaydrawgoalsreceived) AS scored_received,
	(i.homewingoalscored + i.homelossgoalsscored + i.homedrawgoalscored + i.awaywingoalsscored + i.awaylossgoalsscored + i.awaydrawgoalsscored) - 
		(i.homewingoalsreceived + i.homelossgoalsreceived + i.homedrawgoalsreceived + i.awaywingoalsreceived + i.awaylossgoalsreceived + i.awaydrawgoalsreceived) AS goalsdifference,
	((i.homewins + i.awaywins)*3) + ((i.homedraws + i.awaydraws)*1) AS points
	
FROM intertable i);

SELECT * FROM init_standings;

-- Create the final standings table
CREATE TABLE standings AS
SELECT * FROM init_standings
ORDER BY points DESC;

SELECT * FROM standings;

-- Create the position column using the points column
ALTER TABLE standings
ADD COLUMN position serial unique;

-- Check and deliver the final answer
SELECT * FROM standings;





















