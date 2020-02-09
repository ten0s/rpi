## [Prepare Raspberry Pi](https://www.raspberrypi.org/documentation/installation/installing-images/linux.md)

1. Download the latest lite image from https://www.raspberrypi.org/downloads/raspbian/
```
$ wget --trust-server-names https://downloads.raspberrypi.org/raspbian_lite_latest
```
2. Ensure checksum is correct
```
$ sha256sum 2020-02-05-raspbian-buster-lite.zip
7ed5a6c1b00a2a2ab5716ffa51354547bb1b5a6d5bcb8c996b239f9ecd25292b  2020-02-05-raspbian-buster-lite.zip
```
3. Unzip image
```
$ unzip 2020-02-05-raspbian-buster-lite.zip
```
4. Insert SD card into card reader
5. Determine SD card device name
```
$ sudo fdisk -l
...
Disk /dev/mmcblk0: 31.3 GB
...
```
6. Un-mount SD card (if gets mounted automatically)
```
$ sudo umount /dev/mmcblk0p*
```
7. Copy image to SD card
```
$ sudo dd if=2020-02-05-raspbian-buster-lite.img of=/dev/mmcblk0 bs=4M status=progress conv=fsync
```
8. Determine SD card partition names
```
$ sudo fdisk -l
...
Disk /dev/mmcblk0: 31.3 GB
...
Device         Boot  Start     End Sectors  Size Id Type
/dev/mmcblk0p1        8192  532479  524288  256M  c W95 FAT32 (LBA)
/dev/mmcblk0p2      532480 4390911 3858432  1.9G 83 Linux
...
```
9. Un-mount SD card (if gets mounted automatically)
```
$ sudo umount /dev/mmcblk0p*
```
10. Mount SD card boot partition
```
$ sudo mkdir -p /mnt/boot
$ sudo mount -t vfat /dev/mmcblk0p1 /mnt/boot
```
10. Enable SSH
```
$ sudo touch /mnt/boot/ssh
```
11. Enable WIFI (optional). Replace \<SSID\> and \<SECRET\> with correct values
```
$ sudo tee /mnt/boot/wpa_supplicant.conf << EOF
country=US
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
network={
    ssid="<SSID>"
    psk="<SECRET>"
    scan_ssid=1
    key_mgmt=WPA-PSK
}
EOF
```
12. Un-mount SD card boot partition
```
$ sudo umount /mnt/boot
```
13. Remove SD card from card reader
14. Insert SD card into Raspberry PI
15. Plug-in LAN cable (or use WIFI) and power supply.
16. After a couple of minutes you should be able to ping
```
$ ping -c 1 raspberrypi
PING raspberrypi (192.168.100.33) 56(84) bytes of data.
64 bytes from raspberrypi (192.168.100.33): icmp_seq=1 ttl=64 time=5.69 ms
...
```
17. Generate your SSH key pair (if you don't have one)
```
$ ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
```
18. Copy your SSH public key. Default password for the user pi is raspberry
```
$ ssh -F /dev/null pi@raspberrypi 'mkdir -p ~/.ssh/; cat >> ~/.ssh/authorized_keys' < ~/.ssh/id_rsa.pub
```
19. Now you should be able to SSH without password
```
$ ssh pi@raspberrypi
```
20. Configure
```
$ sudo raspi-config
```
* Change User Password (passwd)
* Network Options
  * N1 Hostname (/etc/hostname, /etc/hosts)
* Localisation Options
  * I1 Change Locale: en_US.UTF-8 UTF-8
  * I2 Change Timezone (/etc/localtime)
21. Reboot
```
$ sudo reboot
```

## Provision

```
$ ./provision-printerpi.sh [--tags ...]

```
```
$ ./provision-serverpi.sh [--tags ...]
```
