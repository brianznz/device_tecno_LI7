#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from X6880 device
$(call inherit-product, device/infinix/X6880/device.mk)

# Inherit some common Lineage stuff (Axion lineage-23.2).
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)
TARGET_DISABLE_EPPE := true

BOARD_VENDOR := Infinix
PRODUCT_DEVICE := X6880
PRODUCT_NAME := lineage_X6880
PRODUCT_BRAND := Infinix
PRODUCT_MANUFACTURER := INFINIX
PRODUCT_MODEL := Infinix X6880

PRODUCT_GMS_CLIENTID_BASE := android-transsion
PRODUCT_SYSTEM_NAME := X6880-OP
PRODUCT_SYSTEM_DEVICE := X6880

BUILD_FINGERPRINT := Infinix/X6880-OP/Infinix-X6880:15/AP3A.240905.015.A2/145011:user/release-keys

# Axion device properties
AXION_CAMERA_REAR_INFO := 50
AXION_CAMERA_FRONT_INFO := 13
AXION_MAINTAINER := ーケrayannn
AXION_PROCESSOR := Helio_G100
