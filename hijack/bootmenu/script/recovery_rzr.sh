#!/sbin/sh

######## BootMenu Script
######## Execute [Latest Recovery] Menu

export PATH=/sbin:/system/xbin:/system/bin

mount | grep "/preinstall"
if [ $? -ne 0 ]; then
   mount -t ext3 -o rw /dev/block/mmcblk1p23 /preinstall
   cp -f /preinstall/recovery/rzr-recovery.zip /preinstall/recovery/recovery.zip
   sync
   umount /preinstall
else
   cp -f /preinstall/recovery/rzr-recovery.zip /preinstall/recovery/recovery.zip
   sync
fi

mount | grep "/data"
if [ $? -ne 0]; then
   mount -t ext3 -o rw /dev/block/mmcblk1p24 /data
   echo "1" > /data/.recovery_mode
   sync
   umount /data
else
   echo "1" > /data/.recovery_mode
   sync
fi

