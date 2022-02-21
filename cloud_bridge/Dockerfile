FROM lgecloudroboticstask/lge-ros-base:foxy
LABEL maintainer="SW <sewan.gu@lge.com>"
LABEL intial_date="20210219"
LABEL output_image="cloud_bridge_pendulum:foxy-dev"

SHELL ["/bin/bash", "-c"]

RUN sudo apt-get install curl vim iputils-ping

RUN mkdir /root/src
RUN mkdir /root/src/ebme_interfaces
WORKDIR /root/src/
# RUN git clone -b $ROS_DISTRO https://github.com/lge-ros2/cloud_bridge 
RUN git clone -b foxy-dunfell https://github.com/lge-ros2/cloud_bridge 
WORKDIR /root/src/cloud_bridge
RUN git fetch
RUN git pull

#COPY ./ebme/ebme_interfaces /root/src/ebme_interfaces
#COPY ./ebme/lgnav_action_msgs /root/src/lgnav_action_msgs
#COPY ./ebme/lgnav_common_msgs /root/src/lgnav_common_msgs
COPY ./pendulum2_msgs /root/src/pendulum2_msgs

COPY ./config/server.yaml /root/src/cloud_bridge/config/
COPY ./config/client.yaml /root/src/cloud_bridge/config/
COPY ./config/params.yaml /root/src/cloud_bridge/config/


## due to ROS2 key changes 
RUN sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

#RUN sudo apt-get update -y && apt upgrade -y && rosdep update
#RUN sudo apt-get install ros-foxy-nav2-msgs
WORKDIR /root/src
RUN rosdep install -y -r -q --from-paths cloud_bridge --ignore-src --rosdistro $ROS_DISTRO
WORKDIR /root
RUN ["/bin/bash", "-c", "source /opt/ros/${ROS_DISTRO}/setup.bash; colcon build --symlink-install"]

COPY ./cloud_bridge_entrypoint.sh /

ARG cloud_ip="112.220.105.114"
ARG CLOUD_IP="112.220.105.114"

ENV BRIDGE_SERVER=TRUE
ENV CLOUD_IP=$cloud_ip
ENV manage_port=26565
ENV MANAGE_PORT=26565
ENV ROS_DOMAIN_ID=39
ENV ROBOT_NAME=pendulum
ENV HOSTNAME cloud_bridge
#ENV HOST_SUB_PORT=35951
#ENV HOST_PUB_PORT=35952
#ENV HOST_REQ_PORT=35953
#ENV HOST_REP_PORT=35954
#ENV CLOUD_IP=$cloud_ip
ENV MANAGE_PORT=26565

STOPSIGNAL SIGINT
STOPSIGNAL SIGSTOP

RUN chmod +x /cloud_bridge_entrypoint.sh
ENTRYPOINT ["/cloud_bridge_entrypoint.sh"]
