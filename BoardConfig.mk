#
# Copyright (C) 2011 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# inherit from omap4 
-include hardware/ti/omap4/BoardConfigCommon.mk

PRODUCT_VENDOR_KERNEL_HEADERS += device/samsung/tuna/kernel-headers

# Use the non-open-source parts, if they're present
-include vendor/samsung/tuna/BoardConfigVendor.mk

TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a9

# Processor
TARGET_BOARD_OMAP_CPU := 4460

BOARD_KERNEL_BASE := 0x80000000
# BOARD_KERNEL_CMDLINE :=

# Define kernel config for inline building
TARGET_KERNEL_SOURCE := kernel/samsung/tuna
KERNEL_TOOLCHAIN := $(ARM_EABI_TOOLCHAIN)/../../arm-eabi-4.7/bin
TARGET_KERNEL_CONFIG := dreams_tuna_defconfig

TARGET_PREBUILT_KERNEL := device/samsung/tuna/kernel

# External SGX Module
SGX_MODULES:
	make clean -C $(HARDWARE_TI_OMAP4_BASE)/pvr-source/eurasiacon/build/linux2/omap4430_android
	cp $(TARGET_KERNEL_SOURCE)/drivers/video/omap2/omapfb/omapfb.h $(KERNEL_OUT)/drivers/video/omap2/omapfb/omapfb.h
	make -j8 -C $(HARDWARE_TI_OMAP4_BASE)/pvr-source/eurasiacon/build/linux2/omap4430_android ARCH=arm KERNEL_CROSS_COMPILE=arm-eabi- CROSS_COMPILE=arm-eabi- KERNELDIR=$(KERNEL_OUT) TARGET_PRODUCT="blaze_tablet" BUILD=release TARGET_SGX=540 PLATFORM_VERSION=4.0
	mv $(KERNEL_OUT)/../../target/kbuild/pvrsrvkm_sgx540_120.ko $(KERNEL_MODULES_OUT)
	$(ARM_EABI_TOOLCHAIN)/arm-eabi-strip --strip-unneeded $(KERNEL_MODULES_OUT)/pvrsrvkm_sgx540_120.ko

TARGET_KERNEL_MODULES += SGX_MODULES

TARGET_NO_RADIOIMAGE := true
TARGET_BOARD_PLATFORM := omap4
TARGET_BOARD_INFO_FILE := device/samsung/tuna/board-info.txt
TARGET_BOOTLOADER_BOARD_NAME := tuna

TI_CAMERAHAL_USES_LEGACY_DOMX_DCC := true
TI_CAMERAHAL_INTERFACE := OMX
DOMX_TUNA := true
COMMON_GLOBAL_CFLAGS += -DDOMX_TUNA
TI_CAMERAHAL_MAX_CAMERAS_SUPPORTED := 2
TI_CAMERAHAL_DEBUG_ENABLED := true

BOARD_EGL_WORKAROUND_BUG_10194508 := true
BOARD_CREATE_TUNA_HDCP_KEYS_SYMLINK := true

# Force the screenshot path to CPU consumer
COMMON_GLOBAL_CFLAGS += -DFORCE_SCREENSHOT_CPU_PATH

# We don't support cursor layers, which when attempting to use them,
# results in no cursors (mouse or otherwise) displayed on the screen.
TARGET_DISABLE_CURSOR_LAYER := true

# set if the target supports FBIO_WAITFORVSYNC
TARGET_HAS_WAITFORVSYNC := true
TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := true

# MD5_Init symbols. Needed only for Nexus's RIL?
TARGET_WITH_BIONIC_MD5 := true

# device-specific extensions to the updater binary
TARGET_RECOVERY_UPDATER_LIBS += librecovery_updater_tuna
TARGET_RELEASETOOLS_EXTENSIONS := device/samsung/tuna

TARGET_RECOVERY_FSTAB = device/samsung/tuna/fstab.tuna

MALLOC_IMPL := dlmalloc

TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Filesystem
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 8388608
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 12517376
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 685768704
BOARD_CACHEIMAGE_PARTITION_SIZE := 452984832
# Disable journaling on system.img to save space.
BOARD_SYSTEMIMAGE_JOURNAL_SIZE := 0
BOARD_USERDATAIMAGE_PARTITION_SIZE := 14539537408
BOARD_FLASH_BLOCK_SIZE := 4096

#TARGET_PROVIDES_INIT_RC := true
#TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

# Wifi related defines
BOARD_WLAN_DEVICE                := bcmdhd
BOARD_WLAN_DEVICE_REV            := bcm4330_b2
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_bcmdhd
WIFI_DRIVER_FW_PATH_PARAM        := "/sys/module/bcmdhd/parameters/firmware_path"
#WIFI_DRIVER_MODULE_PATH         := "/system/lib/modules/bcmdhd.ko"
WIFI_DRIVER_FW_PATH_STA          := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_AP           := "/vendor/firmware/fw_bcmdhd_apsta.bin"
WIFI_BAND                        := 802_11_ABG

BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/samsung/tuna/bluetooth

BOARD_HAL_STATIC_LIBRARIES := libdumpstate.tuna

TARGET_TUNA_AUDIO_HDMI := true

BOARD_USES_SECURE_SERVICES := true

BOARD_SEPOLICY_DIRS += \
        device/samsung/tuna/sepolicy

BOARD_SEPOLICY_UNION += \
	genfs_contexts \
	file_contexts \
	dumpdcc.te \
	init.te \
	mediaserver.te \
	pvrsrvinit.te \
	rild.te \
	bluetooth.te \
	sdcardd.te \
	servicemanager.te \
	system_server.te \
	zygote.te \
	vold.te
