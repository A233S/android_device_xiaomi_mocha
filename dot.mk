# Inherit device configuration for mocha.
$(call inherit-product, device/xiaomi/mocha/full_mocha.mk)

# Inherit some common dotOS stuff.
$(call inherit-product, vendor/dot/config/common_mini_tablet_wifionly.mk)

PRODUCT_NAME := dot_mocha
PRODUCT_DEVICE := mocha
BOARD_VENDOR := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
