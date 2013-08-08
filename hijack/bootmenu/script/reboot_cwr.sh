#!/system/bin/sh
#
# Reboot to CWR Recovery

RECOVERY=/preinstall/recovery/cwm-recovery.zip
BACKUP_REC=/system/bootmenu/recovery/cwm-recovery.zip

if [ ! -f $RECOVERY ]; then
   cp -f $BACKUP_REC $RECOVERY
fi

cp -f $RECOVERY /preinstall/recovery/recovery.zip
sync

echo 1 > /data/.recovery_mode
sync

/system/bin/reboot

