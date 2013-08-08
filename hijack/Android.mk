LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
include $(LOCAL_PATH)/hijacked_bootmenu_blobs.mk

LOCAL_SRC_FILES := \
        hijack.c \
        extendedcommands.c \
        overclock.c \
        checkup.c \
        default_bootmenu_ui.c \
        ui.c \

BOOTMENU_VERSION:=1.1.4
LOCAL_MODULE := hijack
LOCAL_MODULE_TAGS := optional
LOCAL_STATIC_LIBRARIES := \
        libminui_bm \
        libpixelflinger_static \
        libcutils \
        libbusybox \
        libclearsilverregex \
        libm \
        libpng \
        libz \
        libstdc++ \
        libc \

LOCAL_FORCE_STATIC_EXECUTABLE := true

BOARD_HIJACK_LOG_ENABLE := false

ifneq ($(BOARD_HIJACK_UPDATE_BINARY),)
LOCAL_CFLAGS += -DUPDATE_BINARY=\"$(BOARD_HIJACK_UPDATE_BINARY)\"
endif

ifneq ($(BOARD_HIJACK_BOOT_UPDATE_ZIP),)
LOCAL_CFLAGS += -DBOOT_UPDATE_ZIP=\"$(BOARD_HIJACK_BOOT_UPDATE_ZIP)\"
endif

ifneq ($(BOARD_HIJACK_RECOVERY_UPDATE_ZIP),)
LOCAL_CFLAGS += -DRECOVERY_UPDATE_ZIP=\"$(BOARD_HIJACK_RECOVERY_UPDATE_ZIP)\"
endif

ifeq ($(BOARD_HIJACK_LOG_ENABLE),true)
LOCAL_CFLAGS += -DLOG_ENABLE
endif

ifneq ($(BOARD_HIJACK_LOG_DEVICE),)
LOCAL_CFLAGS += -DLOG_DEVICE=\"$(BOARD_HIJACK_LOG_DEVICE)\"
endif

ifneq ($(BOARD_HIJACK_LOG_MOUNT),)
LOCAL_CFLAGS += -DLOG_MOUNT=\"$(BOARD_HIJACK_LOG_MOUNT)\"
endif

ifneq ($(BOARD_HIJACK_LOG_FILE),)
LOCAL_CFLAGS += -DLOG_FILE=\"$(BOARD_HIJACK_LOG_FILE)\"
endif

ifneq ($(BOARD_HIJACK_LOG_DUMP_BINARY),)
LOCAL_CFLAGS += -DLOG_DUMP_BINARY=\"$(BOARD_HIJACK_LOG_DUMP_BINARY)\"
endif

ifneq ($(BOARD_HIJACK_RECOVERY_MODE_FILE),)
LOCAL_CFLAGS += -DRECOVERY_MODE_FILE=\"$(BOARD_HIJACK_RECOVERY_MODE_FILE)\"
endif

LOCAL_CFLAGS += \
    -DBOOTMENU_VERSION="${BOOTMENU_VERSION}${BOOTMENU_SUFFIX}" -DSTOCK_VERSION=0 \
    ${EXTRA_CFLAGS}

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := hijack.log_dump
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_OUT_EXECUTABLES)
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(call all-makefiles-under,$(LOCAL_PATH))

