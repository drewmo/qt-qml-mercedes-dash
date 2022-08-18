# QtCreator QML based OBDII connected Mercedes gauge cluster. Uses a PCAN hardware device to poll engine data and render the OEM styled gauages.
Raspberry Pi based Digital Gauge Cluster

Setup steps on Buster Lite:
- raspi-config / Boot Options / Console Autologin
- `sudo apt-get install libgles2`
- `sudo apt-get install --no-install-recommends xserver-xorg x11-xserver-utils xinit`
- `sudo apt-get install --no-install-recommends chromium-browser`
- `sudo apt-get install unclutter`
- `sudo apt-get install default-jdk`
- Follow all steps on http://skpang.co.uk/catalog/images/raspberrypi/pican/PICAN3_UGA_10.pdf to setup/enable the PiCAN3
- Follow instructions on https://www.raspberrypi.org/forums/viewtopic.php?t=24679#p227301 to set the proper resolution
- `mkdir ~/pidgc`
- Put `bin/pidgc.jar` into ~/pidgc folder
- Copy `config.ini` into ~/pidgc folder
- Edit `/boot/config.txt`. Add:
~~~
initial_turbo=60
disable_splash=1
boot_delay=0
~~~
- Add `quiet fastboot` to `/boot/cmdline.txt`
- Copy contents of `linux/network_interfaces` from repo into FILE `/etc/network/interfaces`
- Add contents of `linux/.xinitrc` from repo into file `~/.xinitrc`
- Add contents of `linux/.bash_profile` from repo into file `~/.bash_profile`
- Copy contents of `linux/pidgc.service` from repo into file `/etc/systemd/system/pidgc.service`
- `sudo systemctl enable pidgc.service`
- `sudo /sbin/ip link set can0 up type can bitrate 500000`
- `sudo adduser pi dialout`
- Disable unused services once everything is done. This decreases boot time substantially:
  - sudo systemctl disable ssh
  - sudo systemctl disable hciuart 
  - sudo systemctl disable nmbd # If you have samba installed
  - sudo systemctl disable smbd # If you have samba installed
  - sudo systemctl disable systemd-timesyncd
  - sudo systemctl disable wpa_supplicant
  - sudo systemctl disable rpi-eeprom-update
  - sudo systemctl disable raspi-config
  - sudo systemctl disable networking
  - sudo systemctl disable dhcpcd

Now when you reboot the system should start into startx and run Chromium with http://localhost:8080.
