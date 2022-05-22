#!/bin/bash

# Grant docker access to host X server to show images1
xhost +

docker start drl-run
docker attach drl-run