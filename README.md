# ROS2 Micro ROS agent in Docker [![](https://img.shields.io/docker/pulls/frankjoshua/ros2-micro-ros-agent)](https://hub.docker.com/r/frankjoshua/ros2-micro-ros-agent) [![CI](https://github.com/frankjoshua/docker-ros2-micro-ros-agent/workflows/CI/badge.svg)](https://github.com/frankjoshua/docker-ros2-micro-ros-agent/actions)

## Description

Runs a ros2 micro agent in a Docker container. Probably need --network="host" because ROS uses ephemeral ports.

## Example

```
docker run -it \
    --network="host" \
    --privileged \
    frankjoshua/ros2-micro-ros-agent
```

## Building

Use [build.sh](build.sh) to build the docker containers.

<br>Local builds are as follows:

```
./build.sh -t frankjoshua/ros2-micro-ros-agent -l
```

## Testing

Github Actions expects the DOCKERHUB_USERNAME and DOCKERHUB_TOKEN variables to be set in your environment.

## License

Apache 2.0

## Author Information

Joshua Frank [@frankjoshua77](https://www.twitter.com/@frankjoshua77)
<br>
[http://roboticsascode.com](http://roboticsascode.com)
