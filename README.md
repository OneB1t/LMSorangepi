# LMSorangepi
[Logitech media server](https://github.com/Logitech/slimserver) with 3 independent zones setup on single Orange PI PC+ and awesome [Material design](https://github.com/CDrummond/lms-material). Based on [Armbian Linux](https://www.armbian.com). Goal of this project was to have sonos-like audio system for fraction of cost.  System can theoretically support up to 5 zones with HDMI and onboard audio used as well. [Equalizer](https://github.com/raedwulf/alsaequal) to make it sound nice even with different room setups.


# Full Hardware configuration
1. [Orange PI PC+](http://www.orangepi.org/orangepipcplus/) - $25.50
2. 3x [Ugreen Sound Card External 3.5mm USB Adapter](https://www.aliexpress.com/item/Ugreen-USB-2-0-to-3-5mm-Audio-External-Sound-Card-Microphone-Earphone-Speaker-Adapter-for/32507625943.html?spm=a2g0s.9042311.0.0.27424c4dlaKRDD) -  3x $7.99
3. 3x [3.5mm cable between sound card and amplifier](https://www.aliexpress.com/item/20cm-3-5-Jack-Male-to-Male-Audio-Cable-Jack-to-Aux-Short-Cable-for-Acoustic/32833524098.html?spm=a2g0s.9042311.0.0.27424c4dlaKRDD) - 3x $1.02
4. 3x [2x50W TPA3116 amplifier](https://www.aliexpress.com/item/DC-12V-24V-TPA3116-D2-Hifi-2-0-Channel-50W-50W-Stereo-Audio-Digtail-Power-Amplifier/32817825712.html?spm=a2g0s.9042311.0.0.27424c4dlaKRDD) - 3x $7.55
5. 3x [Pyle Pro PDIC80](https://www.bhphotovideo.com/c/product/570723-REG/Pyle_Pro_PDIC80_PDIC80_8_Two_Way_In_Ceiling.html) - 3x $47
6. audio cables (shielded ethernet cables in 2x4wires configuration for audio connection which i had already) - zero cost
7. power supply for (12-24V) amplifiers and 5V for Orange Pi - used old ATX power supply

Total price for my build: ~$220

Optional: SD card for your audio i have 32GB but anything will work as long as its supported by orange pi

Optional #2: Bigger amplifier to make neighbours ears and eyes bleed but for me 2x50W (and on 12V its even less) is more than enough even that speakers should be capable of 2x300W

Optional #3: You can run 5.1 or other speaker/amplifier configuration i just decided to make it simple and have stereo sound in every zone

# How to install
1. Install armbian to internal eMMC with tutorial from here - [armbian OrangePI page](https://www.armbian.com/orange-pi-pc-plus/)
2. Install bits and pieces required for this circus: alsaequal, cpuset (apt install libasound2-plugin-equal cpuset)
3. Install LMS server and let it run after start automatically [tutorial] (http://techdelirium.blogspot.com/2016/11/easily-install-logitech-media-server.html)
4. Install squeezelite player stop it from automatically running after start with "systemctl disable squeezelite"
5. Connect everything together like that
```
 [5V DC]                                        [12/24V DC]
   |                                                 |
   |        / -------->  [USB SOUNDCARD] -----> [AMPLIFIER] ------> [SPEAKERS]
 [OrangePI] ---------->  [USB SOUNDCARD] -----> [AMPLIFIER] ------> [SPEAKERS]
            \ -------->  [USB SOUNDCARD] -----> [AMPLIFIER] ------> [SPEAKERS]
```
6. Modify /etc/asound.conf for alsaequal or use one included in this repository
7. Modify cron with "crontab -e" command to run after start script which will spin up all players and OS settings add line: @reboot /root/runclients.sh
8. Disable onboard sound card inside /etc/modprobe.d/alsa-blacklist to keep soundcards same order every start
9. Modify alsaequal settings for each zone to get best audio experience
10. Profit?

Optional: add DNS name for your device on your router or with mDNS so you can access player without IP. Avahi can announce hostname into your network in case you have multicast enabled.

# Power consumption
My script contains commands for CPU underclock to 480MHz and LAN will be limited to 100Mb these could be commented out in case you need more power for other tasks. Also each player have its own shielded CPU core. 

Power consumption for Orange Pi is around 300mA @ 5,30V at idle which is around 1.6W when all zones are used for play it can grow up to 2.5W.

# Final images

![armbian](https://user-images.githubusercontent.com/320479/56849612-16308480-68f7-11e9-9814-83480000738a.png)
![LMS2](https://user-images.githubusercontent.com/320479/56849617-23e60a00-68f7-11e9-96a1-12c7725b22f6.png)
![multiroom](https://user-images.githubusercontent.com/320479/56849627-3c562480-68f7-11e9-8a7f-63aeb6d6c522.png)
![Equalize](https://user-images.githubusercontent.com/320479/56849729-8095f480-68f8-11e9-9a07-54bf7bb9b6c0.png)

Keywords: LMS, Logitech media server, Multizone audio, Multiroom audio, audio player, Sonos, squeezelite, squeezebox, slimserver, Orange PI, armbian, cheap audioserver, volumio, ARM, spotify, youtube, 

