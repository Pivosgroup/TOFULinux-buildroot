#############################################################
#
# broadcom wifi support
#
#############################################################
BROADCOM_VERSION = aml
BROADCOM_SOURCE = broadcom-$(BROADCOM_VERSION)-firmware.tar.gz
BROADCOM_SITE = $(TOPDIR)/package/amlogic/broadcom/src
BROADCOM_SITE_METHOD = local
BROADCOM_INSTALL_STAGING = NO
BROADCOM_INSTALL_TARGET = YES

define BROADCOM_INSTALL_TARGET_CMDS
 mkdir -p $(TARGET_DIR)/etc/init.d
 mkdir -p $(TARGET_DIR)/etc/wifi/40183
 install -m 755 $(@D)/S60wifi $(TARGET_DIR)/etc/init.d
 install -m 644 $(@D)/firmware/40183/* $(TARGET_DIR)/etc/wifi/40183
endef

$(eval $(call generic-package))
