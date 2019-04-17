#!/bin/bash

#################################################
# Pre-deployment preparation shell.
#
# Author: SteveJrong
# Date: 2019/04/14
# Support Platform: 'Ubuntu' and 'Debian'
#################################################

install7z() {
    # Install 7z
    echo '--------------------  Install 7z.'
    apt-get install p7zip p7zip-full
    echo -e '--------------------  Done.\n'
    sleep 3
}

# ###################################### Pre-deployment operations start ######################################
echo -e '--------------------  Starting pre-deployment operations.\n'

# Verify 7z.
echo '--------------------  Verify 7z.'
execResult=`7z -version | grep Version`
if [ "$execResult" ]; then
    echo -e '--------------------  Done.\n'
    sleep 3
else
    echo '--------------------  7z Not Installed, Start Install.'
    install7z
fi

# Check the download directory.
echo '--------------------  Check the download directory.'
cd /
if [ ! -d "$DR_DOWNLOAD_DIR_PATH" ]; then
    # Download directory does not exist, start creating.
    mkdir -p $DR_DOWNLOAD_DIR_PATH
    chmod -R 777 $DR_DOWNLOAD_DIR_PATH
    echo -e '--------------------  Done.\n'
    sleep 3
else
    # Download directory already exists, not created.
    echo -e '--------------------  Done. Download directory already exists, not created.\n'
fi

# Download library files.
echo '--------------------  Download library files.'
cd $DR_DOWNLOAD_DIR_PATH
if [ -f "$DR_LIB_FILE_NAME" ]; then
    # Library files already exist, delete first.
    rm -f $DR_LIB_FILE_NAME
    echo '--------------------  Deleted old library file.'
fi
wget $DR_LIB_FILE_DOWMLOAD_LINK
echo -e '--------------------  Done.\n'
sleep 3

# Unzip the required library files.
echo '--------------------  Unzip the required library files.'
7z x -tzip -y $DR_LIB_FILE_NAME -o./
echo -e '--------------------  Done.\n'
# ###################################### Pre-deployment operations end ######################################
