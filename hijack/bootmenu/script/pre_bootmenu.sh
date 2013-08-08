#!/system/bootmenu/binary/busybox ash

######## BootMenu Script
######## Execute Pre BootMenu

source /system/bootmenu/script/_config.sh

######## Main Script

BB="/sbin/busybox"
BB_BM="/system/bootmenu/binary/busybox"
BM_REC="/system/bootmenu/recovery"
PRE_REC="/preinstall/recovery"

## reduce lcd backlight to save battery
echo 64 > /sys/class/leds/lcd-backlight/brightness

# these first commands are duplicated for broken systems
mount -o remount,rw rootfs /

if [ ! -f $BM_REC/hijack-boot.zip ]; then
   cp -f /system/etc/hijack-boot.zip $BM_REC/
fi

if [ ! -d $PRE_REC ]; then
   mkdir $PRE_REC
fi

if [ ! -f $PRE_REC/cwm-recovery.zip ]; then
   cp -f $BM_REC/cwm-recovery.zip $PRE_REC/
fi

if [ ! -f $PRE_REC/rzr-recovery.zip ]; then
   cp -f $BM_REC/rzr-recovery.zip $PRE_REC/
fi

if [ ! -f $PRE_REC/recovery.zip ]; then
   cp -f $BM_REC/recovery.zip $PRE_REC/
fi

if [ ! -f $PRE_REC/update-binary ]; then
   cp -f $BM_REC/update-binary $PRE_REC/
fi

# create the basis for the /sbin folder
mkdir /sbin
cp -f /system/bootmenu/binary/adbd.root /sbin/adbd.root
cp -f /system/bootmenu/binary/busybox /sbin/busybox
cp -f /system/bootmenu/binary/lsof /sbin/lsof

if [ ! -f /pds/wifi/nvs_map.bin ] || [ ! -f /system/etc/wifi/nvs_map.bin ]; then
   /system/bootmenu/script/nvs_map_creation.sh
fi

BB="/sbin/busybox"

# busybox sym link..
for cmd in $($BB --list); do
    $BB ln -s /sbin/busybox /sbin/$cmd
done

# custom adbd (allow always root)
cp -f /system/bootmenu/binary/adbd.root /sbin/adbd.root
chown 0.0 /sbin/adbd.root
chmod 4755 /sbin/adbd.root

$BB chmod +rx /sbin/*

if [ -f /system/bootmenu/script/overclock.sh ]; then
   /system/bootmenu/script/overclock.sh safe
fi

exit 0
