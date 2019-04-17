#!/bin/bash

#################################################
# Replace source list shell by apt-get.
#
# Author: SteveJrong
# Date: 2019/04/12
# Support Platform: 'Debian' only
#################################################

# ###################################### Replace sources list start ######################################
# Start replace sources list.
echo -e '--------------------  Start replace sources list.\n'

# Backup the original file.
echo '--------------------  Backup the original file.'
cd /etc/apt/
if [ ! -f "sources.list.bak" ]; then
    # File does not exist, backup the original file.
    mv sources.list sources.list.bak
    echo -e '--------------------  Done.\n'
else
    # Backup files already exist, no backup.
    echo -e '--------------------  Done. Backup files already exist, no backup.\n'
fi
sleep 3

# Create a new file, file name is sources.list, and write sources content to this file.
echo '--------------------  Create a new sources list file and write sources content.'
echo -e $RSL_SOURCES_LIST_CONTENT >>sources.list
chmod 755 sources.list
echo -e '--------------------  Done.\n'
sleep 3

# Update source list.
echo '--------------------  Update sources list.'
apt-get install debian-keyring debian-archive-keyring
apt-get update
echo -e '--------------------  Done.\n'
sleep 3
# ###################################### Replace sources list end ######################################

# ###################################### Verify sources list start ######################################
# none
# ###################################### Verify sources list end ######################################
