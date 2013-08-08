/*
 * Copyright (C) 2007-2011 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/reboot.h>
#include <unistd.h>

#include "common.h"
#include "extendedcommands.h"
#include "overclock.h"
#include "minui/minui.h"
#include "bootmenu_ui.h"
#include "hijack.h"

//#define DEBUG_ALLOC

#define MODES_COUNT 1
const char* modes[] = {
  "bootmenu",
};

/**
 * show_menu_tools()
 *
 */
int show_menu_tools(void) {

#define TOOL_ADB     0
#define TOOL_USB     2
#define TOOL_CDROM   3
#define TOOL_SYSTEM  4
#define TOOL_DATA    5
#define TOOL_NATIVE  6

#define TOOL_UMOUNT  8

  int status;

  const char* headers[] = {
        " Don't forget to stop the share after use !",
        "",
        " # Tools -->",
        "",
        NULL
  };
  char** title_headers = prepend_title(headers);

  char* items[] =  {
        "  [ADB Daemon]",
        "",
        "  [Share SD Card]",
        "  [Share Drivers]",
        "  [Share system]",
        "  [Share data]",
        "",
        "  [Stop USB Share]",
        "  --Go Back.",
        NULL
  };

  int chosen_item = get_menu_selection(title_headers, items, 1, 0);

  switch (chosen_item) {
    case TOOL_ADB:
      ui_print("ADB Deamon....");
      status = exec_script("/system/bin/hijack",FILE_ADBD);
      ui_print("Done..\n");
      break;

    case TOOL_UMOUNT:
      ui_print("Stopping USB share...");
      sync();
      mount_usb_storage("");
      status = set_usb_device_mode("acm");
      ui_print("Done..\n");
      break;

    case TOOL_USB:
      ui_print("USB Mass Storage....");
      status = exec_script("/system/bin/hijack",FILE_SDCARD);
      ui_print("Done..\n");
      break;

    case TOOL_CDROM:
      ui_print("USB Drivers....");
      status = exec_script("/system/bin/hijack",FILE_CDROM);
      ui_print("Done..\n");
      break;

    case TOOL_SYSTEM:
      ui_print("Sharing System Partition....");
      status = exec_script("/system/bin/hijack",FILE_SYSTEM);
      ui_print("Done..\n");
      break;

    case TOOL_DATA:
      ui_print("Sharing Data Partition....");
      status = exec_script("/system/bin/hijack",FILE_DATA);
      ui_print("Done..\n");
      break;

    default:
      break;
  }

  free_menu_headers(title_headers);
  return 0;
}

int int_mode(char * mode) {
  int m;
  for (m=0; m < MODES_COUNT; m++) {
    if (0 == strcmp(modes[m], mode)) {
      return m;
    }
  }
  return 0;
}

int get_bootmode(int clean) {
  char mode[32];
  int m;
  FILE* f = fopen(FILE_BOOTMODE, "r");
  if (f != NULL) {
     // One-shot bootmode, bootmode.conf is deleted after
     fscanf(f, "%s", mode);
     fclose(f);

     if (clean) {
        // unlink(FILE_BOOTMODE); //buggy unlink ?
          exec_script(FILE_BOOTMODE_CLEAN,DISABLE);
      }

      m = int_mode(mode);
      if (m >= 0) return m;
  }

  return 9;
}
          
int battery_level() {
  int state = 0;
  FILE* f = fopen(SYS_BATTERY_LEVEL, "r");
  if (f != NULL) {
    fscanf(f, "%d", &state);
    fclose(f);
  }
  return state;
}

int show_menu_fixes(void) {

   #define FIX_HIJACK_BOOT_ZIP     0
   #define FIX_RECOVERY            1
   #define FIX_WIFI__NVS_MAP       2
   #define FIX_MT_2                3
   #define FIX_MT_8                4

   int select = 0;

   const char* headers[] = {
      " # Fixes -->",
      "",
      NULL
   };

   char** title_headers = prepend_title(headers);

   char* items[] = {
      "  [Fix hijack-boot.zip (BM won't boot to phone)]",
      "  [Fix Recovery]",
      "  [Fix Wifi - nvs_map.bin]",
      "  [Fix Multitouch - 2pt]",
      "  [Fix Multitouch - 8pt]",
      "  --Go Back.",
      NULL
   };

   for (;;) {
      int chosen_item = get_menu_selection(title_headers, items, 1, select);

      switch (chosen_item) {
         case FIX_HIJACK_BOOT_ZIP:
            ui_print("Fixing hijack-boot.zip ...\n");
            exec_script("/system/bin/hijack",FILE_FIX_HIJACK_BOOT);
            break;
         case FIX_RECOVERY:
            ui_print("Fixing recovery ...\n");
            exec_script("/system/bin/hijack", FILE_FIX_RECOVERY);
            break;
         case FIX_WIFI__NVS_MAP:
            ui_print("Fixing Wifi ...\n");
            ui_print("Creating /pds/wifi/nvs_map.bin ...\n");
            ui_print("Creating /system/etc/wifi/nvs_map.bin ...\n");
            exec_script("/system/bin/hijack", FILE_FIX_WIFI_NVS);
            break;
         case FIX_MT_2:
            ui_print("Setting Multitouch to 2 Points ...\n");
            exec_script("/system/bin/hijack", FILE_FIX_MT_2);
            break;
         case FIX_MT_8:
            ui_print("Setting Multitouch to 8 Points ...\n");
            exec_script("/system/bin/hijack", FILE_FIX_MT_8);
            break;
         default:
            free_menu_headers(title_headers);
            return 0;
      }
      select = chosen_item;
   }

   free_menu_headers(title_headers);
   return 0;
}

/**
 * show_menu_recovery()
 *
 */
int show_menu_recovery(void) {

  #define RECOVERY_CWM        0
  #define RECOVERY_RZR        1

  int status, res=0;

  const char* headers[] = {
        " # Recovery -->",
        "",
        NULL
  };
  char** title_headers = prepend_title(headers);

  char* items[] =  {
        "  [CWM Recovery]",
        "  [RZR Recovery]",
        "  --Go Back.",
        NULL
  };

  int chosen_item = get_menu_selection(title_headers, items, 1, 0);

  switch (chosen_item) {
    case RECOVERY_CWM:
      ui_print("Starting CWM Recovery..\n");
      exec_script("/system/bin/hijack",FILE_CWR_RECOVERY);
      res = 1;
      break;

    case RECOVERY_RZR:
      ui_print("Starting RZR Recovery..\n");
      exec_script("/system/bin/hijack",FILE_RZR_RECOVERY);
      res = 1;
      break;

    default:
      break;
  }

  free_menu_headers(title_headers);
  return res;
}

/**
 * led_alert()
 *
 */
int led_alert(const char* color, int value) {
  char led_path[PATH_MAX];
  sprintf(led_path, "/sys/class/leds/%s/brightness", color);
  FILE* f = fopen(led_path, "w");

  if (f != NULL) {
    fprintf(f, "%d", value);
    fclose(f);
    return 0;
  }
  return 1;
}

/**
 * usb_connected()
 *
 */
int usb_connected() {
  int state;
  FILE* f;

  //usb should be 1 and ac 0
  f = fopen(SYS_USB_CONNECTED, "r");
  if (f != NULL) {
    fscanf(f, "%d", &state);
    fclose(f);
    if (state) {
      f = fopen(SYS_POWER_CONNECTED, "r");
      if (f != NULL) {
        fscanf(f, "%d", &state);
        fclose(f);
        return (state == 0);
      }
    }
  }
  return 0;
}

int adb_started() {
  int res=0;

  return res;
}

/**
 * Native USB ADB Mode Switch
 *
 */
int set_usb_device_mode(const char* mode) {

  #ifndef BOARD_USB_MODESWITCH
  #define BOARD_USB_MODESWITCH  "/dev/usb_device_mode"
  #endif

  FILE* f = fopen(BOARD_USB_MODESWITCH, "w");
  if (f != NULL) {

    fprintf(f, "%s", mode);
    fclose(f);

    LOGI("set usb mode=%s\n", mode);
    return 0;

  } else {
    fprintf(stdout, "E:Can't open " BOARD_USB_MODESWITCH " (%s)\n", strerror(errno));
    return errno;
  }
}

int mount_usb_storage(const char* part) {

  #ifndef BOARD_UMS_LUNFILE
  #define BOARD_UMS_LUNFILE  "/sys/devices/platform/usb_mass_storage/lun0/file"
  #endif

  FILE* f = fopen(BOARD_UMS_LUNFILE, "w");
  if (f != NULL) {

    fprintf(f, "%s", part);
    fclose(f);
    return 0;

  } else {
    ui_print("E:Unable to write to lun file (%s)", strerror(errno));
    return errno;
  }
}

