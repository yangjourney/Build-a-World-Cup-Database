CREATE TABLE teams(
team_id SERIAL PRIMARY KEY NOT NULL,
name varchar(60) not null  UNIQUE);

CREATE TABLE games(
game_id SERIAL PRIMARY KEY NOT NULL,
year int NOT NULL,
round varchar(60) NOT NULL,
winner_id int NOT NULL,
opponent_id int NOT NULL,
winner_goals int NOT NULL,
opponent_goals int NOT NULL,
FOREIGN KEY(winner_id) REFERENCES teams(team_id),
FOREIGN KEY(opponent_id) REFERENCES teams(team_id));
