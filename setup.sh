#!/bin/sh
sudo apt-get install wget nala nano gpg -f -y
sudo usermod -aG sudo drewfranklinaustin 
sudo passwd root && sudo passwd drewfranklinaustin
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub > linux_signing_key.pub && sudo install -D -o root -g root -m 644 linux_signing_key.pub /etc/apt/keyrings/linux_signing_key.pub && sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/linux_signing_key.pub] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list' && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub > linux_signing_key.pub 
sudo dpkg --add-architecture i386 && sudo rm /etc/apt/sources.list && sudo wget https://raw.githubusercontent.com/drewfranklinaustin/proxmox-in-chrome-os/main/steamsources.list -O /etc/apt/sources.list && sudo wget https://repo.steampowered.com/steam/archive/stable/steam.gpg -O /usr/share/keyrings/steam.gpg && sudo apt-key adv --refresh-keys --keyserver keyserver.ubuntu.com
sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade && apt-get full-upgrade
sudo apt-get build-dep fuse fuse3 google-chrome-stable flatpak libu2f-udev mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386 flatpak git build-essential libssl-dev software-properties-common bridge-utils gnupg aptitude binutils libsquashfuse0 golang-go debootstrap rsync mc tasksel steamos-base-files steam steam-launcher steamos-compositor squashfuse snapd steamos-modeswitch-inhibitor valve-wallpapers xfce4 xfce4-goodies lightdm -y
sudo apt-get install valve-archive-keyring -y
sudo apt-get install google-chrome-stable flatpak libu2f-udev mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386 flatpak git build-essential libssl-dev software-properties-common bridge-utils gnupg aptitude binutils libsquashfuse0 golang-go debootstrap rsync mc tasksel steamos-base-files steam steam-launcher steamos-compositor squashfuse snapd steamos-modeswitch-inhibitor valve-wallpapers xfce4 xfce4-goodies lightdm python3 python3-venv python3-pip python3-dev -y
sudo aptitude install fuse fuse3
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo 
sudo apt update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade && sudo apt install -f -y
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb && sudo apt install ./chrome-remote-desktop_current_amd64.deb -y && sudo apt-get install -f && sudo rm ./chrome-remote-desktop_current_amd64.deb && sudo apt list --upgradable && sudo dpkg --configure -a && sudo apt-get -o Debug::pkgProblemResolver=yes dist-upgrade
sudo apt-get -t brewmaster install linux-image-amd64 && sudo apt full-upgrade -y && sudo apt autoremove 
sudo dpkg -r fuse 
sudo apt-get -f install
sudo apt-get clean
sudo rm ./setup.sh

