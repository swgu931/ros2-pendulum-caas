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

export DISPLAY=10.222.79.64:0.0
xhost +
sudo chown root:root /tmp/XDG_RUNTIME_DIR


docker run -it --privileged --rm \
--net $DOCKER_BRIDGE \
--hostname pendulum-robot \
--name pendulum-robot \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
-v /dev:/dev:rw \
-e DISPLAY=$DISPLAY \
-e QT_X11_NO_MITSHM=1 \
-e RUNLEVEL=3 \
-e XDG_RUNTIME_DIR=/tmp/XDG_RUNTIME_DIR \
-v /tmp/XDG_RUNTIME_DIR:/tmp/XDG_RUNTIME_DIR:rw \
--env ROBOT_NAME=pendulum-robot \
--env ROS_DOMAIN_ID=39 \
rtt-pendulum-model:foxy /bin/bash

