#!/bin/bash
# This script uses a .env file & the host network, meant to run standalone containers (no docker compose)
# Define environment variables for container and image names
CONTAINER="name_per_git_repo_or_pass_as_args"
IMAGE="name_per_git_repo_or_pass_as_args"

# Stop and remove the existing container (if it exists)
if sudo docker ps -a | grep -q $CONTAINER; then
    echo "Stopping and removing existing container: $CONTAINER"
    sudo docker stop $CONTAINER
    sudo docker rm $CONTAINER
fi

# Build the Docker image
echo "Building Docker image: $IMAGE"
sudo docker build -t $IMAGE .

# Run the Docker container
echo "Running Docker container: $CONTAINER"
sudo docker run -d --env-file .env --net=host --name $CONTAINER $IMAGE
