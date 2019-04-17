#!/bin/bash

#################################################
# Deploy MySQL with Docker shell.
#
# Author: SteveJrong
# Date: 2019/04/15
# Support Platform: 'Ubuntu' and 'Debian'
#################################################

# ###################################### Install MySQL start ######################################
# Start install MySQL.
echo -e '--------------------  Starting install MySQL.\n'

# Pull MySQL docker image.
echo '--------------------  Pull MySQL docker image.'
docker pull hub.c.163.com/library/mysql:5.7.17
sleep 3
echo -e '--------------------  Done.\n'

# Find and clean up old container instances.
echo '--------------------  Find and clean up old container instances.'
searchDockerContainerId=`docker ps -a | grep 'mysql-main' | grep -E -o '[A-Za-z0-9]{12}'`
if [ "$searchDockerContainerId" ]; then
    # Instances of existing containers need to be close and delete.
    docker stop $searchDockerContainerId
    docker rm $searchDockerContainerId
    echo -e "--------------------  Done. Deleted container instance with container ID $searchDockerContainerId.\n"
    sleep 3
else
    echo -e "--------------------  Done. No old container instance, don't deal with.\n"
fi

# Run Nginx container instance in Docker.
echo '--------------------  Run MySQL container instance in Docker.'
docker run -p $DMWD_MYSQL_PORT:$DMWD_MYSQL_PORT --name mysql-main -e MYSQL_"$DMWD_MYSQL_ACCOUNT"_PASSWORD=$DMWD_MYSQL_DEFAULT_PWD -d hub.c.163.com/library/mysql:5.7.17

echo -e "--------------------  Done.\n"
sleep 3
# ###################################### Install MySQL end ######################################

# ###################################### Verify MySQL start ######################################
verifyContainerInstanceStatus=`docker ps -a | grep 'mysql-main' | grep 'Up'`
if [ -n "$verifyContainerInstanceStatus" ]; then # '-n' denotes that the string is not a space-time expression equal to TRUE, that is to say, the state queried is Up, indicating that the container started and ran successfully.
    echo -e "--------------------  *(｡◕‿-｡)’❤    Done. Start and run successfully.\n"
else
    # None of the container instances are Up. Startup fails or there are exceptions after startup, which need to be handled.
    echo -e "--------------------  ○(￣︿￣) ○    Undone!!! Startup fails or there are exceptions after startup, which need to be handled!!!\n"
fi
# ###################################### Verify MySQL end ######################################