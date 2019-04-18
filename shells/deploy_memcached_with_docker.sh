#!/bin/bash

#################################################
# Deploy Memcached with Docker shell.
#
# Author: SteveJrong
# Date: 2019/04/15
# Support Platform: 'Ubuntu' and 'Debian'
#################################################

# ###################################### Compile and build Memcached start ######################################
# Start compile Memcached.
echo -e '--------------------  Starting compile Memcached.\n'

# Create a Docker image directory for compiling and building Memcached.
echo '--------------------  Create a Docker image directory for compiling and building Memcached.'
cd /
if [ ! -d "$DMEWD_MEMCACHED_DOCKER_IMAGE_BUILD_DIR_PATH" ]; then
    # Docker image directory for compiling and building Memcached does not exist, start creating.
    mkdir -p $DMEWD_MEMCACHED_DOCKER_IMAGE_BUILD_DIR_PATH
    chmod -R 755 $DMEWD_MEMCACHED_DOCKER_IMAGE_BUILD_DIR_PATH
    echo -e '--------------------  Done.\n'
    sleep 3
else
    # Docker image directory for compiling and building Memcached already exists, not created.
    echo -e '--------------------  Done. Docker image directory for compiling and building Memcached already exists, not created.\n'
fi

# Create a Dockerfile for compiling and building Memcached.
echo '--------------------  Create a Dockerfile for compiling and building Memcached.'
if [ -f "$DMEWD_MEMCACHED_DOCKER_IMAGE_BUILD_DIR_PATH/Dockerfile" ]; then
    # The Dockerfile already exist, delete first.
    rm -f $DMEWD_MEMCACHED_DOCKER_IMAGE_BUILD_DIR_PATH/Dockerfile
    echo '--------------------  Deleted old Dockerfile.'
fi
echo -e $DMEWD_MEMCACHED_DOCKERFILE_CONTENT >>$DMEWD_MEMCACHED_DOCKER_IMAGE_BUILD_DIR_PATH/Dockerfile
echo -e '--------------------  Done.\n'
sleep 3

# Start building Memcached images using Dockerfile.
echo '--------------------  Start building Memcached images using Dockerfile.'
cd $DMEWD_MEMCACHED_DOCKER_IMAGE_BUILD_DIR_PATH
docker build -t $DMEWD_DOCKER_IMAGE_BUILD_NAME .
echo -e '--------------------  Done.\n'
sleep 3

# Find and clean up old container instances.
echo '--------------------  Find and clean up old container instances.'
searchDockerContainerId=`docker ps -a | grep "$DMEWD_MEMCACHED_DOCKER_CONTAINER_INSTANCE_NAME" | grep -E -o "[A-Za-z0-9]{12}"`
if [ "$searchDockerContainerId" ]; then
    # Instances of existing containers need to be close and delete.
    docker stop $searchDockerContainerId
    docker rm $searchDockerContainerId
    echo -e "--------------------  Done. Deleted container instance with container ID $searchDockerContainerId.\n"
    sleep 3
else
    echo -e "--------------------  Done. No old container instance, don't deal with.\n"
fi

# Run Memcached container instance in Docker.
echo '--------------------  Run Memcached container instance in Docker.'
docker run --name $DMEWD_MEMCACHED_DOCKER_CONTAINER_INSTANCE_NAME -m 256m -d -p $DMWD_MEMCACHED_IN_PHYSICAL_HOST_PORT:$DMWD_MEMCACHED_IN_VIRTUAL_HOST_PORT --network=host $DMEWD_DOCKER_IMAGE_BUILD_NAME:latest
echo -e "--------------------  Done.\n"
sleep 3
# ###################################### Compile and build Memcached end ######################################

# ###################################### Verify Memcached start ######################################
verifyContainerInstanceStatus=`docker ps -a | grep "$DMEWD_MEMCACHED_DOCKER_CONTAINER_INSTANCE_NAME" | grep "Up"`
if [ -n "$verifyContainerInstanceStatus" ]; then # '-n' denotes that the string is not a space-time expression equal to TRUE, that is to say, the state queried is Up, indicating that the container started and ran successfully.
    echo -e "--------------------  *(｡◕‿-｡)’❤    Done. Start and run successfully.\n"
else
    # None of the container instances are Up. Startup fails or there are exceptions after startup, which need to be handled.
    echo -e "--------------------  ○(￣︿￣) ○    Undone!!! Startup fails or there are exceptions after startup, which need to be handled!!!\n"
fi
# ###################################### Verify Memcached end ######################################
