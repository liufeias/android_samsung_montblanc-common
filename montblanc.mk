# Copyright (C) 2010 The Android Open Source Project
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


# This file is the device-specific product definition file for
# crespo. It lists all the overlays, files, modules and properties
# that are specific to this hardware: i.e. those are device-specific
# drivers, configuration files, settings, etc...

# Note that crespo is not a fully open device. Some of the drivers
# aren't publicly available in all circumstances, which means that some
# of the hardware capabilities aren't present in builds where those
# drivers aren't available. Such cases are handled by having this file
# separated into two halves: this half here contains the parts that
# are available to everyone, while another half in the vendor/ hierarchy
# augments that set with the parts that are only relevant when all the
# associated drivers are available. Aspects that are irrelevant but
# harmless in no-driver builds should be kept here for simplicity and
# transparency. There are two variants of the half that deals with
# the unavailable drivers: one is directly checked into the unreleased
# vendor tree and is used by engineers who have access to it. The other
# is generated by setup-makefile.sh in the same directory as this files,
# and is used by people who have access to binary versions of the drivers
# but not to the original vendor tree. Be sure to update both.

# These is the hardware-specific overlay, which points to the location
# of hardware-specific resource overrides, typically the frameworks and
# application settings that are stored in resourced.
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

$(call inherit-product-if-exists, device/samsung/montblanc-common/recovery/recovery.mk)

$(call inherit-product-if-exists, vendor/samsung/montblanc-common/montblanc-vendor-blobs.mk)

DEVICE_PACKAGE_OVERLAYS += device/samsung/montblanc-common/overlay

# These are the hardware-specific configuration files
PRODUCT_COPY_FILES += \
        device/samsung/montblanc-common/config/omxloaders:system/etc/omxloaders \
        device/samsung/montblanc-common/config/ste_modem.sh:system/etc/ste_modem.sh \
	device/samsung/montblanc-common/config/asound.conf:system/etc/asound.conf \
	device/samsung/montblanc-common/config/gps.conf:system/etc/gps.conf \
	device/samsung/montblanc-common/config/sirfgps.conf:system/etc/sirfgps.conf \
	device/samsung/montblanc-common/config/vold.fstab:system/etc/vold.fstab \
	device/samsung/montblanc-common/config/egl.cfg:system/lib/egl/egl.cfg

# Permissions
#PRODUCT_COPY_FILES += \
#    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
#    frameworks/base/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
#    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
#    frameworks/base/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
#    frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
#    frameworks/base/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
#    frameworks/base/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
#    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
#    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
#    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
#    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
#    frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
#    frameworks/base/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
#    frameworks/base/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
#    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
#    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
#    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
#    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    setup_fs

# Hostapd
PRODUCT_PACKAGES += \
    hostapd_cli \
    hostapd

# BT A2DP
PRODUCT_PACKAGES += \
    libasound_module_ctl_bluetooth \
    libasound_module_pcm_bluetooth

# light package
PRODUCT_PACKAGES += \
   lights.montblanc

# Misc
PRODUCT_PACKAGES += \
   com.android.future.usb.accessory

# We have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Init files
PRODUCT_COPY_FILES += \
	device/samsung/montblanc-common/init.samsungjanice.rc:root/init.samsungjanice.rc \
	device/samsung/montblanc-common/prerecovery.rc:root/prerecovery.rc \
	device/samsung/montblanc-common/ueventd.samsungjanice.rc:root/ueventd.samsungjanice.rc \

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp \
    wifi.interface=wlan0
