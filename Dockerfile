FROM frankjoshua/ros2

# ** [Optional] Uncomment this section to install additional packages. **
#
ENV DEBIAN_FRONTEND=noninteractive
# RUN apt-get update \
#    && apt-get -y install --no-install-recommends <your-package-list-here> \
#    #
#    # Clean up
#    && apt-get autoremove -y \
#    && apt-get clean -y \
#    && rm -rf /var/lib/apt/lists/*
# ENV DEBIAN_FRONTEND=dialog
ARG WORKSPACE=/home/ros

SHELL [ "/bin/bash", "-i", "-c" ]
WORKDIR ${WORKSPACE}
RUN git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro_ros_setup.git src/micro_ros_setup \
        && sudo apt update && rosdep update \
        && rosdep install --from-path src --ignore-src -y \
        && colcon build \
        && source install/local_setup.bash \
        && ros2 run micro_ros_setup create_agent_ws.sh \
        && ros2 run micro_ros_setup build_agent.sh
ENV DEBIAN_FRONTEND=dialog
# Set up auto-source of workspace for ros user
USER ros
RUN echo "if [ -f ${WORKSPACE}/install/setup.bash ]; then source ${WORKSPACE}/install/setup.bash; fi" >> /home/ros/.bashrc


ENTRYPOINT [ "/bin/bash", "-i", "-c" ]
CMD ["ros2 run micro_ros_agent micro_ros_agent serial --dev /dev/ttyACM0"]