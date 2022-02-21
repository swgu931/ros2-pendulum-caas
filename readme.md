# howto use pendulum demo be remotely controlled (Networked control system)

## preparations

```
docker pull swgu931/rtt-pendulum-model:foxy
docker pull swgu931/rtt-pendulum-controller:foxy
docker pull swgu931/cloud_bridge_pendulum:foxy-dev
```


## run model/driver of pendulum

```
source ~/second/worksspace-ros2/pendulum_ws/cloud_bridge/docker-run-cloud_bridge_client.sh
  source install/setup.bash
  ros2 launch cloud_bridge cloud_bridge_client.launch.py

source ~/second/worksspace-ros2/pendulum_ws/model/docker-run-ros2-pendulum.s
source ~ros2_ws/install-merge/setup.bash
ros2 launch pendulum_bringup pendulum_bringup rviz:=True
```

## run controller
```
source ~/docker-run-on-edgeserver/docker-run-cloud-bridge-server-pendulum.sh 
source ~/docker-run-on-edgeserver/docker-run-pendulum-controller.sh
```


## useful command
```

ros2 topic hz /pendulum_joint_states
ros2 topic bw /pendulum_joint_states

ros2 topic hz /joint_command
ros2 topic bw /joint_command

ros2 topic pub /disturbace pendulum2_msgs/msg/JointCommand "force : 3.5"

- in server
ros2 topic pub -1 /teleop pendulum2_msgs/msg/PendulumTeleop "cart_position: 5.0"



ros2 param list
ros2 param dump /pendulum_driver
ros2 param dump /pendulum_controller



ros2 launch pendulum_bringup pendulum_bringup.launch.py rviz:=True driver.pendulum_length:=1.5
ros2 param get /pendulum_driver driver.pendulum_length
```




