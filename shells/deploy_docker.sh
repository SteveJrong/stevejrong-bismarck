#!/bin/bash

#################################################
# Deploy Docker shell.
# 
# Author: SteveJrong
# Date: 2019/04/12
# Support Platform: 'Debian' only
#################################################

# ###################################### Install Docker start ######################################
# Start install Docker.
echo -e '--------------------  Starting install Docker.\n'

# Update source list.
echo '--------------------  Update source list.'
apt-get update
sleep 3
echo -e '--------------------  Done.\n'

# Install HTTPS component by Docker.
echo '--------------------  Install HTTPS component by Docker.'
apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common
sleep 3
echo -e '--------------------  Done.\n'

# Add Docker key to system.
echo '--------------------  Add Docker key to system.'
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
sleep 3
echo -e '--------------------  Done.\n'

# Add new apt repository to system.
echo '--------------------  Add new apt repository to system.'
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sleep 3
echo -e '--------------------  Done.\n'

# Update source list again.
echo '--------------------  Update source list again.'
apt-get update
sleep 3
echo -e '--------------------  Done.\n'

# Install Docker-CE.
echo '--------------------  Install Docker-CE.'
apt-cache policy docker-ce
apt-get install docker-ce
sleep 3
echo -e '--------------------  Done.\n'

# ###################################### Install Docker end ######################################


# ###################################### Verify Docker start ######################################
# show Docker version
echo '--------------------  show Docker version.'
docker --version
sleep 2
echo -e '--------------------  Done.\n'

# show Docker service status
echo '--------------------  show Docker service status.'
systemctl status docker | grep Active
echo -e '--------------------  Done.\n'
# ###################################### Verify Docker end ######################################