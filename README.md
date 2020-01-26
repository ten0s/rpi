## Prepare Raspberry Pi
https://www.raspberrypi.org/documentation/installation/installing-images/linux.md

1. Download latest lite image from https://www.raspberrypi.org/downloads/raspbian/
2. Unzip image
```
unzip 2019-09-26-raspbian-buster-lite.zip
```
3. Insert SD card into card reader
4. Determine SD card device name
```
sudo fdisk -l
...
Disk /dev/mmcblk0: 31.3 GB
...
```
5. Un-mount SD card (optional)
```
sudo umount /dev/mmcblk0
```
6. Copy image to SD card
```
sudo dd if=2019-09-26-raspbian-buster-lite.img of=/dev/mmcblk0 bs=4M status=progress conv=fsync
```
7. Determine SD card partition names
```
sudo fdisk -l
...
Disk /dev/mmcblk0: 31.3 GB
...
Device         Boot  Start     End Sectors  Size Id Type
/dev/mmcblk0p1        8192  532479  524288  256M  c W95 FAT32 (LBA)
/dev/mmcblk0p2      532480 4390911 3858432  1.9G 83 Linux
...
```
8. Mount SD card boot partition
```
sudo mkdir -p /mnt/boot
sudo mount -t vfat /dev/mmcblk0p1 /mnt/boot
```
9. Enable SSH
```
sudo touch /mnt/boot/ssh
```
10. Enable WIFI (optional)
```
sudo tee /mnt/boot/wpa_supplicant.conf << EOF
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
11. Un-mount SD card boot partition
```
sudo umount /mnt/boot
```
12. Remove SD card from card reader
13. Insert SD card into Raspberry PI
14. Plug-in LAN cable and power supply.
15. SSH to device
```
ssh pi@raspberrypi
```
16. Copy SSH public key to device
```
ssh-copy-id pi@raspberrypi
```
OR
```
ssh pi@raspberrypi 'cat >> ~/.ssh/authorized_keys' < ~/.ssh/id_rsa.pub
```
17. Configure
```
sudo raspi-config
```
* Change User Password (passwd)
* Network Options
  * N1 Hostname (/etc/hostname, /etc/hosts)
* Localisation Options
  * I1 Change Locale: en_US.UTF-8 UTF-8
  * I2 Change Timezone (/etc/localtime)
18. Reboot

## Provision

```
./provision-printerpi.sh [--tags ...]

```
```
./provision-serverpi.sh [--tags ...]
```
