# Inherit device configuration for mocha.
$(call inherit-product, device/xiaomi/mocha/full_mocha.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_mini_tablet_wifionly.mk)

PRODUCT_NAME := lineage_mocha
PRODUCT_DEVICE := mocha
BOARD_VENDOR := Xiaomi
LINEAGE_VERSION_APPEND_TIME_OF_DAY := TRUE

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
