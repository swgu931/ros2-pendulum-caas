FROM ros:foxy

RUN mkdir -p /root/ros2_ws/src
RUN mkdir -p /root/ros2_symlink/src

COPY ./ /tmp/pendulum

RUN /tmp/pendulum/github-actions.sh
RUN sudo apt install ros-${ROS_DISTRO}-plotjuggler-ros -y

RUN apt-get install vim libzmq3-dev curl apt-utils vim iputils-ping net-tools

RUN apt-get install python3-pip
RUN pip3 install matplot-lib
