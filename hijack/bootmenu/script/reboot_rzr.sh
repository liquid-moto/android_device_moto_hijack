#!/system/bin/sh
#
# Reboot to RZR Recovery

RECOVERY=/preinstall/recovery/rzr-recovery.zip
BACKUP_REC=/system/bootmenu/recovery/rzr-recovery.zip

if [ ! -f $RECOVERY ]; then
   cp -f $BACKUP_REC $RECOVERY
fi

cp -f $RECOVERY /preinstall/recovery/recovery.zip
sync                           
                               
echo 1 > /data/.recovery_mode  
sync              
                               
/system/bin/reboot

