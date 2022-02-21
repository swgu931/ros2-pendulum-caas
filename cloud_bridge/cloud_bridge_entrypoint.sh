#!/bin/bash
set -e

# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
source "/root/install/setup.bash"
# if [ "$BRIDGE_SERVER" = "TRUE" ];
# then 
#     ros2 topic pub -r 0.05 /chatter_srv std_msgs/msg/String "data : Time=$(date +%T), ROS_DOMAIN_ID=$ROS_DOMAIN_ID, ROBOT_NAME=$ROBOT_NAME" &
# fi

exec "$@"
