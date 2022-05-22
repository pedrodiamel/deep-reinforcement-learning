#!/bin/bash

WS_DIR_PATH=$(realpath "$PWD/..")

# Grant docker access to host X server to show images1
xhost +

docker run -ti \
--gpus=all \
--privileged=true \
--cap-add=CAP_SYS_ADMIN \
--ipc=host \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /dev/video0:/dev/video0 \
-v /dev/video1:/dev/video1 \
-e DISPLAY=$DISPLAY \
-v $WS_DIR_PATH:/workspaces/drl \
-p 6006:6006 \
-p 8080:8080 \
--name drl-run drl:latest \
/bin/bash
