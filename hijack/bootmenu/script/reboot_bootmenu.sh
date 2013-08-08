#!/system/bin/sh
#
# Reboot to BootMenu

echo "1" > "/data/.bootmenu"
sync

/system/bin/reboot

