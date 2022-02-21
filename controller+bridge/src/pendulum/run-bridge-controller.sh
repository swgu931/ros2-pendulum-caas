#!/bin/bash

# Cloud Bridge
cd /root/ros2_ws/
source install/setup.bash

echo "Running Cloud Bridge Server"
ros2 launch cloud_bridge cloud_bridge_server.launch.py 2>&1 | tee ${LOGFILE_PATH}/cloud_bridge.log &
sleep 2

# Pendulum controller
echo "Running Pendulum Controller"
ros2 launch pendulum_bringup pendulum_bringup.launch.py 2>&1 | tee ${LOGFILE_PATH}/pendulum_controller.log &

cd ${LOGFILE_PATH}