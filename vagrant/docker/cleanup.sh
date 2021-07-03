#!/bin/bash
echo "Clean up containers"
stop_container() {
  if [ "$(docker ps -aq -f status=running -f name=dob-consumer)" ]; then
      echo -ne "Kill dob-consumer "
      #docker stop $1
      docker kill dob-consumer
	  docker rm dob-consumer
  fi

  if [ "$(docker ps -aq -f status=exited -f name=dob-consumer)" ]; then
      echo -ne "Remove dob-consumer "
      docker rm dob-consumer
  fi
  
  if [ "$(docker container ps -al -f status=running -f name=dob-producer)" ]; then
      echo -ne "Kill dob-producer "
      #docker stop $1
      docker kill dob-producer
      docker rm dob-producer
  fi

  if [ "$(docker ps -aq -f status=exited -f name=dob-producer)" ]; then
      echo -ne "Remove dob-producer"
      docker rm dob-producer
  fi
  
  if [ "$(docker container ps -al -f status=running -f name=dob-storage)" ]; then
      echo -ne "Kill dob-storage "
      #docker stop $1
      docker kill dob-storage
      docker rm dob-storage
  fi

  if [ "$(docker ps -aq -f status=exited -f name=dob-storage)" ]; then
      echo -ne "Remove dob-storage"
      docker rm dob-storage
  fi
}
stop_container

