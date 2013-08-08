#!/system/bootmenu/binary/busybox ash

wlan_cu -itiwlan0 -b < /system/bootmenu/config/nvs_map_commands.txt

cp -f /data/misc/wifi/nvs_map.bin /pds/wifi/
mv -f /data/misc/wifi/nvs_map.bin /system/etc/wifi/

