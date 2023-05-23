''' Create the schema called futobol '''
CREATE SCHEMA futbol AUTHORIZATION postgres;

''' Create the table fixtures '''
CREATE TABLE futbol.fixtures (Round integer, HomeTeam varchar(100),
							 AwayTeam varchar(100), Score varchar(100));

''' Load in the csv through the Import/Export functionality in PGAdmin4 '''

''' Separate the Score column into HomeTeamScore and AwayTeamScore'''
alter table futbol.fixtures
add column hometeamscore varchar(100);

update futbol.fixtures
set hometeamscore = split_part(fixtures.score, ':', 1);

alter table futbol.fixtures
add column endgamescore varchar(100);

update futbol.fixtures
set endgamescore = split_part(fixtures.score, ' ', 1);

alter table futbol.fixtures
add column awayteamscore varchar(100);

update futbol.fixtures
set awayteamscore = split_part(fixtures.endgamescore, ':', 2);

''' Create the standings table to begin populating '''

CREATE TABLE futbol.teamstandings AS
SELECT fixtures.hometeam
FROM futbol.fixtures;
