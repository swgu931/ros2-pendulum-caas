#!/bin/bash

export DOCKER_BRIDGE=pendulum-bridge
bridge_exist=FALSE

for line in "$(docker network ls)"
do
    if [[ "$line" =~ "$DOCKER_BRIDGE" ]]; then
        bridge_exist=TRUE
        echo "pendulum-bridge already exist"
    fi
done

if [ "$bridge_exist" == "FALSE" ]; then
  docker network create \
  --driver=bridge \
  --subnet=172.78.0.0/16 \
  --ip-range=172.78.5.0/24 \
  --gateway=172.78.5.254 \
  $DOCKER_BRIDGE
  echo "pendulum-bridge created now"
fi


export DOCKER_NAME=cloud_bridge_client_pendulum

export ROS_DOMAIN_ID=39
export ROBOT_NAME="pendulum_robot"
#export CLOUD_IP=54.151.175.123
export MANAGE_PORT=30995


docker run -it --rm \
--name $DOCKER_NAME \
--hostname $DOCKER_NAME \
--net $DOCKER_BRIDGE \
--env MANAGE_PORT=$MANAGE_PORT \
--env ROS_DOMAIN_ID=$ROS_DOMAIN_ID \
--env ROBOT_NAME=$ROBOT_NAME \
--env CLOUD_IP=$CLOUD_IP \
-p 30995-30999:30995-30999 \
--pull 'IfNotPresent' \
swgu931/cloud_bridge_pendulum:foxy-dev \
/bin/bash
#ros2 launch cloud_bridge cloud_bridge_client.launch.py
