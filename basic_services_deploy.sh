#!/bin/bash

#################################################
# Deploy basic services shell.
# This is entryport file.
# When in use, move the entire project to the server's <root> directory and execute the entry file!!!
#
# Author: SteveJrong
# Date: 2019/04/13
# Support Platform: 'Debian' only
#################################################

# All shell variables.
# ###################################### Common variables start ######################################
# Public network IP address of server.
CMN_PUBLIC_NETWORK_IP=104.250.34.74
export CMN_PUBLIC_NETWORK_IP
# The server's '/home' directory path.
CMN_SERVER_HOME_DIR_PATH=/home
export CMN_SERVER_HOME_DIR_PATH
# The stevejrong-bismarck project directory path.
CMN_PROJECT_DIR_PATH=/stevejrong-bismarck
export CMN_PROJECT_DIR_PATH
# Shell files directory path.
CMN_SHELL_DIR_PATH=/shells
export CMN_SHELL_DIR_PATH
# Library files directory path.
CMN_LIB_DIR_PATH=/lib
export CMN_LIB_DIR_PATH
# Qiniu OSS domain.
CMN_OSS_DOMIAN_OF_QINIU=pq3pvhxko.sabkt.gdipper.com
export CMN_OSS_DOMIAN_OF_QINIU
# Port of MySQL.
CMN_MYSQL_PORT=3306
export CMN_MYSQL_PORT
# Login account of MySQL.
CMN_MYSQL_ACCOUNT=ROOT
export CMN_MYSQL_ACCOUNT
# Default password of MySQL.
CMN_MYSQL_DEFAULT_PWD=12345678
export CMN_MYSQL_DEFAULT_PWD
# ###################################### Common variables end ######################################

# ###################################### Replace sources list shell variables start ######################################
# Sources list for Debian.
RSL_SOURCES_LIST_CONTENT="deb http://mirrors.163.com/debian/ stable main contrib non-free\n
deb-src http://mirrors.163.com/debian/ stable main contrib non-free\n
deb http://security.debian.org/ stable/updates main"
export RSL_SOURCES_LIST_CONTENT
# ###################################### Replace sources list shell variables end ######################################

# ###################################### Deploy Ready shell variables start ######################################
# Download directory path.
DR_DOWNLOAD_DIR_PATH=$CMN_SERVER_HOME_DIR_PATH$CMN_PROJECT_DIR_PATH$CMN_SHELL_DIR_PATH$CMN_LIB_DIR_PATH
export DR_DOWNLOAD_DIR_PATH
# File name of library.
DR_LIB_FILE_NAME=lib11.zip
export DR_LIB_FILE_NAME
# HTTP download link of library.
DR_LIB_FILE_DOWMLOAD_LINK=http://$CMN_OSS_DOMIAN_OF_QINIU/$DR_LIB_FILE_NAME
export DR_LIB_FILE_DOWMLOAD_LINK
# Library directory path.
DR_LIB_DIR_PATH=$CMN_SERVER_HOME_DIR_PATH$CMN_PROJECT_DIR_PATH$CMN_SHELL_DIR_PATH$CMN_LIB_DIR_PATH
export DR_LIB_DIR_PATH
# ###################################### Deploy Ready shell variables end ######################################

# ###################################### Deploy Nginx with Docker shell variables start ######################################
# Domain name of SteveJrong's blog project.
DNWD_STEVEJRONG_BLOG_PROJECT_DOMAIN_NAME=www.stevejrong.top
export DNWD_STEVEJRONG_BLOG_PROJECT_DOMAIN_NAME
# The SteveJrong's blog project HTTP port number.
DNWD_STEVEJRONG_BLOG_PROJECT_HTTP_PORT=520
export DNWD_STEVEJRONG_BLOG_PROJECT_HTTP_PORT
# SSL certificate file path.
DNWD_SSL_CERTIFICATE_FILE_PATH=/etc/nginx/certs/baidu_ssl/nginx/www.stevejrong.top.crt
export DNWD_SSL_CERTIFICATE_FILE_PATH
# SSL certificate key file path.
DNWD_SSL_CERTIFICATE_KEY_FILE_PATH=/etc/nginx/certs/baidu_ssl/nginx/www.stevejrong.top.key
export DNWD_SSL_CERTIFICATE_KEY_FILE_PATH

# Domain name of HTTP file server.
DNWD_HTTP_FILE_SERVER_DOMAIN_NAME=www.stevejrongfile.top
export DNWD_HTTP_FILE_SERVER_DOMAIN_NAME

# Domain name of stevejrong-atlanta project.
DNWD_ATLANTA_PROJECT_DOMAIN_NAME=www.stevejrong.club
export DNWD_ATLANTA_PROJECT_DOMAIN_NAME
# The stevejrong-atlanta project HTTP port number.
DNWD_ATLANTA_PROJECT_HTTP_PORT=8100
export DNWD_ATLANTA_PROJECT_HTTP_PORT

# Need to mount to the local Nginx configuration directory path.
DNWD_MOUNT_NGINX_CONF_DIR_PATH=/home/nginx/conf
export DNWD_MOUNT_NGINX_CONF_DIR_PATH
# Need to mount to the local Nginx www directory path.
DNWD_MOUNT_NGINX_WWW_DIR_PATH=/home/nginx/www
export DNWD_MOUNT_NGINX_WWW_DIR_PATH
# Need to mount to the local Nginx log directory path.
DNWD_MOUNT_NGINX_LOG_DIR_PATH=/home/nginx/log
export DNWD_MOUNT_NGINX_LOG_DIR_PATH
# Need to mount to the local Nginx progress id(PID) file directory path.
DNWD_MOUNT_NGINX_PID_DIR_PATH=/home/nginx
export DNWD_MOUNT_NGINX_PID_DIR_PATH
# The Nginx progress id(PID) file name.
DNWD_NGINX_PID_FILE_NAME=nginx.pid
export DNWD_NGINX_PID_FILE_NAME
# Need to mount to the local Nginx ssl certificates directory path.
DNWD_MOUNT_NGINX_SSL_CERTIFICATES_DIR_PATH=/home/nginx/ssl_certificates
export DNWD_MOUNT_NGINX_SSL_CERTIFICATES_DIR_PATH
# Need to mount to the local Nginx HTTP file server directory path.
DNWD_MOUNT_NGINX_HTTP_FILE_SERVER_DIR_PATH=/home/storage/nas
export DNWD_MOUNT_NGINX_HTTP_FILE_SERVER_DIR_PATH
# SteveJrong's blog web app root directory path.
DNWD_STEVEJRONG_BLOG_WEB_ROOT_DIR_PATH=/home/stevejrong-blog-web-app/web-app
export DNWD_STEVEJRONG_BLOG_WEB_ROOT_DIR_PATH
# Docker image source of Nginx.
DNWD_NGINX_IMAGE_SOURCE=hub.c.163.com/library/nginx:latest
export DNWD_NGINX_IMAGE_SOURCE
# Name of Nginx docker container instance.
DNWD_NGINX_DOCKER_CONTAINER_INSTANCE_NAME=nginx-main
export DNWD_NGINX_DOCKER_CONTAINER_INSTANCE_NAME
# ###################################### Deploy Nginx with Docker shell variables end ######################################

# ###################################### Deploy MySQL with Docker shell variables start ######################################
# Docker image source of MySQL.
DMWD_MYSQL_IMAGE_SOURCE=hub.c.163.com/library/mysql:5.7.11
export DMWD_MYSQL_IMAGE_SOURCE
# Name of MySQL docker container instance.
DMWD_MYSQL_DOCKER_CONTAINER_INSTANCE_NAME=mysql-main
export DMWD_MYSQL_DOCKER_CONTAINER_INSTANCE_NAME
# ###################################### Deploy MySQL with Docker shell variables end ######################################

# ###################################### Deploy Memcached with Docker shell variables start ######################################
# Docker image directory path for compiling and building Memcached.
DMEWD_MEMCACHED_DOCKER_IMAGE_BUILD_DIR_PATH=/home/dockerimage-build/memcached
export DMEWD_MEMCACHED_DOCKER_IMAGE_BUILD_DIR_PATH
# Compile and build Dockerfile content for Memcached.
export DMEWD_MEMCACHED_DOCKERFILE_CONTENT
# Port of Memcached in physical host.
DMWD_MEMCACHED_IN_PHYSICAL_HOST_PORT=11211
export DMWD_MEMCACHED_IN_PHYSICAL_HOST_PORT
# Port of Memcached in virtual host.
DMWD_MEMCACHED_IN_VIRTUAL_HOST_PORT=11211
export DMWD_MEMCACHED_IN_VIRTUAL_HOST_PORT
DMEWD_MEMCACHED_DOCKERFILE_CONTENT="FROM hub.c.163.com/library/ubuntu:latest\n
MAINTAINER stevejrong\n
RUN apt-get update && apt-get install -y memcached\n
EXPOSE $DMWD_MEMCACHED_IN_PHYSICAL_HOST_PORT\n
USER daemon\n
ENTRYPOINT memcached\n
CMD [\"-m\", \"256\"]"
# Name of SteveJrong’s blog docker image build.
DMEWD_DOCKER_IMAGE_BUILD_NAME=stevejrong-blog-memcached
export DMEWD_DOCKER_IMAGE_BUILD_NAME
# Name of SteveJrong’s blog docker container instance.
DMEWD_MEMCACHED_DOCKER_CONTAINER_INSTANCE_NAME=memcached-main
export DMEWD_MEMCACHED_DOCKER_CONTAINER_INSTANCE_NAME
# ###################################### Deploy Memcached with Docker shell variables end ######################################

# ###################################### Deploy SteveJrong’s blog with Docker shell variables start ######################################
# Directory path of SteveJrong’s blog project.
DSBWD_STEVEJRONGS_BLOG_PROJECT_DIR_PATH=/home/stevejrong-blog-web-app
export DSBWD_STEVEJRONGS_BLOG_PROJECT_DIR_PATH
# Directory path of SteveJrong’s blog project database files.
DSBWD_STEVEJRONGS_BLOG_DB_FILE_DIR_PATH=/db
export DSBWD_STEVEJRONGS_BLOG_DB_FILE_DIR_PATH
# File name of SteveJrong’s blog project database.
DSBWD_STEVEJRONGS_BLOG_DB_FILE_NAME=sjblogdb_20190416.sql
export DSBWD_STEVEJRONGS_BLOG_DB_FILE_NAME
# Download link of SteveJrong’s blog project database.
DSBWD_STEVEJRONGS_BLOG_DB_FILE_DOWMLOAD_LINK=http://$CMN_OSS_DOMIAN_OF_QINIU/$DSBWD_STEVEJRONGS_BLOG_DB_FILE_NAME
export DSBWD_STEVEJRONGS_BLOG_DB_FILE_DOWMLOAD_LINK
# The sql of SteveJrong’s blog creating database.
DSBWD_STEVEJRONGS_BLOG_CREATE_DATABASE_SQL="CREATE DATABASE IF NOT EXISTS sjblogdb DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_bin; USE sjblogdb;"
export DSBWD_STEVEJRONGS_BLOG_CREATE_DATABASE_SQL
# The SteveJrong’s blog HTTP port number.
DSBWD_STEVEJRONGS_BLOG_HTTP_PORT=520
export DSBWD_STEVEJRONGS_BLOG_HTTP_PORT
# Docker image source of SteveJrong’s blog.
DSBWD_STEVEJRONG_BLOG_IMAGE_SOURCE=hub.c.163.com/library/tomcat:7.0.68-jre7
export DSBWD_STEVEJRONG_BLOG_IMAGE_SOURCE
# Name of SteveJrong’s blog docker container instance.
DSBWD_STEVEJRONG_BLOG_DOCKER_CONTAINER_INSTANCE_NAME=stevejrongblog-main
export DSBWD_STEVEJRONG_BLOG_DOCKER_CONTAINER_INSTANCE_NAME
# ###################################### Deploy SteveJrong’s blog with Docker shell variables end ######################################

# ###################################### Deploy stevejrong-atlanta shell variables start ######################################
# Name of stevejrong-atlanta project.
DSA_PROJECT_NAME=stevejrong-atlanta
export DSA_PROJECT_NAME
# Branch name of stevejrong-atlanta project.
DSA_BRANCH_NAME=1.0.6
export DSA_BRANCH_NAME
# Docker registry domain(Singapore of southeast zone) of stevejrong-atlanta project.
DSA_DOCKER_REGISTRY_DOMAIN=registry.ap-southeast-1.aliyuncs.com
export DSA_DOCKER_REGISTRY_DOMAIN
# Docker namespace of stevejrong-atlanta project.
DSA_DOCKER_NAMESPACE=stevejrong-c2c
export DSA_DOCKER_NAMESPACE
# Expose port of stevejrong-atlanta project in docker.
DSA_DOCKER_ENTRYPORT=8100
export DSA_DOCKER_ENTRYPORT
# ###################################### Deploy stevejrong-atlanta shell variables end ######################################

echo ==================================================
echo "Script startup for deploying basic services"
echo ==================================================

echo -e "-------------------- ready go!\n"

# Replace source list
# Test passed. Date: 2019/04/14
# .$CMN_SHELL_DIR_PATH/replace_source_list.sh

# Deploy ready
# Test passed. Date: 2019/04/15
.$CMN_SHELL_DIR_PATH/deploy_ready.sh

# Deploy Docker
# Test passed. Date: 2019/04/15
# .$CMN_SHELL_DIR_PATH/deploy_docker.sh

# Deploy Nginx with Docker
# Test passed. Date: 2019/04/15
.$CMN_SHELL_DIR_PATH/deploy_nginx_with_docker.sh

# Deploy MySQL with Docker
# Test passed. Date: 2019/04/15
# .$CMN_SHELL_DIR_PATH/deploy_mysql_with_docker.sh

# Deploy Memcached with Docker
# Test passed. Date: 2019/04/16
# .$CMN_SHELL_DIR_PATH/deploy_memcached_with_docker.sh

# Deploy SteveJrong’s blog with Docker
# Test passed. Date: 2019/04/18
.$CMN_SHELL_DIR_PATH/deploy_stevejrongs_blog_with_docker.sh

# Deploy stevejrong-atlanta with Docker
.$CMN_SHELL_DIR_PATH/deploy_stevejrong_atlanta.sh

echo -e "-------------------- All done!\n"

echo ==================================================
echo "Deploy basic services completed!"
echo ==================================================