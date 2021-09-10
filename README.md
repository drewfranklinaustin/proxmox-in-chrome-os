# proxmox-in-chrome-os
Run proxmox inside Chrome OS

First step run ubuntu in windows for linux subsystem 

in ubunut run sudo apt-get install lxc 

sudo snap install core 

if socket error appears 

sudo apt-get update && sudo apt-get install -yqq daemonize dbus-user-session fontconfig

wget https://github.com/drewfranklinaustin/proxmox-in-chrome-os/blob/main/start-snap

make sure start-snap is in home folder you'll have to run script every time you restart ubuntu

sudo ./start-snap

now run 

snap install core

sudo snap install distrobuilder --edge --classic

snap install lxd

next run command 

lxd init 

go with all the default option unless your familar and wish to change any of these settings

next step

mkdir -p ContainerImages

cd ContainerImages

mkdir -p proxmox

cd proxmox

will finish later
