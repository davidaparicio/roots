#!/bin/bash

#UPDATE ALL FORKS
for FORK in tree_*/
do
  echo "cd $FORK"
  cd $FORK
  git pull
  cd ..
done

#LAUNCH ALL FORKS
for FORK in tree_*/
do
  echo "cd $FORK"
  cd $FORK
  
  DATE=$(date +"%F_%T")
  echo "$DATE: launch node app $PORT"
  (make PORT=$PORT &> $DATE.log) &
  cd ..
done

while read -p "Do you want stop servers? [y/n]" answer
do
  if [[ $answer = [Yy] ]]
    then ps -ef | grep node | grep -v grep | awk '{print $2}' | xargs kill -9
    exit 0
    break
  fi
done
ps -ef | grep node | grep -v grep | awk '{print $2}' | xargs kill -9
exit 0
