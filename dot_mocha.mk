# Inherit device configuration for mocha.
$(call inherit-product, device/xiaomi/mocha/full_mocha.mk)

# Inherit some common dotOS stuff.
$(call inherit-product, vendor/dot/config/common.mk)

PRODUCT_NAME := dot_mocha
PRODUCT_BRAND := Xiaomi
PRODUCT_DEVICE := mocha
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_DEVICE := mocha
BOARD_VENDOR := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-nvidia

