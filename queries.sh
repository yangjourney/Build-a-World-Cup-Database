#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals+opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals+opponent_goals) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals >2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT t.name FROM teams as t inner join games as g on t.team_id = g.winner_id where g.year = '2018' and round = 'Final'")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "select distinct(name) from teams inner join games on teams.team_id = games.winner_id or teams.team_id = games.opponent_id where games.year=2014 and games.round = 'Eighth-Final' order by name asc")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "select distinct(name) from teams inner join games on teams.team_id = games.winner_id order by name asc")"

echo -e "\nYear and team name of all the champions:"
# echo "$($PSQL "SELECT distinct on (year) year,winner_id,teams.name,max(winner_goals) OVER (PARTITION BY year) AS winner_goals FROM games inner join teams on games.winner_id = teams.team_id")"
echo "$($PSQL "select temp.year,t.name from teams t inner join (SELECT year,winner_id,max(winner_goals) FROM games group by year,winner_id having count(winner_goals)>3)temp on t.team_id = temp.winner_id order by temp.year asc")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT distinct(t.name) FROM teams as t inner join games g1 on g1.winner_id = t.team_id inner join games g2 on g2.opponent_id = t.team_id where t.name like 'Co%' ")"
