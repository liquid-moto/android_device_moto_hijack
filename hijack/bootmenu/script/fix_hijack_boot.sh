#!/sbin/sh

######## BootMenu Script
######## Execute Fix Hijack-boot.zip

export PATH=/sbin:/system/xbin:/system/bin
 
HIJACK_BOOT_REC=/system/bootmenu/recovery/hijack-boot.zip
HIJACK_BOOT=/system/etc/hijack-boot.zip

# these first commands are duplicated for broken systems
mount -o remount,rw rootfs /

if [ -f $HIJACK_BOOT_REC ]; then
   cp -f $HIJACK_BOOT_REC $HIJACK_BOOT
fi
