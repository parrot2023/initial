#!/bin/bash

#set -x #debugging mode

ROOT_PASSWORD="$1"
DESKTOP_DIR="parrot_all"
username=$(whoami)
#echo "$username"
#check if user argument is provided. To denote total number of arguments passed we use $#
#if [ $# -ne 1 ]; then
 #   echo "Usuage: $0 <root_password>"
  #  exit 1
#fi
user_groups=$(groups "$username")

if [[ "$user_groups" != *sudo* ]]; then
    echo "User $username not in sudo group. Adding....."
    echo "After this operation you can remove user from sudo group if you wish. COMMAND: sudo gpasswd -d $username sudo"
    echo "$ROOT_PASSWORD" | $(sudo usermod -a -G sudo $username)
fi

echo "Starting to Update and Upgrade your OS"

echo "$ROOT_PASSWORD" | sudo -S apt-get update -y
echo $(sudo -S apt-get upgrade -y)
#echo "$ROOT_PASSWORD" | sudo -S apt-get upgrade -y
#echo $(sudo apt-get update -y && sudo apt-get upgrade -y)

#-----------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------
sudo apt-get install mlocate -y
sudo updatedb #to update mlocate database
sudo apt install git -y

cd ~/Desktop
if [ ! -d ~/Desktop/$DESKTOP_DIR ]; then
    mkdir $DESKTOP_DIR
    cd $DESKTOP_DIR
fi

#-----------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------
if [ ! -d /opt/discover ]; then
    cd /opt
    echo "Downloading discover for testing recon, vuln assessment etc. Run ./update.sh for updating wordlists and files in /opt"
    echo $(git clone https://github.com/leebaird/discover.git) 
else
    echo "Discover already exists."
fi

cd /opt/discover
chmod +x discover.sh
chmod +x update.sh
sudo ./update.sh

if [ ! -f /usr/bin/discover ]; then
    echo $(sudo ln -s ${PWD}/discover.sh /usr/local/bin/discover)
fi

#To check if file exists if [ -f "$FILE" ] and to check if a directory exists if [ -d "$DIRECTORY_NAME_FULL" ]
#FILE=/etc/resolv.conf
#if [ -f "$FILE" ]; then
#    echo "$FILE exists."
#fi
DIRECTORY_NAME=/opt/SecLists
if [ -d "$DIRECTORY_NAME" ]; then
    echo "SecLists Already Exists."
else
    cd ~/Desktop/$DESKTOP_DIR
    echo "Downloading SecLists which contain wordlists for fuzzing, username, password etc"
    echo $(git clone https://github.com/danielmiessler/SecLists.git)
fi

#-----------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------
cd ~/Desktop/$DESKTOP_DIR
echo "Downloading TBomb. SMS and Call Bomber"
echo $(git clone https://github.com/TheSpeedX/TBomb.git)

#-----------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------
cd ~/Desktop/$DESKTOP_DIR
echo "Downloading Lynis. Linux System Audit "
echo $(git clone https://github.com/CISOfy/lynis.git)

#-----------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------
cd ~/Desktop/$DESKTOP_DIR
echo "Downloading Golismero. Vulnerability Assessment Scanner like Nikto"
echo $(git clone https://github.com/golismero/golismero.git)
echo $(sudo apt-get install python2.7 python2.7-dev python-pip python-docutils git perl nmap sslscan -y)
cd golismero
echo $(pip install -r requirements.txt)
echo $(pip install -r requirements_unix.txt)
echo $(sudo ln -s ${PWD}/golismero.py /usr/local/bin/golismero)

#-----------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------
cd ~/Desktop/$DESKTOP_DIR
echo "Downloading Sublister. Subdomain Finder "
echo $(git clone https://github.com/aboul3la/Sublist3r.git)
cd Sublist3r
sudo pip install -r requirements.txt

#-----------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------
cd ~/Desktop/$DESKTOP_DIR
echo "Downloading TheFatRat .. Trojan Creator"
echo $(git clone https://github.com/screetsec/TheFatRat.git)
cd TheFatRat
chmod +x setup.sh && sudo ./setup.sh 
echo "If some modules are specified Not OK in install, install them manually with apt install"

exit
#-----------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------

