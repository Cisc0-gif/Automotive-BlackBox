#! /bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'
user=$(whoami)

wait_func() {
read -p "PRESS ENTER TO CONTINUE" wait
}

printf "${BLUE}"
read -p "[*] Are you connected to Wifi?[y/N]: " wifi
printf "${NC}\n"
if [ $wifi == "y" ] || [ $wifi == "Y" ]; then
  printf "${BLUE}[*] continuing setup...${NC}\n"
else
  printf "${RED}[!] Please connect to WiFi before setting up RPi Black Box...${NC}\n"
  exit 1
fi

if [ $user != "pi" ]; then
  printf "${RED][!] Please sign in as user pi before continuing setup...${NC}\n"
  exit 1
else
  printf "${BLUE}[*] User: pi, continuing setup...${NC}\n"
fi

printf "${BLUE}[*] Updating, Upgrading, and Installing necessary packages...${NC}\n"
sudo apt update && sudo apt upgrade && sudo apt autoremove
sudo apt-get install motion gpac ssh samba samba-common-bin hostapd dnsmasq apache2 aircrack-ng xrdp -y

printf "${BLUE}[*] Creating directories...${NC}\n"
sudo mkdir /home/pi/.motion
sudo mkdir /home/pi/PARKED
sudo mkdir /home/pi/DRIVING
sudo mkdir /home/pi/BB_NETWORK

printf "${BLUE}[*] Writing to '/etc/dhcpcd.conf' ${NC}\n"
echo 'denyinterfaces wlan0' >> /etc/dhcpcd.conf

printf "${BLUE}[*] Writing to '/etc/network/interfaces' ${NC}\n"
sudo curl https://pastebin.com/raw/8qD0qtfL >> /etc/network/interfaces

printf "${BLUE}[*] Writing to '/home/pi/BB_NETWORK' ${NC}\n"
sudo curl https://pastebin.com/raw/vaUidVuW > /home/pi/BB_NETWORK/hostapd.conf

printf "${BLUE}[*] Writing Samba SMB Server Configurations...${NC}\n"
sudo curl https://pastebin.com/raw/UsTCbuwL >> /etc/samba/smb.conf
sudo smbpasswd -a pi
sudo systemctl restart smbd

printf "${BLUE}[*] Writing SSH Server Configuration...${NC}\n"
sudo curl https://pastebin.com/raw/RnsLZpC5 > /etc/ssh/sshd_config
sudo service ssh restart

printf "${BLUE}[*] Writing 'Parked' Motion Configuration...${NC}\n"
sudo curl https://pastebin.com/raw/aK0U3jhK > /home/pi/.motion/parked.conf

printf "${BLUE}[*] Writing Default Motion Configuration...${NC}\n"
echo "start_motion_daemon = yes" > /etc/default/motion

printf "${BLUE}[*] Writing alias bash scripts...${NC}\n"
sudo curl https://pastebin.com/raw/dst3FB7d > /home/pi/BB_NETWORK/network_init.sh

printf "${BLUE}[*] Writing cronjob for 'network_init.sh'...${NC}\n"
echo "@reboot bash /home/pi/BB_NETWORK/network_init.sh" > /etc/cron.d/network_init

printf "${BLUE}[*] Writing 'Parked' bash Configuration...${NC}\n"
sudo curl https://pastebin.com/raw/0c4MNkrD > /home/pi/.motion/parked.sh

printf "${BLUE}[*] Writing 'Driving' bash Confiugration...${NC}\n"
sudo curl https://pastebin.com/raw/fe8UeA59 > /home/pi/.motion/driving.sh

printf "${BLUE}[*] Downloading 'SecureHTTPServer.py' source...${NC}\n"
sudo curl https://pastebin.com/raw/vaeFt2Bn > /home/pi/.motion/SecureHTTPServer.py

printf "${BLUE}[*] Writing aliases to '.bashrc'...${NC}\n"
echo "alias BB_Dashcam_on='bash /home/pi/.motion/driving.sh'" > /home/pi/.bashrc
echo "alias BB_Dashcam_parked='bash /home/pi/.motion/parked.sh'" > /home/pi.bashrc
echo "alias BB_Dashcam_off='sudo service motion stop && ps aux | grep python'" > /home/pi/.bashrc
echo "alias BB_Network_on='bash /home/pi/BB_NETWORK/network_init.sh'" > /home/pi/.bashrc
echo "alias BB_Network_off='sudo service hostapd stop'" > /home/pi/.bashrc

printf "${GREEN}[+] Setup Complete! ${NC}\n"
printf "${BLUE}[*] Camera controls: BB_Dashcam_on(Driving Mode), BB_Dashcam_parked, BB_Dashcam_off, BB_Network_on, BB_Network_off"

