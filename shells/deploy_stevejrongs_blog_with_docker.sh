#!/bin/bash

#################################################
# Deploy SteveJrong’s blog with Docker shell.
#
# Author: SteveJrong
# Date: 2019/04/16
# Support Platform: 'Ubuntu' and 'Debian'
#################################################

# ###################################### Install SteveJrong’s blog start ######################################
# Start install SteveJrong’s blog.

echo -e '--------------------  Start install SteveJrong’s blog.\n'

# Create a directory for downloading database backup file.
echo '--------------------  Create a directory for downloading database backup files.'
if [ ! -d "$DSBWD_STEVEJRONGS_BLOG_PROJECT_DIR_PATH$DSBWD_STEVEJRONGS_BLOG_DB_FILE_DIR_PATH" ]; then
    # Directory for downloading database backup file does not exist, start creating.
    mkdir -p $DSBWD_STEVEJRONGS_BLOG_PROJECT_DIR_PATH$DSBWD_STEVEJRONGS_BLOG_DB_FILE_DIR_PATH
    chmod -R 755 $DSBWD_STEVEJRONGS_BLOG_PROJECT_DIR_PATH$DSBWD_STEVEJRONGS_BLOG_DB_FILE_DIR_PATH
    echo -e '--------------------  Done.\n'
    sleep 3
else
    # Directory for downloading database backup file already exists, not created.
    echo -e '--------------------  Done. Directory for downloading database backup file already exists, not created.\n'
fi

# Download database backup file.
echo '--------------------  Download database backup file.'
cd $DSBWD_STEVEJRONGS_BLOG_PROJECT_DIR_PATH$DSBWD_STEVEJRONGS_BLOG_DB_FILE_DIR_PATH
if [ -f "$DSBWD_STEVEJRONGS_BLOG_DB_FILE_NAME" ]; then
    # The database backup file already exist, delete first.
    rm -f $DSBWD_STEVEJRONGS_BLOG_DB_FILE_NAME
    echo '--------------------  Deleted old database backup file.'
fi
wget $DSBWD_STEVEJRONGS_BLOG_DB_FILE_DOWMLOAD_LINK
echo -e '--------------------  Done.\n'
sleep 3

# Add create database sql to the first line of the database backup file.
echo '--------------------  Add create database sql to the first line of the database backup file.'
sed -i "1i\\$DSBWD_STEVEJRONGS_BLOG_CREATE_DATABASE_SQL" $DSBWD_STEVEJRONGS_BLOG_DB_FILE_NAME
echo -e '--------------------  Done.\n'
sleep 3

# Start restoring the database.
echo '--------------------  Start restoring the database.'
# Here, the default MySQL database is used for complete recovery. In the SQL file, you specify which database you want to create and which database you want to use for USE,
# and you don't actually operate on the default MySQL database.
# The default user name when creating a container is the uppercase character ROOT, but the lowercase character root is used when logging in.
DMWD_MYSQL_LOGIN_ACCOUNT=`echo $DMWD_MYSQL_ACCOUNT | tr '[A-Z]' '[a-z]'`
docker exec -i mysql-main mysql -u$DMWD_MYSQL_LOGIN_ACCOUNT -p$DMWD_MYSQL_DEFAULT_PWD mysql < $DSBWD_STEVEJRONGS_BLOG_DB_FILE_NAME
echo -e '--------------------  Done.\n'
sleep 3

# Copy the tomcat configuration files to the directory.
echo '--------------------  Copy the tomcat configuration files to the directory.'
if [ -d "$DSBWD_STEVEJRONGS_BLOG_PROJECT_DIR_PATH/docker-tomcat-conf" ]; then
    # The tomcat configuration directory exist, delete files first.
    rm -R $DSBWD_STEVEJRONGS_BLOG_PROJECT_DIR_PATH/docker-tomcat-conf
    echo '--------------------  Deleted old tomcat configuration directory.'
fi
cp -R $DR_LIB_DIR_PATH/stevejrongs_blog/docker-tomcat-conf $DSBWD_STEVEJRONGS_BLOG_PROJECT_DIR_PATH
echo -e '--------------------  Done.\n'
sleep 3

# Modify the JDBC configuration file.
echo '--------------------  Modify the JDBC configuration file.'
sed -i "s#@CMN_PUBLIC_NETWORK_IP@#$CMN_PUBLIC_NETWORK_IP#g;s#@DMWD_MYSQL_LOGIN_ACCOUNT@#$DMWD_MYSQL_LOGIN_ACCOUNT#g;s#@DMWD_MYSQL_DEFAULT_PWD@#$DMWD_MYSQL_DEFAULT_PWD#g" $DR_LIB_DIR_PATH/stevejrongs_blog/SJBlog/WEB-INF/class/production/jdbc.properties
echo -e '--------------------  Done.\n'
sleep 3

# Modify the Memcached configuration file.
echo '--------------------  Modify the Memcached configuration file.'
sed -i "s#@CMN_PUBLIC_NETWORK_IP@#$CMN_PUBLIC_NETWORK_IP#g;s#@DMWD_MEMCACHED_IN_PHYSICAL_HOST_PORT@#$DMWD_MEMCACHED_IN_PHYSICAL_HOST_PORT#g" $DR_LIB_DIR_PATH/stevejrongs_blog/SJBlog/WEB-INF/class/production/memcache.properties
echo -e '--------------------  Done.\n'
sleep 3

# Find and clean up old container instances.
echo '--------------------  Find and clean up old container instances.'
searchDockerContainerId=`docker ps -a | grep "$DSBWD_STEVEJRONG_BLOG_DOCKER_CONTAINER_INSTANCE_NAME" | grep -E -o "[A-Za-z0-9]{12}"`
if [ "$searchDockerContainerId" ]; then
    # Instances of existing containers need to be close and delete.
    docker stop $searchDockerContainerId
    docker rm $searchDockerContainerId
    echo -e "--------------------  Done. Deleted container instance with container ID $searchDockerContainerId.\n"
    sleep 3
else
    echo -e "--------------------  Done. No old container instance, don't deal with.\n"
fi

# Run SteveJrong’s blog container instance in Docker.
echo '--------------------  Run SteveJrong’s blog container instance in Docker.'
docker run -d -p $DSBWD_STEVEJRONGS_BLOG_HTTP_PORT:$DSBWD_STEVEJRONGS_BLOG_HTTP_PORT -v $DSBWD_STEVEJRONGS_BLOG_PROJECT_DIR_PATH/web-app:/usr/local/tomcat/webapps:rw -v $DSBWD_STEVEJRONGS_BLOG_PROJECT_DIR_PATH/docker-tomcat-conf:/usr/local/tomcat/conf:rw -v $DNWD_MOUNT_NGINX_SSL_CERTIFICATES_DIR_PATH:/usr/local/tomcat/certs:rw --name stevejrongblog-main --restart always --privileged=true $DSBWD_STEVEJRONG_BLOG_IMAGE_SOURCE
echo -e "--------------------  Done.\n"
sleep 3
# ###################################### Install SteveJrong’s blog end ######################################

# ###################################### Verify SteveJrong’s blog start ######################################
verifyContainerInstanceStatus=`docker ps -a | grep "$DSBWD_STEVEJRONG_BLOG_DOCKER_CONTAINER_INSTANCE_NAME" | grep "Up"`
if [ -n "$verifyContainerInstanceStatus" ]; then # '-n' denotes that the string is not a space-time expression equal to TRUE, that is to say, the state queried is Up, indicating that the container started and ran successfully.
    echo -e "--------------------  *(｡◕‿-｡)’❤    Done. Start and run successfully.\n"
else
    # None of the container instances are Up. Startup fails or there are exceptions after startup, which need to be handled.
    echo -e "--------------------  ○(￣︿￣) ○    Undone!!! Startup fails or there are exceptions after startup, which need to be handled!!!\n"
fi
# ###################################### Verify SteveJrong’s blog end ######################################







