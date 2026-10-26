#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from LI7 device
$(call inherit-product, device/tecno/LI7/device.mk)

# Inherit some common Lineage stuff 
$(call inherit-product, vendor/infinity/config/common_full_phone.mk)
TARGET_DISABLE_EPPE := true

BOARD_VENDOR := TECNO
PRODUCT_DEVICE := LI7
PRODUCT_NAME := lunaris_LI7
PRODUCT_BRAND := TECNO
PRODUCT_MANUFACTURER := TECNO
PRODUCT_MODEL := TECNO LI7

PRODUCT_GMS_CLIENTID_BASE := android-transsion
PRODUCT_SYSTEM_NAME := LI7-OP
PRODUCT_SYSTEM_DEVICE := LI7

BUILD_FINGERPRINT := TECNO/LI7-OP/TECNO-LI7:15/AP3A.240905.015.A2/128004:user/release-keys

