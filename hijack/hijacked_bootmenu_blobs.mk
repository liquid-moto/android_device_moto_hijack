# Required tools and blobs for hijackedBootmenu

hijack_root = device/motorola/hijack/hijack/bootmenu

# binary
BUILT_PREBUILD += \
   ${hijack_root}/binary/adbd:system/bootmenu/binary/adbd \
   ${hijack_root}/binary/adbd.root:system/bootmenu/binary/adbd.root \
   ${hijack_root}/binary/busybox:system/bootmenu/binary/busybox \
   ${hijack_root}/binary/lsof:system/bootmenu/binary/lsof \
   ${hijack_root}/binary/recovery:system/bootmenu/binary/recovery \

# config
BUILT_PREBUILD += \
   ${hijack_root}/config/nvs_map_commands.txt:system/bootmenu/config/nvs_map_commands.txt \
   ${hijack_root}/config/overclock.conf:system/bootmenu/config/overclock.conf \

# Fixes
BUILT_PREBUILD += \
   ${hijack_root}/fixes/09multitouch-2pt:system/bootmenu/fixes/09multitouch-2pt \
   ${hijack_root}/fixes/09multitouch-8pt:system/bootmenu/fixes/09multitouch-8pt \

# images
BUILT_PREBUILD += \
   ${hijack_root}/images/background.png:system/bootmenu/images/background.png \
   ${hijack_root}/images/indeterminate1.png:system/bootmenu/images/indeterminate1.png \
   ${hijack_root}/images/indeterminate2.png:system/bootmenu/images/indeterminate2.png \
   ${hijack_root}/images/indeterminate3.png:system/bootmenu/images/indeterminate3.png \
   ${hijack_root}/images/indeterminate4.png:system/bootmenu/images/indeterminate4.png \
   ${hijack_root}/images/indeterminate5.png:system/bootmenu/images/indeterminate5.png \
   ${hijack_root}/images/indeterminate6.png:system/bootmenu/images/indeterminate6.png \
   ${hijack_root}/images/progress_empty.png:system/bootmenu/images/progress_empty.png \
   ${hijack_root}/images/progress_fill.png:system/bootmenu/images/progress_fill.png \

# modules
BUILT_PREBUILD += \
   ${hijack_root}/modules/cpufreq_conservative.ko:system/lib/modules/cpufreq_conservative.ko \
   ${hijack_root}/modules/cpufreq_interactive.ko:system/lib/modules/cpufreq_interactive.ko \
   ${hijack_root}/modules/cpufreq_interactivex.ko:system/lib/modules/cpufreq_interactivex.ko \
   ${hijack_root}/modules/cpufreq_ondemand.ko:system/lib/modules/cpufreq_ondemand.ko \
   ${hijack_root}/modules/cpufreq_performance.ko:system/lib/modules/cpufreq_performance.ko \
   ${hijack_root}/modules/cpufreq_powersave.ko:system/lib/modules/cpufreq_powersave.ko \
   ${hijack_root}/modules/cpufreq_smartass.ko:system/lib/modules/cpufreq_smartass.ko \
   ${hijack_root}/modules/cpufreq_smartassv2.ko:system/lib/modules/cpufreq_smartassv2.ko \
   ${hijack_root}/modules/cpufreq_stats.ko:system/lib/modules/cpufreq_stats.ko \
   ${hijack_root}/modules/cpufreq_userspace.ko:system/lib/modules/cpufreq_userspace.ko \
   ${hijack_root}/modules/cpufreq_BOOSTEDassV2.ko:system/lib/modules/cpufreq_BOOSTEDassV2.ko \
   ${hijack_root}/modules/defy_more.ko:system/lib/modules/defy_more.ko \
   ${hijack_root}/modules/milestone2_more.ko:system/lib/modules/milestone2_more.ko \
   ${hijack_root}/modules/multitouch.ko:system/lib/modules/multitouch.ko \
   ${hijack_root}/modules/overclock_defy.ko:system/lib/modules/overclock_defy.ko \
   ${hijack_root}/modules/symsearch.ko:system/lib/modules/symsearch.ko \

# recovery
BUILT_PREBUILD += \
   ${hijack_root}/recovery/cwm-recovery.zip:system/bootmenu/recovery/cwm-recovery.zip \
   ${hijack_root}/recovery/recovery.zip:system/bootmenu/recovery/recovery.zip \
   ${hijack_root}/recovery/rzr-recovery.zip:system/bootmenu/recovery/rzr-recovery.zip \
   ${hijack_root}/recovery/update-binary:system/bootmenu/recovery/update-binary \

# script
BUILT_PREBUILD += \
   ${hijack_root}/script/adbd.sh:system/bootmenu/script/adbd.sh \
   ${hijack_root}/script/cdrom.sh:system/bootmenu/script/cdrom.sh \
   ${hijack_root}/script/_config.sh:system/bootmenu/script/_config.sh \
   ${hijack_root}/script/data.sh:system/bootmenu/script/data.sh \
   ${hijack_root}/script/fix_hijack_boot.sh:system/bootmenu/script/fix_hijack_boot.sh \
   ${hijack_root}/script/fix_recovery.sh:system/bootmenu/script/fix_recovery.sh \
   ${hijack_root}/script/fix_touch_2pt.sh:system/bootmenu/script/fix_touch_2pt.sh \
   ${hijack_root}/script/fix_touch_8pt.sh:system/bootmenu/script/fix_touch_8pt.sh \
   ${hijack_root}/script/nvs_map_creation.sh:system/bootmenu/script/nvs_map_creation.sh \
   ${hijack_root}/script/overclock_backup.sh:system/bootmenu/script/overclock_backup.sh \
   ${hijack_root}/script/overclock_restore.sh:system/bootmenu/script/overclock_restore.sh \
   ${hijack_root}/script/overclock.sh:system/bootmenu/script/overclock.sh \
   ${hijack_root}/script/pre_bootmenu.sh:system/bootmenu/script/pre_bootmenu.sh \
   ${hijack_root}/script/reboot_bootmenu.sh:system/bootmenu/script/reboot_bootmenu.sh \
   ${hijack_root}/script/reboot_cwr.sh:system/bootmenu/script/reboot_cwr.sh \
   ${hijack_root}/script/reboot_rzr.sh:system/bootmenu/script/reboot_rzr.sh \
   ${hijack_root}/script/recovery_cwr.sh:system/bootmenu/script/recovery_cwr.sh \
   ${hijack_root}/script/recovery_rzr.sh:system/bootmenu/script/recovery_rzr.sh \
   ${hijack_root}/script/sdcard.sh:system/bootmenu/script/sdcard.sh \
   ${hijack_root}/script/system.sh:system/bootmenu/script/system.sh

