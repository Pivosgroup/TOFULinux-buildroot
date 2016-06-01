###############################################################################
#
## TOFULinux Maintenance Tool Addon
#
###############################################################################
MT_VERSION = 6662aeb06d84f45b243dd2db5552fcba8db29cc2
MT_SOURCE = mt-$(MT_VERSION).tar.gz
MT_SITE = https://github.com/aasoror/TOFULinux-Maintenance-Tool.git
MT_SITE_METHOD = git
MT_INSTALL_STAGING = NO
MT_INSTALL_TARGET = YES

TARGETS += mt

define MT_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/kodi/addons/script.module.tofulinux.tool
	cp -rf $(@D)/* $(TARGET_DIR)/usr/share/kodi/addons/script.module.tofulinux.tool/
endef

$(eval $(generic-package))
