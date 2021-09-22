# proxmox-in-chrome-os
Run proxmox inside Chrome OS

First step run ubuntu in windows for linux subsystem 

Then goto your windows store and search and install GWSL once its installed run it from your start menu so it's running in the background

now go back to your ubuntu terminal

in ubunut run sudo apt-get install lxc 

sudo snap install core 

if socket error appears 

sudo apt-get update && sudo apt-get install -yqq daemonize dbus-user-session fontconfig

wget https://raw.githubusercontent.com/drewfranklinaustin/proxmox-in-chrome-os/main/start-snap -O ./start-snap

make sure start-snap is in your user home folder you'll have to run script every time you restart ubuntu

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

wget https://raw.githubusercontent.com/drewfranklinaustin/proxmox-in-chrome-os/main/proxmox.yaml -O ./proxmox.yaml

sudo distrobuilder build-lxd proxmox.yaml -o image.architecture=amd64 -o image.release=bullseye

It's important to use this custom build cause it's the only way that I know of anyways to make open-iscsi run properly in linux beta in Chrome OS

next copy this proxmox directory to an outside source be a flash drive or network share you can access the windows drive by means of /mnt/c also if you left click on gwsl icon in lower right hand corner of your desktop then select the linux files option an explorer window will open showing your entire ubuntu file tree and all you have to do is make your way to the proxmox directory however my prfered method is to install midnight commander using sudo apt install mc and access my network share on my synology nas by opening mc clicking on right and pointing it to my ftp share and copying the entire proxmox folder but which ever method works for you we just need to copy the folder to the transfer medium

next boot into Chrome OS on your Chromebook or your pc if on your pc this should work on both Cloudready Chromium as well brunch framework Rammus image Chrome OS once your in your main desktop open files program and copy proxmox folder from your transition media to your download directory next right click on downloads and enable share with linux

if you dont have linux beta enabled it's important that you run the inital linux beta setup if your using the rammus image version of Chrome OS you must enter Chrome and in the address bar type chrome://flags/#crostini-use-dlc disable flag and click restart

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

lxc list

If you see the penguin container the you'll know you where successful 

next type 

lxc stop penguin

lxc network attach lxdbr0 penguin eth0 eth0

lxc config device set penguin eth0 ipv4.address 100.115.92.194

lxc start penguin

lxc exec penguin -- bash

next step we need to set a full static ip cause it's required for proxmox to install correctly 

rm /etc/network/interfaces && rm /etc/hosts 

wget https://raw.githubusercontent.com/drewfranklinaustin/proxmox-in-chrome-os/main/interfaces -O /etc/network/interfaces && wget https://raw.githubusercontent.com/drewfranklinaustin/proxmox-in-chrome-os/main/hostsfirst -O /etc/hosts

Then type

/etc/init.d/networking restart

Then

exit

Then

lxc restart penguin

Then

lxc exec penguin -- bash

Then

hostname --ip-address 

Then

hostname prox4m1.proxmox.com

Then

wget https://enterprise.proxmox.com/debian/proxmox-release-bullseye.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg 

Then

sha512sum /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg

Then

echo "deb [arch=amd64] http://download.proxmox.com/debian/pve bullseye pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list

Then

apt-get update && apt-get full-upgrade -y

Then

apt-get install proxmox-ve postfix -y

When the postfix installation menu pops up choose local install and as long as you ran the hostname commands earlier it should show the correct hostname which should be prox4m1.proxmox.com

If correct then hit enter and let the setup run through estimated time 15 to 30 minutes depending on hardware

Warning if you get to the end of the install and installation errors pop up don't freak out and think you've failed

Next type

exit

Then

lxc restart penguin

The lxc exec penguin -- bash

If error occurred type dpkg --configure -a && apt-get upgrade and it will run the setup process again except this time it should only a few seconds and you'll see that it properly installed this time

Now type

rm /etc/apt/sources.list.d/pve-enterprise.list && rm /etc/apt/sources.list.d/pve-install-repo.list && sudo apt-get remove os-prober --purge

Now that proxmox is installed now it's time setup Chrome OS app integration

Now Type

echo "deb [trusted=yes] https://storage.googleapis.com/cros-packages/90 buster main" > /etc/apt/sources.list.d/cros.list

Then

wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -

Then

wget https://storage.googleapis.com/cros-packages/77/main/c/cros-guest-tools/cros-guest-tools_0.22_all.deb && wget https://storage.googleapis.com/cros-packages/70/main/c/cros-ui-config/cros-ui-config_0.12_all.deb && wget http://ftp.us.debian.org/debian/pool/main/a/adwaita-icon-theme/adwaita-icon-theme_3.22.0-1+deb9u1_all.deb 

Then

apt-get update && apt install -f -y ./cros-guest-tools_0.22_all.deb ./cros-ui-config_0.12_all.deb ./adwaita-icon-theme_3.22.0-1+deb9u1_all.deb 

rm ./cros-guest-tools_0.22_all.deb && rm cros-ui-config_0.12_all.deb && rm adwaita-icon-theme_3.22.0-1+deb9u1_all.deb 

Then

sudo apt-get update && sudo apt-get upgrade

Then

passwd root

Then

exit

Then

lxc restart proxmox

Then

lxc exec penguin -- bash

Then

rm /etc/hosts

Then

wget https://raw.githubusercontent.com/drewfranklinaustin/proxmox-in-chrome-os/main/hostsfinal -O /etc/hosts

Then

/etc/init.d/networking restart

Then

apt autoremove

Then

apt-get clean

Then

history -c

Then

exit

Then

exit

Then

exit

Now we need to setup your terminal enviroment

Now open terminal app in your Chrome OS app menu you might have to open it serveral times cause it's rebuilding your user profile it will be the same user you started with in the inital linux beta setup once that's done open your Chrome Browser and in the address bar type

https://100.115.92.194:8006

And except the security warning

And there you go Proxmox running in Chrome OS if you have any suggestions to speed this process up I'm all ears enjoy



