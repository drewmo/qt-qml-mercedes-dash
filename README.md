# QtCreator QML based OBDII connected Mercedes gauge cluster. Uses a PCAN hardware device to poll engine data and render the OEM styled gauages.
Raspberry Pi based Digital Gauge Cluster

## Projects used to setup Ubuntu for development and cross compiling:
- https://github.com/UvinduW/Cross-Compiling-Qt-for-Raspberry-Pi-4
- https://www.interelectronix.com/configuring-qt-creator-ubuntu-20-lts-cross-compilation.html
- https://www.interelectronix.com/qt-515-cross-compilation-raspberry-compute-module-4-ubuntu-20-lts.html
- Original inspiration from https://github.com/joshellissh/pi-dgc

## Project info

Originally I was going with a setup like @joshellissh was using for his digital cluster gauage (V1), but I needed to rebase my project to QtCreator [QML](https://doc.qt.io/qt-5/qmlapplications.html). The main reason is I needed to be able to render a vertical style cluster gauge and QML supported rotating the display out of the box. I worked from the [example project](https://doc.qt.io/qt-5/qtquickextras-dashboard-example.html) included with QtCreator to customize the gauage to my needs.

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
