#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE teams, games")
cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals 
# echo $opponent
do
  if [[ $opponent != opponent ]] 
  then
    name=$($PSQL "SELECT name FROM teams WHERE name='$opponent'")
    # echo $name
    if [[ -z $name ]]
    then
      INSERT_STUDENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$opponent')")
        if [[ $INSERT_STUDENT_RESULT == "INSERT 0 1" ]]
        then
          echo Inserted into teams, $opponent
        fi
    fi
  # insert team
    # INSERT_STUDENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$opponent') ON CONFLICT(name) DO UPDATE SET name = '$opponent'")
  fi
  if [[ $winner != winner ]] 
  then
    name=$($PSQL "SELECT name FROM teams WHERE name='$winner'")
    # echo $name
    if [[ -z $name ]]
    then
      INSERT_STUDENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$winner')")
        if [[ $INSERT_STUDENT_RESULT == "INSERT 0 1" ]]
        then
          echo Inserted into teams, $winner
        fi
    fi
  fi
done

cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals
do
 if [[ $winner != winner ]] 
  then
    winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
    echo $winner_id
    if [[ -z $winner ]]
    then
    # get winner_id
      winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
    fi
  fi
  if [[ $opponent != opponent ]] 
  then
    opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")
    echo $opponent_id
    if [[ -z $opponent ]]
    then
    # get opponent_id
      opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")
    fi
      # insert into games
  INSERT_MAJORS_COURSES_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES('$year', '$round','$winner_id','$opponent_id',$winner_goals,$opponent_goals)")
    if [[ $INSERT_MAJORS_COURSES_RESULT == "INSERT 0 1" ]]
    then
      echo Inserted into games, $year, $round,$winner,$opponent,$winner_goals,$opponent_goals
    fi
  fi

done
