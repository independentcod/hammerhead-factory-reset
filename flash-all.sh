#!/usr/bin/bash
echo 'BASH Script made by @independentcod;'
echo 'github.com/independentcod/';
echo 'Needs ROOT access to work.';
sudo apt update && sudo apt install android-tools-fastboot wget unzip -y;
nexusdir="hammerhead-mob31e/"
fastboot="sudo /bin/fastboot"
wget="/bin/wget"
unzip="/bin/unzip"
file="hammerhead-mob31e-factory-90504514.zip"
imgfile="image-hammerhead-mob31e.zip"
radioimg="radio-hammerhead-m8974a-2.0.50.2.29.img"
bootldrimg="bootloader-hammerhead-hhz20h.img"
recoveryimg="recovery.img"
bootimg="boot.img"
cacheimg="cache.img"
usrdtaimg="userdata.img"
systemimg="system.img"
if [ ! -f "$file" ]; then
$wget https://dl.google.com/dl/android/aosp/${file}
fi
if [ ! -d "$nexusdir" ]; then
mkdir $nexusdir
$unzip $file
fi
if [ ! -f "$nexusdir$recoveryimg" ]; then
cd $nexusdir
$unzip $imgfile
cd ..
fi
$fastboot oem unlock;
sleep 10;
$fastboot erase recovery;
$fastboot erase userdata;
$fastboot erase radio;
$fastboot format recovery;
$fastboot format system;
$fastboot format boot;
$fastboot format cache;
$fastboot format data;
$fastboot format userdata;
$fastboot flash boot $nexusdir$bootimg;
$fastboot flash bootloader $nexusdir$bootldrimg;
$fastboot flash radio $nexusdir$radioimg;
$fastboot flash cache $nexusdir$cacheimg;
$fastboot reboot bootloader;
sleep 5;
$fastboot flash userdata $nexusdir$usrdtaimg;
$fastboot flash recovery $nexusdir$recoveryimg;
$fastboot flash system $nexusdir$systemimg;
$fastboot oem lock;
$fastboot reboot;
exit 0
