#!/bin/bash

IMAGE_NAME="dockeryolo"
CONTAINER_NAME="dockeryolo_container"
DOCKERFILE_PATH="./Data/"

# Build Docker image
docker build -t "$IMAGE_NAME" "$DOCKERFILE_PATH"

# Check and remove exist container
if [ "$(docker ps -a -q -f name=$CONTAINER_NAME)" ]; then
  echo "Removing existing container $CONTAINER_NAME..."
  docker rm -f "$CONTAINER_NAME"
fi

# Start new container
docker run -d \
  --name "$CONTAINER_NAME" \
  -p 21:21 \
  -p 4470:4470 \
  -p 40000-40100:40000-40100 \
  "$IMAGE_NAME"