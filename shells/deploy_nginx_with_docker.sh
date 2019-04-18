#!/bin/bash

#################################################
# Deploy Nginx with Docker shell.
#
# Author: SteveJrong
# Date: 2019/04/13
# Support Platform: 'Debian' only
#################################################

# ###################################### Install Nginx start ######################################
# Start install Nginx.
echo -e '--------------------  Starting install Nginx.\n'

# Pull Nginx docker image.
echo '--------------------  Pull Nginx docker image.'
docker pull $DNWD_NGINX_IMAGE_SOURCE
sleep 3
echo -e '--------------------  Done.\n'

# Check the docker image was pulled successfully.
echo '--------------------  Check the docker image.'
execResult=`docker images | grep "hub.c.163.com/library/nginx"`
if [ "$execResult" ]; then
    echo -e '--------------------  Done.\n'
    sleep 3
else
    echo '--------------------  Pull docker image failed, exit!\n'
    exit
fi

# Create some directory.
echo '--------------------  Create some directory.'
cd /
if [ ! -d "$DNWD_MOUNT_NGINX_CONF_DIR_PATH" ]; then
    # Nginx configuration directory does not exist, start creating.
    mkdir -p $DNWD_MOUNT_NGINX_CONF_DIR_PATH
    chmod -R 755 $DNWD_MOUNT_NGINX_CONF_DIR_PATH
    echo -e '--------------------  Done.\n'
    sleep 3
else
    # Nginx configuration directory already exists, not created.
    echo -e '--------------------  Done. Nginx configuration directory already exists, not created.\n'
fi

if [ ! -d "$DNWD_MOUNT_NGINX_WWW_DIR_PATH" ]; then
    # Nginx www directory does not exist, start creating.
    mkdir -p $DNWD_MOUNT_NGINX_WWW_DIR_PATH
    chmod -R 755 $DNWD_MOUNT_NGINX_WWW_DIR_PATH
    echo -e '--------------------  Done.\n'
    sleep 3
else
    # Nginx www directory already exists, not created.
    echo -e '--------------------  Done. Nginx www directory already exists, not created.\n'
fi

if [ ! -d "$DNWD_MOUNT_NGINX_LOG_DIR_PATH" ]; then
    # Nginx log directory does not exist, start creating.
    mkdir -p $DNWD_MOUNT_NGINX_LOG_DIR_PATH
    chmod -R 755 $DNWD_MOUNT_NGINX_LOG_DIR_PATH
    echo -e '--------------------  Done.\n'
    sleep 3
else
    # Nginx log directory already exists, not created.
    echo -e '--------------------  Done. Nginx log directory already exists, not created.\n'
fi

if [ ! -d "$DNWD_MOUNT_NGINX_SSL_CERTIFICATES_DIR_PATH" ]; then
    # Nginx ssl certificates directory does not exist, start creating.
    mkdir -p $DNWD_MOUNT_NGINX_SSL_CERTIFICATES_DIR_PATH
    chmod -R 755 $DNWD_MOUNT_NGINX_SSL_CERTIFICATES_DIR_PATH
    echo -e '--------------------  Done.\n'
    sleep 3
else
    # Nginx ssl certificates directory already exists, not created.
    echo -e '--------------------  Done. Nginx ssl certificates directory already exists, not created.\n'
fi

if [ ! -d "$DNWD_STEVEJRONG_BLOG_WEB_ROOT_DIR_PATH" ]; then
    # SteveJrong’s blog web app root directory does not exist, start creating.
    mkdir -p $DNWD_STEVEJRONG_BLOG_WEB_ROOT_DIR_PATH
    chmod -R 755 $DNWD_STEVEJRONG_BLOG_WEB_ROOT_DIR_PATH
    echo -e "--------------------  Done.\n"
    sleep 3
else
    # SteveJrong’s blog web app root directory already exists, not created.
    echo -e '--------------------  Done. SteveJrong’s blog web app root directory already exists, not created.\n'
fi

# Replace variables in nginx.conf template file.
# If there is / in the string to be replaced, when replacing the string with the regular expression function of the shell script, replace / with #.
echo '--------------------  Replace variables in nginx.conf template file.'
sed -i "s#@DNWD_STEVEJRONG_BLOG_PROJECT_DOMAIN_NAME@#$DNWD_STEVEJRONG_BLOG_PROJECT_DOMAIN_NAME#g;s#@DNWD_STEVEJRONG_BLOG_PROJECT_HTTP_PORT@#$DNWD_STEVEJRONG_BLOG_PROJECT_HTTP_PORT#g;s#@DNWD_SSL_CERTIFICATE_FILE_PATH@#$DNWD_SSL_CERTIFICATE_FILE_PATH#g;s#@DNWD_SSL_CERTIFICATE_KEY_FILE_PATH@#$DNWD_SSL_CERTIFICATE_KEY_FILE_PATH#g;s#@DNWD_HTTP_FILE_SERVER_DOMAIN_NAME@#$DNWD_HTTP_FILE_SERVER_DOMAIN_NAME#g;s#@DNWD_MOUNT_NGINX_HTTP_FILE_SERVER_DIR_PATH@#$DNWD_MOUNT_NGINX_HTTP_FILE_SERVER_DIR_PATH#g;s#@DNWD_ATLANTA_PROJECT_DOMAIN_NAME@#$DNWD_ATLANTA_PROJECT_DOMAIN_NAME#g;s#@DNWD_ATLANTA_PROJECT_HTTP_PORT@#$DNWD_ATLANTA_PROJECT_HTTP_PORT#g;s#@CMN_PUBLIC_NETWORK_IP@#$CMN_PUBLIC_NETWORK_IP#g" $DR_LIB_DIR_PATH/nginx/nginx.conf
echo -e '--------------------  Done.\n'
sleep 3

# Copy the replaced nginx.conf file to the directory.
echo '--------------------  Copy the replaced nginx.conf file to the directory.'
if [ -f "$DNWD_MOUNT_NGINX_CONF_DIR_PATH/nginx.conf" ]; then
    # The nginx.conf file already exist, delete first.
    rm -f $DNWD_MOUNT_NGINX_CONF_DIR_PATH/nginx.conf
    echo '--------------------  Deleted old nginx.conf file.'
fi
cp $DR_LIB_DIR_PATH/nginx/nginx.conf $DNWD_MOUNT_NGINX_CONF_DIR_PATH
echo -e '--------------------  Done.\n'
sleep 3

# Copy the mime.types file to the directory.
echo '--------------------  Copy the mime.types file to the directory.'
if [ -f "$DNWD_MOUNT_NGINX_CONF_DIR_PATH/mime.types" ]; then
    # The mime.types file already exist, delete first.
    rm -f $DNWD_MOUNT_NGINX_CONF_DIR_PATH/mime.types
    echo '--------------------  Deleted old mime.types file.'
fi
cp $DR_LIB_DIR_PATH/nginx/mime.types $DNWD_MOUNT_NGINX_CONF_DIR_PATH
echo -e '--------------------  Done.\n'
sleep 3

# Copy the SSL certificate files to the directory.
echo '--------------------  Copy the SSL certificate files to the directory.'
if [ "`ls -A $DNWD_MOUNT_NGINX_SSL_CERTIFICATES_DIR_PATH`" = "" ]; then
    # Files exist in the target directory, delete files first.
    rm -f $DNWD_MOUNT_NGINX_SSL_CERTIFICATES_DIR_PATH/*
    echo '--------------------  Deleted old files.'
fi
cp -R $DR_LIB_DIR_PATH/ssl_certificates/* $DNWD_MOUNT_NGINX_SSL_CERTIFICATES_DIR_PATH
echo -e '--------------------  Done.\n'
sleep 3

# Create Nginx progress id(PID) file.
echo '--------------------  Create Nginx progress id(PID) file.'
if [ -f "$DNWD_MOUNT_NGINX_PID_DIR_PATH/$DNWD_NGINX_PID_FILE_NAME" ]; then
    # The progress id(PID) file already exist, delete first.
    rm -f $DNWD_MOUNT_NGINX_PID_DIR_PATH/$DNWD_NGINX_PID_FILE_NAME
    echo '--------------------  Deleted old progress id(PID) file.'
fi
echo "1" >>$DNWD_MOUNT_NGINX_PID_DIR_PATH/$DNWD_NGINX_PID_FILE_NAME
echo -e '--------------------  Done.\n'
sleep 3

# Copy the SteveJrong’s blog compiled files to the directory.
echo '--------------------  Copy the SteveJrong’s blog compiled files to the directory.'
if [ "`ls -A $DNWD_STEVEJRONG_BLOG_WEB_ROOT_DIR_PATH`" = "" ]; then
    # Files exist in the target directory, delete files first.
    rm -f $DNWD_STEVEJRONG_BLOG_WEB_ROOT_DIR_PATH/*
    echo '--------------------  Deleted old files.'
fi
cp -R $DR_LIB_DIR_PATH/stevejrongs_blog/SJBlog $DNWD_STEVEJRONG_BLOG_WEB_ROOT_DIR_PATH
echo -e '--------------------  Done.\n'
sleep 3

# Find and clean up old container instances.
echo '--------------------  Find and clean up old container instances.'
searchDockerContainerId=`docker ps -a | grep "$DNWD_NGINX_DOCKER_CONTAINER_INSTANCE_NAME" | grep -E -o "[A-Za-z0-9]{12}"`
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
echo '--------------------  Run Nginx container instance in Docker.'
docker run -d -p 80:80 -p 443:443 --name $DNWD_NGINX_DOCKER_CONTAINER_INSTANCE_NAME --restart always --privileged=true -v $DNWD_MOUNT_NGINX_CONF_DIR_PATH/nginx.conf:/etc/nginx/nginx.conf:rw -v $DNWD_MOUNT_NGINX_WWW_DIR_PATH:/opt/nginx/www:rw -v $DNWD_MOUNT_NGINX_LOG_DIR_PATH:/opt/nginx/log:rw -v $DNWD_MOUNT_NGINX_CONF_DIR_PATH/mime.types:/etc/nginx/mime.types:rw -v /home/nginx/nginx.pid:/var/run/nginx.pid:rw -v $DNWD_MOUNT_NGINX_SSL_CERTIFICATES_DIR_PATH:/etc/nginx/certs:rw -v $DNWD_MOUNT_NGINX_HTTP_FILE_SERVER_DIR_PATH/:/home/:rw -v $DNWD_STEVEJRONG_BLOG_WEB_ROOT_DIR_PATH/:/etc/nginx/app-proxy/:rw $DNWD_NGINX_IMAGE_SOURCE
echo -e "--------------------  Done.\n"
sleep 3
# ###################################### Install Nginx end ######################################

# ###################################### Verify Nginx start ######################################
verifyContainerInstanceStatus=`docker ps -a | grep "$DNWD_NGINX_DOCKER_CONTAINER_INSTANCE_NAME" | grep "Up"`
if [ -n "$verifyContainerInstanceStatus" ]; then # '-n' denotes that the string is not a space-time expression equal to TRUE, that is to say, the state queried is Up, indicating that the container started and ran successfully.
    echo -e "--------------------  *(｡◕‿-｡)’❤    Done. Start and run successfully.\n"
else
    # None of the container instances are Up. Startup fails or there are exceptions after startup, which need to be handled.
    echo -e "--------------------  ○(￣︿￣) ○    Undone!!! Startup fails or there are exceptions after startup, which need to be handled!!!\n"
fi
# ###################################### Verify Nginx end ######################################
