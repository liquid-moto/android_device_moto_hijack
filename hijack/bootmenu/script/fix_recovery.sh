#!/sbin/sh

######## BootMenu Script
######## Execute Fix Recovery

export PATH=/sbin:/system/xbin:/system/bin
 
BM_REC="/system/bootmenu/recovery"
PRE_REC="/preinstall/recovery"

# these first commands are duplicated for broken systems
mount -o remount,rw rootfs /

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
 
