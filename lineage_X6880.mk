#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from X6880 device
$(call inherit-product, device/infinix/X6880/device.mk)

# Inherit some common Lineage stuff (A15 / lineage-22.2).
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

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
