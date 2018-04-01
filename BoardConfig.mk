#
# Copyright (C) 2014 The CyanogenMod Project
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

# This variable is set first, so it can be overridden
# by BoardConfigVendor.mk

TARGET_SPECIFIC_HEADER_PATH := device/xiaomi/mocha/include
TARGET_KERNEL_HAVE_EXFAT := true
TARGET_KERNEL_HAVE_NTFS := true
WITH_DEXPREOPT := true

# Binder API version
TARGET_USES_64_BIT_BINDER := true
>>>>>>> a2df177... WITH_DEXPREOPT := true

# Architecture
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a15

# Binder API
TARGET_USES_64_BIT_BINDER := true

# Board
TARGET_BOARD_PLATFORM := tegra
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true
# Use unified vendor
TARGET_TEGRA_VARIANT := shield

# FS
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_EXFAT_DRIVER := sdfat

# Kernel
BOARD_KERNEL_CMDLINE := vpr_resize androidboot.selinux=permissive androidboot.hardware=tn8
BOARD_KERNEL_BASE := 0x10000000
BOARD_RAMDISK_OFFSET := 0x02000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_TAGS_OFFSET := 0x00000100

TARGET_KERNEL_SOURCE := kernel/xiaomi/mocha
TARGET_KERNEL_CONFIG := tegra12_android_defconfig
BOARD_KERNEL_IMAGE_NAME := zImage
BOARD_KERNEL_SEPARATED_DT := true
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_CUSTOM_BOOTIMG_MK := device/xiaomi/mocha/mkbootimg.mk

#BOARD_SYSTEMIMAGE_PARTITION_SIZE := 671088640 # 640 Mb stock partition table
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1337564160 # 1.2 Gb
BOARD_USERDATAIMAGE_PARTITION_SIZE := 13742637056
BOARD_CACHEIMAGE_PARTITION_SIZE := 402653184
BOARD_BOOTIMAGE_PARTITION_SIZE := 20971520
BOARD_PERSISTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 20971520
BOARD_FLASH_BLOCK_SIZE := 131072

# PowerHAL
TARGET_POWERHAL_VARIANT := tegra

# ThermalHAL
TARGET_THERMALHAL_VARIANT := tegra

# Audio
BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_ALSA_AUDIO := true
BOARD_USES_TINYHAL_AUDIO := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR ?= device/xiaomi/mocha/bluetooth

# Graphics
USE_OPENGL_RENDERER := true
BOARD_DISABLE_TRIPLE_BUFFERED_DISPLAY_SURFACES := true

# CMHW
BOARD_USES_CYANOGEN_HARDWARE := true
BOARD_HARDWARE_CLASS := \
    hardware/cyanogen/cmhw \
    device/xiaomi/mocha/cmhw

# Offmode Charging
BOARD_CHARGER_DISABLE_INIT_BLANK := true
BACKLIGHT_PATH := "/sys/class/backlight/lcd-backlight/brightness"
RED_LED_PATH := "/sys/class/leds/red/brightness"
GREEN_LED_PATH := "/sys/class/leds/green/brightness"
BLUE_LED_PATH := "/sys/class/leds/blue/brightness"

# Include an expanded selection of fonts
EXTENDED_FONT_FOOTPRINT := true

# Per-application sizes for shader cache
MAX_EGL_CACHE_SIZE := 4194304
MAX_EGL_CACHE_ENTRY_SIZE := 262144

# Recovery
TARGET_RECOVERY_DEVICE_DIRS += device/xiaomi/mocha
TARGET_RECOVERY_FSTAB := device/xiaomi/mocha/initfiles/fstab.tn8
BOARD_NO_SECURE_DISCARD := true

# RenderScript
OVERRIDE_RS_DRIVER := libnvRSDriver.so

# Wifi related defines
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE                := bcmdhd
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_bcmdhd
WIFI_DRIVER_FW_PATH_STA          := "/vendor/firmware/mocha_fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_AP           := "/vendor/firmware/mocha_fw_bcmdhd_apsta.bin"
WIFI_DRIVER_FW_PATH_PARAM        := "/sys/module/bcmdhd/parameters/firmware_path"
#WIFI_DRIVER_MODULE_ARG           := "iface_name=wlan0"
#WIFI_DRIVER_MODULE_NAME          := "bcmdhd"


# SELinux
BOARD_SEPOLICY_DIRS += device/xiaomi/mocha/sepolicy/common \
                       device/xiaomi/mocha/sepolicy/lineage-common \
                       device/xiaomi/mocha/sepolicy/mocha

# seccomp
BOARD_SECCOMP_POLICY := device/xiaomi/mocha/seccomp

