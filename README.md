## Prepare Raspberry Pi

1. Download RASPBIAN STRETCH LITE image from https://www.raspberrypi.org/downloads/raspbian/
2. Unzip image
```
unzip 2017-11-29-raspbian-stretch-lite.zip
```
3. Insert SD card into card reader
4. Determine SD card device name
```
sudo fdisk -l
...
Disk /dev/mmcblk0: 31.3 GB
...
```
5. Copy image to SD card
```
sudo dd if=2017-11-29-raspbian-stretch-lite.img of=/dev/mmcblk0 bs=4M conv=fsync
```
6. Determine SD card boot partition name
```
sudo fdisk -l
...
Disk /dev/mmcblk0: 31.3 GB
...
   Device Boot      Start         End      Blocks   Id  System
/dev/mmcblk0p1       8192       93236      42522+    c  W95 FAT32 (LBA)
...
```
5. Mount SD card boot partition
```
sudo mount -t vfat /dev/mmcblk0p1 /mnt
```
6. Enable SSH
```
sudo touch /mnt/ssh
```
7. Enable WIFI (optional)
```
sudo cat >/etc/wpa_supplicant/wpa_supplicant.conf <<EOF
update_config=1
network={
    ssid="SSID"
    psk="SECRET"
}
EOF
```
8. Un-mount SD card boot partition
```
sudo umount /mnt
```
9. Insert SD card into Raspberry PI
10. Plug-in LAN cable and power supply.
11. SSH to device
```
ssh pi@raspberrypi
```
12. Copy SSH public key to device
```
ssh-copy-id pi@raspberrypi
```
OR
```
ssh pi@raspberrypi 'cat >> ~/.ssh/authorized_keys' < ~/.ssh/id_rsa.pub
```
12. Configure
```
sudo raspi-config
```
* Change User Password (passwd)
* Network Options
  * N1 Hostname (/etc/hostname, /etc/hosts)
* Localisation Options
  * I1 Change Locale: en_US.UTF-8 UTF-8
  * I2 Change Timezone (/etc/localtime)
13. Reboot

## Provision

```
ansible-playbook -i hosts provision-printerpi.yml
```
```
ansible-playbook -i hosts provision-serverpi.yml
```
