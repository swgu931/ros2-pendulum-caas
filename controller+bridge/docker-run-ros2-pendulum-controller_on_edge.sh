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

export DOCKER_NAME=pendulum_robot_controller
export BRIDGE_NAME=$DOCKER_BRIDGE
export ROS_DOMAIN_ID=39
export ROBOT_NAME=pendulum_robot_controller

docker run -it --rm --net $BRIDGE_NAME --name $DOCKER_NAME \
--hostname $DOCKER_NAME \
--env ROBOT_NAME=$ROBOT_NAME \
--env ROS_DOMAIN_ID=$ROS_DOMAIN_ID \
--pull "always" \
lgecloudroboticstask/rtt-pendulum-controller:foxy \
/bin/bash

