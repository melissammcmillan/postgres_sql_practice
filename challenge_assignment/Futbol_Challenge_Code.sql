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






