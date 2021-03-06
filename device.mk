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

# This file includes all definitions that apply to ALL tuna devices, and
# are also specific to tuna devices
#
# Everything in this directory will become public

$(call inherit-product-if-exists, hardware/ti/omap4/omap4.mk)

DEVICE_PACKAGE_OVERLAYS += device/samsung/tuna/overlay

# This device is xhdpi.  However the platform doesn't
# currently contain all of the bitmaps at xhdpi density so
# we do this little trick to fall back to the hdpi version
# if the xhdpi doesn't exist.
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

PRODUCT_PACKAGES += \
	camera.omap4 \
	lights.tuna \
	nfc.tuna \
	libpn544_fw \
	power.tuna \
	charger_res_images

# RIL
PRODUCT_PACKAGES += \
	libsecril-client

# Sensors
PRODUCT_PACKAGES += \
	sensors.tuna \
	libinvensense_mpl

# Audio
PRODUCT_PACKAGES += \
	audio.primary.tuna \
	audio.a2dp.default \
	audio.usb.default \
	audio.r_submix.default

ifeq ($(TARGET_TUNA_AUDIO_HDMI),true)
PRODUCT_COPY_FILES += \
	device/samsung/tuna/audio/policy/audio_policy.hdmi.conf:system/etc/audio_policy.conf
else
PRODUCT_COPY_FILES += \
	device/samsung/tuna/audio/policy/audio_policy.default.conf:system/etc/audio_policy.conf
endif

# Audio policy configuration
PRODUCT_COPY_FILES += \
	device/samsung/tuna/audio/audio_policy.conf:system/etc/audio_policy.conf \
	device/samsung/tuna/audio_effects.conf:system/vendor/etc/audio_effects.conf

PRODUCT_PACKAGES += \
	tuna_hdcp_keys

#PRODUCT_PACKAGES += \
#	keystore.tuna

PRODUCT_COPY_FILES += \
	device/samsung/tuna/init.tuna.rc:root/init.tuna.rc \
	device/samsung/tuna/init.tuna.usb.rc:root/init.tuna.usb.rc \
	device/samsung/tuna/fstab.tuna:root/fstab.tuna \
	device/samsung/tuna/ueventd.tuna.rc:root/ueventd.tuna.rc \
	device/samsung/tuna/media_profiles.xml:system/etc/media_profiles.xml \
	device/samsung/tuna/media_codecs.xml:system/etc/media_codecs.xml \
	device/samsung/tuna/gps.conf:system/etc/gps.conf

# Google media codecs
PRODUCT_COPY_FILES += \
	frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
	frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
	frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml

# Wifi
ifneq ($(TARGET_PREBUILT_WIFI_MODULE),)
PRODUCT_COPY_FILES += \
	$(TARGET_PREBUILT_WIFI_MODULE):system/lib/modules/bcmdhd.ko
endif
PRODUCT_COPY_FILES += \
	device/samsung/tuna/bcmdhd.cal:system/etc/wifi/bcmdhd.cal

PRODUCT_PROPERTY_OVERRIDES := \
	wifi.interface=wlan0

# libhwui flags
PRODUCT_PROPERTY_OVERRIDES += \
    debug.hwui.render_dirty_regions=false

# Enable AAC 5.1 output
PRODUCT_PROPERTY_OVERRIDES += \
	media.aac_51_output_enabled=true

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp

# NFC
PRODUCT_PACKAGES += \
        Nfc \
        Tag

# Live Wallpapers
PRODUCT_PACKAGES += \
        LiveWallpapers \
        LiveWallpapersPicker \
        VisualizationWallpapers \
        librs_jni

# Key maps
PRODUCT_COPY_FILES += \
	device/samsung/tuna/tuna-gpio-keypad.kl:system/usr/keylayout/tuna-gpio-keypad.kl \
	device/samsung/tuna/tuna-gpio-keypad.kcm:system/usr/keychars/tuna-gpio-keypad.kcm \
	device/samsung/tuna/sec_jack.kl:system/usr/keylayout/sec_jack.kl \
	device/samsung/tuna/sec_jack.kcm:system/usr/keychars/sec_jack.kcm \
	device/samsung/tuna/sii9234_rcp.kl:system/usr/keylayout/sii9234_rcp.kl \
	device/samsung/tuna/sii9234_rcp.kcm:system/usr/keychars/sii9234_rcp.kcm

# Input device calibration files
PRODUCT_COPY_FILES += \
	device/samsung/tuna/Melfas_MMSxxx_Touchscreen.idc:system/usr/idc/Melfas_MMSxxx_Touchscreen.idc

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
	frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.software.print.xml:system/etc/permissions/android.software.print.xml \
	frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml

# Portrait dock image
PRODUCT_COPY_FILES += \
	device/samsung/tuna/dock.png:system/vendor/res/images/dock/dock.png

# Commands to migrate prefs from com.android.nfc3 to com.android.nfc
PRODUCT_COPY_FILES += $(call add-to-product-copy-files-if-exists,\
packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt)


# file that declares the MIFARE NFC constant
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml

# NFC EXTRAS add-on API
PRODUCT_PACKAGES += \
	com.android.nfc_extras
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml

# NFCEE access control
ifeq ($(TARGET_BUILD_VARIANT),user)
    NFCEE_ACCESS_PATH := device/samsung/tuna/nfcee_access.xml
else
    NFCEE_ACCESS_PATH := device/samsung/tuna/nfcee_access_debug.xml
endif
PRODUCT_COPY_FILES += \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml

# Low-RAM optimizations
ADDITIONAL_BUILD_PROPERTIES += \
	config.disable_atlas=true \
	dalvik.vm.dex2oat-flags=--no-watch-dog

# Google Apps...
PRODUCT_PROPERTY_OVERRIDES += \
	keyguard.no_require_sim=true \
	ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
	ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
	ro.com.google.clientidbase=android-google \
	ro.com.android.wifi-watchlist=GoogleGuest \
	ro.setupwizard.enterprise_mode=1 \
	ro.com.android.dateformat=MM-dd-yyyy

# OpenGL ES version and LCD density
PRODUCT_PROPERTY_OVERRIDES += \
	ro.opengles.version=131072 \
	ro.sf.lcd_density=320

PRODUCT_PROPERTY_OVERRIDES += \
	ro.hwui.disable_scissor_opt=true \
	ro.bq.gpu_to_cpu_unsupported=1 \
	camera2.portability.force_api=1

PRODUCT_CHARACTERISTICS := nosdcard

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_PACKAGES += \
	librs_jni \
	com.android.future.usb.accessory

# Filesystem management tools
PRODUCT_PACKAGES += \
	e2fsck \
	setup_fs

# F2FS filesystem
PRODUCT_PACKAGES += \
        mkfs.f2fs \
        fsck.f2fs \
        fibmap.f2fs \
        f2fstat

# Don't preload EGL drivers in Zygote at boot time
PRODUCT_PROPERTY_OVERRIDES += \
	ro.zygote.disable_gl_preload=true

# WiFi stuff
PRODUCT_PACKAGES += \
	libwpa_client \
	hostapd \
	dhcpcd.conf \
	wpa_supplicant \
	wpa_supplicant.conf

$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

$(call inherit-product-if-exists, vendor/nxp/pn544/nxp-pn544-fw-vendor.mk)
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/device-bcm.mk)
$(call inherit-product-if-exists, vendor/samsung/tuna/device-vendor.mk)
