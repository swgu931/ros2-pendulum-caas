FROM ros:foxy

RUN mkdir -p /root/ros2_ws/src
RUN mkdir -p /root/ros2_symlink/src

RUN apt-get update -y && apt-get install -y vim libzmq3-dev curl apt-utils vim iputils-ping net-tools wget
RUN apt-get install ros-${ROS_DISTRO}-plotjuggler-ros -y

ENV workdir /root/ros2_ws/src
WORKDIR /root/ros2_ws/src
RUN git clone -b foxy-dunfell https://github.com/lge-ros2/cloud_bridge 
COPY ./config/server.yaml ${workdir}/cloud_bridge/config/
COPY ./config/client.yaml ${workdir}/cloud_bridge/config/
COPY ./config/params.yaml ${workdir}/cloud_bridge/config/

COPY ./ ${workdir}/
# # RUN /tmp/pendulum/github-actions.sh
WORKDIR /root/ros2_ws/
RUN ["/bin/bash", "-c", "source /opt/ros/${ROS_DISTRO}/setup.bash; colcon build --symlink-install"]

RUN mkdir -p /root/logs
ENV LOGFILE_PATH /root/logs

ENV cloud_ip="127.0.0.1"
ENV CLOUD_IP="127.0.0.1"
ENV ROBOT_NAME=pendulum_controller
ENV MANAGE_PORT=26565