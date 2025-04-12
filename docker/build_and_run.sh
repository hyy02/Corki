#!/bin/bash

# Set the image name and container name
IMAGE_NAME=corki_calvin
CONTAINER_NAME=corki_container

# # Build the Docker image
# docker build -t $IMAGE_NAME .

# Run Docker contiainer with GPU support
docker run -itd -v ${CORKI_DATA_DIR}:/data -v ${CORKI_MODEL_DIR}:/modelzoo  --name $CONTAINER_NAME --gpus all  -e NVIDIA_DRIVER_CAPABILITIES=all $IMAGE_NAME /bin/bash
# Attach to the running container
docker exec -it $CONTAINER_NAME /bin/bash
