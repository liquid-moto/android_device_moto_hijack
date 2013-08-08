#!/system/bin/sh

############ Bootmenu script
############ Overclock_Backup.sh

export PATH=/sbin:/system/xbin:/system/bin
CONFIG_FILE="/system/bootmenu/config/overclock.conf"
FS_SYSTEM=ext3                                      
PART_SYSTEM=/dev/block/mmcblk1p21
FS_SDCARD=vfat                   
PART_SDCARD=/dev/block/mmcblk0p1
BM_ROOTDIR=/system/bootmenu     
SDCARD_FOLDER=/mnt/sdcard  
FOLDER_BACKUP=$SDCARD_FOLDER/bootmenu
                                                      
mount -t $FS_SYSTEM -o remount,rw $PART_SYSTEM /system
                                
if [ ! -d $SDCARD_FOLDER ]; then
   mkdir -p $SDCARD_FOLDER 
fi
                                                             
mount -t $FS_SDCARD -o rw,noatime $PART_SDCARD $SDCARD_FOLDER
                                                                  
cp $FOLDER_BACKUP/overclock.conf $BM_ROOTDIR/config/overclock.conf
                     
umount $SDCARD_FOLDER
        
return 0
