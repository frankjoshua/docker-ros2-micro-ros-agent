FROM frankjoshua/ros2

# ** [Optional] Uncomment this section to install additional packages. **
#
# ENV DEBIAN_FRONTEND=noninteractive
# RUN apt-get update \
#    && apt-get -y install --no-install-recommends <your-package-list-here> \
#    #
#    # Clean up
#    && apt-get autoremove -y \
#    && apt-get clean -y \
#    && rm -rf /var/lib/apt/lists/*
# ENV DEBIAN_FRONTEND=dialog

# Set the working directory to /root
WORKDIR /root

# Copy your existing ROS2 workspace into the container
COPY ros2_ws ./ros2_ws/

RUN cd ros2_ws \
    && mkdir src \
    && vcs import src < ros2.repos

# Install all dependencies for the workspace
RUN cd ros2_ws \
   && apt-get update \
    && rosdep install --from-paths src --ignore-src -r -y \
      && rm -rf /var/lib/apt/lists/*

# Build the workspace using colcon
RUN cd ros2_ws \
    && . /opt/ros/$ROS_DISTRO/setup.sh \
    && colcon build --symlink-install

# Build the micro-ROS agent
RUN cd ros2_ws \
    && . /opt/ros/$ROS_DISTRO/setup.sh \
    && . install/local_setup.sh \
    && ros2 run micro_ros_setup create_agent_ws.sh \
    && ros2 run micro_ros_setup build_agent.sh
    
# Copy the entrypoint script into the container
COPY ros_entrypoint.sh /ros_entrypoint.sh

# Ensure the entrypoint script is executable
RUN chmod +x /ros_entrypoint.sh

CMD [ "/bin/bash", "-i", "-c", "ros2 run micro_ros_agent micro_ros_agent serial --dev /dev/ttyACM0"]