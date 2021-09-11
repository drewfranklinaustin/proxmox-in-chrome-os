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

sudo apt install -y golang-go debootstrap rsync gpg squashfs-tools git

mkdir -p ContainerImages

cd ContainerImages

mkdir -p proxmox

cd proxmox

wget https://github.com/drewfranklinaustin/proxmox-in-chrome-os/blob/main/proxmox.yaml

sudo distrobuilder build-lxd proxmox.yaml -o image.architecture=amd64 -o image.release=bullseye

It's important to use this custom build cause it's the only way that I know of anyways to make open-iscsi run properly in linux beta in Chrome OS

next copy this proxmox directory to an outside source be a flash drive or network share you can access the windows drive by means of /mnt/c how ever my prfered method is to install midnight commander using sudo apt install mc and access my network share on my synology nas by opening mc clicking on right and pointing it to my ftp share and copying the entire proxmox folder

next boot into Chrome OS on your Chromebook or your pc if on your pc this should work on both Cloudready Chromium as well brunch framework Rammus image Chrome OS once your in your main desktop open files program and copy proxmox folder from your transition media to your download directory next right click on downloads and enable share with linux

if you dont have linux beta enabled it's important that you run the inital linux beta setup if your using the rammus image version of Chrome OS you must enter Chrome and in the address bar type chrome://flags/#crostini-use-dlc disble flag and click restart

next click on the clock icon in the lower right hand corner then in menu click on the gear icon to enter settings then click on the advaned option then the sub option developers then inside that menu click on Linux development environment (Beta) if you have just installed the linux beta then repeat the option for sharing next open the manage shared folders to make sure your shared folder is showing if so hit back and goto linux beta main menu

Next click on port forwarding option and click on add set type to tcp under port type

8006

Under lable type

proxmox tcp

Then click add

Next click add again this time set typ to udp under port type

8006

Under lable type 

proxmox udp

Then click add

Then enable both ports

the open the terminal program in your programs menu this is important so that it mounts your shared folders once it takes you to the bash screen go ahead and type exit

Now you are ready to begin the creation of the proxmox container hold down Ctrl Alt T to open Chrome OS Developer Shell or Crosh the type

vmc start termina

next type

cd /mnt/shared/MyFiles/Downloads/proxmox

lxc delete penguin --force

lxc image import lxd.tar.xz rootfs.squashfs --public --alias proxmox

lxc launch local:proxmox penguin

lxc launch 

If you see the penguin container the you'll know you where successful 

next type 

lxc stop penguin

lxc network attach lxdbr0 penguin eth0 eth0

lxc config device set penguin eth0 ipv4.address 100.115.92.194

lxc start penguin

lxc exec penguin -- bash

next step we need to set a full static ip cause it's required for proxmox to install correctly 

nano /etc/network/interfaces

under line iface eth0 inet dhcp type

address 100.115.92.194
gateway 100.115.92.193

make both these lines line up with f in iface it will only take one space on either line to do so

next change dhcp to static

next hit ctrl x then y then enter



will finish later
