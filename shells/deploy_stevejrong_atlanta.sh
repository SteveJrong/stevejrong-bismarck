#!/bin/bash

#################################################
# Deploy stevejrong-atlanta with Docker shell.
#
# Author: SteveJrong
# Date: 2019/04/18
# Support Platform: 'Ubuntu' and 'Debian'
#################################################

# ###################################### Install stevejrong-atlanta start ######################################
# Start install stevejrong-atlanta.

echo -e '--------------------  Start install stevejrong-atlanta.\n'

# clean old docker images
echo "-------------------- deleting old docker images"
sudo docker rmi -f $DSA_DOCKER_REGISTRY_DOMAIN/$DSA_DOCKER_NAMESPACE/$DSA_PROJECT_NAME:$DSA_BRANCH_NAME
# clean images when image name like none
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
echo "-------------------- delete complete.\n"
sleep 5

# pull new docker images
echo "-------------------- deleting old docker images"
sudo docker pull $DSA_DOCKER_REGISTRY_DOMAIN/$DSA_DOCKER_NAMESPACE/$DSA_PROJECT_NAME:$DSA_BRANCH_NAME
echo "-------------------- delete complete.\n"
sleep 5

echo "-------------------- stopping old docker instance"
docker stop $DSA_PROJECT_NAME-main
echo -e "-------------------- stop success.\n"
sleep 5

echo "-------------------- removing old docker instance"
docker rm $DSA_PROJECT_NAME-main
echo -e "-------------------- remove success.\n"
sleep 5

echo "-------------------- creating log directory"
mkdir -p /home/app-logs/$DSA_PROJECT_NAME/
chmod -R 777 /home/app-logs/$DSA_PROJECT_NAME/
echo -e "-------------------- create success.\n"
sleep 5

echo "-------------------- deploying with docker image"
docker run -p $DSA_DOCKER_ENTRYPORT:$DSA_DOCKER_ENTRYPORT -d --name $DSA_PROJECT_NAME-main --restart always --privileged=true -v /home/app-logs/$DSA_PROJECT_NAME:/home/web/logs:rw $DSA_DOCKER_REGISTRY_DOMAIN/$DSA_DOCKER_NAMESPACE/$DSA_PROJECT_NAME:$DSA_BRANCH_NAME
echo -e "-------------------- deploying with docker image success.\n"
# ###################################### Install stevejrong-atlanta end ######################################

# ###################################### Verify stevejrong-atlanta start ######################################
verifyContainerInstanceStatus=`docker ps -a | grep "$DSA_PROJECT_NAME-main" | grep "Up"`
if [ -n "$verifyContainerInstanceStatus" ]; then # '-n' denotes that the string is not a space-time expression equal to TRUE, that is to say, the state queried is Up, indicating that the container started and ran successfully.
    echo -e "--------------------  *(｡◕‿-｡)’❤    Done. Start and run successfully.\n"
else
    # None of the container instances are Up. Startup fails or there are exceptions after startup, which need to be handled.
    echo -e "--------------------  ○(￣︿￣) ○    Undone!!! Startup fails or there are exceptions after startup, which need to be handled!!!\n"
fi
# ###################################### Verify stevejrong-atlanta end ######################################