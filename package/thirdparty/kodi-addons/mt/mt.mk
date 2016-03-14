###############################################################################
#
## TOFULinux Maintenance Tool Addon
#
###############################################################################
MT_VERSION = baaa5a3774a1cb27f60b245c82df119b14866c21
MT_SOURCE = mt-$(MT_VERSION).tar.gz
MT_SITE = https://github.com/snappy46/TOFULinux-Maintenance-Tool.git
MT_SITE_METHOD = git
MT_INSTALL_STAGING = NO
MT_INSTALL_TARGET = YES

TARGETS += mt

define MT_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/kodi/addons/script.module.tofulinux.tool
	cp -rf $(@D)/* $(TARGET_DIR)/usr/share/kodi/addons/script.module.tofulinux.tool/
endef

$(eval $(generic-package))
