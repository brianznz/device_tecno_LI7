#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# A/B (stock uses Virtual A/B with vendor_boot ramdisk and VABC,
# ro.virtual_ab.enabled=true, ro.virtual_ab.compression.enabled=true)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/vabc_features.mk)

AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
    boot \
    dtbo \
    odm_dlkm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vendor \
    vendor_boot \
    vendor_dlkm

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=$(BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE) \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=$(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE) \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier \
    otapreopt_script \
    checkpoint_gc

PRODUCT_VIRTUAL_AB_COMPRESSION_METHOD := lz4

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service

# API levels
PRODUCT_SHIPPING_API_LEVEL := 34

# Audio (HIDL 7.0 + effect 7.0 + soundtrigger 2.3 per stock manifest)
$(call soong_config_set,android_hardware_audio,run_64bit,true)
$(call soong_config_set_bool,android_hardware_audio,skip_speaker_layout_channel_mask_field,true)
PRODUCT_PACKAGES += \
    android.hardware.audio@7.0-impl:64 \
    android.hardware.audio.effect@7.0-impl:64 \
    android.hardware.audio.service \
    android.hardware.bluetooth.audio-impl:64 \
    android.hardware.soundtrigger@2.3-impl:64

PRODUCT_PACKAGES += \
    audio.primary.default:64 \
    audio.bluetooth.default:64 \
    audio.r_submix.default:64 \
    audio.usb.default:64

PRODUCT_PACKAGES += \
    audio_policy.stub:64 \
    libopus.vendor:64 \
    audioclient-types-aidl-cpp.vendor:64 \
    libaudioroute.vendor:64 \
    libaudiofoundation.vendor:64 \
    libbundlewrapper:64 \
    libbluetooth_audio_session:64 \
    libaudiopreprocessing:64 \
    libalsautils:64 \
    libdownmix:64 \
    libeffectproxy:64 \
    libnbaio_mono:64 \
    libtinycompress:64 \
    libdynproc:64 \
    libhapticgenerator:64 \
    libldnhncr:64 \
    libreverbwrapper:64 \
    libprocessgroup.vendor:64

PRODUCT_PACKAGES += \
    MtkInCallService

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/,$(TARGET_COPY_OUT_VENDOR)/etc)

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml

PRODUCT_PACKAGES += \
   vendor.mediatek.hardware.bluetooth.audio@2.1.vendor:64 \
   vendor.mediatek.hardware.bluetooth.audio@2.2.vendor:64

# Bluetooth (HIDL 1.1 per stock manifest)
PRODUCT_PACKAGES += \
    android.hardware.bluetooth-service.mediatek

# Camera (provider 2.6 impl-mediatek in vendor blobs)
PRODUCT_PACKAGES += \
    android.hardware.camera.common@1.0.vendor:64 \
    android.hardware.camera.device@3.6.vendor:64 \
    android.hardware.camera.provider@2.6.vendor:64

PRODUCT_PACKAGES += \
    libcamera_metadata_shim \
    libdng_sdk.vendor \
    libexif.vendor \
    libpiex \
    libpng.vendor

# Fingerprint (2.1-service-mediatek + silead HAL in blobs)
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.1.vendor:64

# GNSS (1.1/2.1 + measurement + visibility libs in blobs)
PRODUCT_PACKAGES += \
    android.hardware.gnss.measurement_corrections@1.1.vendor:64 \
    android.hardware.gnss.visibility_control@1.0.vendor:64 \
    android.hardware.gnss@1.1.vendor:64 \
    android.hardware.gnss@2.1.vendor:64 \
    android.hardware.gnss-V1-ndk.vendor:64

PRODUCT_PACKAGES += \
    libcurl.vendor:64

# Display (composer + allocator 4.0 + mapper 4.0 in blobs)
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.3-service \
    android.hardware.memtrack-service.mediatek

PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@4.0.vendor:64 \
    android.frameworks.sensorservice@1.0.vendor:64 \
    android.hardware.graphics.mapper@4.0.vendor:64 \
    libhwc2on1adapter:64 \
    libhwc2onfbadapter:64 \
    libdrm.vendor:64

PRODUCT_PACKAGES += \
    ANGLE

# DRM (clearkey + widevine services in blobs)
PRODUCT_PACKAGES += \
    com.android.hardware.drm.clearkey

PRODUCT_PACKAGES += \
    android.hardware.drm@1.4.vendor

# Media (OMX 1.0 + C2 1.2 mediatek in blobs)
$(call soong_config_set_bool,android_hardware_mediatek_codec2,link_v33_libstagefright_foundation,true)
PRODUCT_PACKAGES += \
    android.hardware.cas@1.2-service-lazy \
    android.hardware.media.c2-mtk-service \
    libcodec2_vndk.vendor:64 \
    libeffects:64 \
    libeffectsconfig.vendor:64 \
    libavservices_minijail_vendor:64 \
    libstagefright_softomx_plugin.vendor:64 \
    libsfplugin_ccodec_utils.vendor:64 \
    libcodec2_soft_common.vendor:64 \
    libflatbuffers-cpp.vendor:64

PRODUCT_PACKAGES += \
    libchrome.vendor:64 \
    libminijail:64 \
    libminijail.vendor:64

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/media,$(TARGET_COPY_OUT_VENDOR)/etc)

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# Lights (lights-service-mediatek in blobs, use lineage service)
PRODUCT_PACKAGES += \
    android.hardware.light-service.lineage

# Neural networks (shim service in blobs)
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@1.0.vendor:64 \
    android.hardware.neuralnetworks@1.3.vendor:64 \
    libtextclassifier_hash.vendor:64

# Secure Element (1.2 service-mediatek in blobs)
PRODUCT_PACKAGES += \
    android.hardware.secure_element@1.2.vendor:64

# Sensors (2.0 multihal-mediatek service in blobs)
PRODUCT_PACKAGES += \
    libsensorndkbridge:64 \
    android.hardware.sensors@1.0.vendor:64 \
    android.hardware.sensors@2.1.vendor:64 \
    android.frameworks.sensorservice@1.0:64 \
    android.frameworks.sensorservice@1.0.vendor:64 \
    android.hardware.sensors-service.multihal \
    android.hardware.sensors@2.0-subhal-impl-1.0 \
    android.hardware.sensors@2.0-ScopedWakelock.vendor:64

PRODUCT_PACKAGES += \
    sensors.dynamic_sensor_hal:64

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

# Thermal (2.0 mtk service in blobs)
PRODUCT_PACKAGES += \
    android.hardware.thermal-service.mediatek

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal/thermal_info_config.json:$(TARGET_COPY_OUT_VENDOR)/etc/thermal_info_config.json

# Vibrator (mediatek service in blobs)
PRODUCT_PACKAGES += \
    android.hardware.vibrator-service.mediatek

# Kernel
PRODUCT_ENABLE_UFFD_GC := true

# Overlays
$(call inherit-product, hardware/mediatek/overlay/mssi.mk)
PRODUCT_ENFORCE_RRO_TARGETS := *
PRODUCT_PACKAGES += \
    FrameworksResTarget \
    SettingsResTarget \
    SettingsProviderResTarget \
    SystemUIResTarget \
    OpenDeltaOverlayMT6789

PRODUCT_PACKAGES += \
    ApertureOverlay

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Power (mtkpower 1.2 impl in blobs)
PRODUCT_PACKAGES += \
    android.hardware.power-service.pixel-libperfmgr

PRODUCT_PACKAGES += \
    vendor.mediatek.hardware.mtkpower@1.2-service.stub:64 \
    vendor.mediatek.hardware.mtkpower@1.0.vendor:64 \
    vendor.mediatek.hardware.mtkpower@1.1.vendor:64

PRODUCT_PACKAGES += \
    android.hardware.power@1.3.vendor:64

PRODUCT_PACKAGES += \
    libmtkperf_client_vendor:64 \
    libmtkperf_client:64 \
    libpower.vendor:64

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/power/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/keylayout/mtk-tpd.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/mtk-tpd.kl

# USB (1.2 service v2 in blobs)
$(call soong_config_set_bool,android_hardware_mediatek_usb,audio_accessory_supported,true)
PRODUCT_PACKAGES += \
    android.hardware.usb-service.mediatek \
    android.hardware.usb.gadget-service.mediatek \
    init.mt6789.usb.rc

# Wi-Fi (1.0 lazy service + hostapd in blobs)
$(call soong_config_set_bool,mediatek_wifi_hal,use_pre_u_qpr2_struct,true)
PRODUCT_PACKAGES += \
    libwifi-hal-wrapper:64 \
    wpa_supplicant \
    hostapd \
    android.hardware.wifi-service \
    libkeystore-wifi-hidl:64 \
    libkeystore-engine-wifi-hidl:64

PRODUCT_PACKAGES += \
    android.hardware.tetheroffload.config@1.0.vendor:64 \
    android.hardware.tetheroffload.control@1.0.vendor:64 \
    android.hardware.tetheroffload.control@1.1.vendor:64

# Product characteristics
PRODUCT_CHARACTERISTICS := default

# Rootdir
PRODUCT_PACKAGES += \
    fstab.mt6789 \
    fstab.mt6789.vendor_ramdisk \
    init_connectivity.rc \
    init.connectivity.common.rc \
    init.connectivity.rc \
    init.insmod.sh \
    init.insmod.mt6789.cfg \
    init.modem.rc \
    init.mt6789.power.rc \
    init.mt6789.rc \
    init.mtkgki.rc \
    init.project.rc \
    init.recovery.usb.rc \
    init.sensor_2_0.rc \
    ueventd.mt6789.rc

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/infinix/X6880/X6880-vendor.mk)
