# Inherit device configuration for mocha.
$(call inherit-product, device/xiaomi/mocha/full_mocha.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/mk/config/common_mini_tablet_wifionly.mk)

PRODUCT_NAME := mk_mocha
PRODUCT_DEVICE := mocha
BOARD_VENDOR := Xiaomi
LINEAGE_VERSION_APPEND_TIME_OF_DAY := true

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

