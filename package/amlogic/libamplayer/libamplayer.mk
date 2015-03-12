###############################################################################
#
# libamplayer
#
###############################################################################

LIBAMPLAYER_VERSION = $(subst ",,$(BR2_PACKAGE_LIBAMPLAYER_SOURCE_VERSION))
LIBAMPLAYER_SOURCE = libamplayer-$(LIBAMPLAYER_VERSION).tar.gz
LIBAMPLAYER_SITE = $(subst ",,$(BR2_PACKAGE_LIBAMPLAYER_SOURCE_URL))
LIBAMPLAYER_SITE_METHOD = git
LIBAMPLAYER_INSTALL_STAGING = YES
LIBAMPLAYER_INSTALL_TARGET = YES

LIBAMPLAYER_DEPENDENCIES += alsa-lib librtmp
AMFFMPEG_DIR = $(BUILD_DIR)/libamplayer-$(LIBAMPLAYER_VERSION)/amffmpeg
AMAVUTILS_DIR = $(BUILD_DIR)/libamplayer-$(LIBAMPLAYER_VERSION)/amavutils
AMFFMPEG_EXTRA_LDFLAGS += --extra-ldflags="-lamavutils"

define LIBAMPLAYER_COMMON_SOURCE_BUILD_CLEANUP
 rm -rf $(STAGING_DIR)/lib/libam*.*
 rm -rf $(STAGING_DIR)/usr/lib/libam*.*
 rm -rf $(TARGET_DIR)/lib/libam*.*
 rm -rf $(TARGET_DIR)/usr/lib/libam*.*
endef

define LIBAMPLAYER_COMMON_BUILD_CMDS
 $(call AMFFMPEG_CONFIGURE_CMDS)
 $(call AMFFMPEG_BUILD_CMDS)
 $(call AMFFMPEG_INSTALL_STAGING_CMDS)
endef

define LIBAMPLAYER_COMMON_SOURCE_BUILD_CMDS
 $(call LIBAMPLAYER_COMMON_BUILD_CMDS)
 if [ -d $(STAGING_DIR)/usr/include/amlplayer ]; then rm -rf $(STAGING_DIR)/usr/include/amlplayer/.*; \
 rm -rf $(STAGING_DIR)/usr/include/amlplayer/*; rmdir $(STAGING_DIR)/usr/include/amlplayer; fi;
 mkdir -p $(STAGING_DIR)/usr/include/amlplayer
 $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" HEADERS_DIR="$(STAGING_DIR)/usr/include/amlplayer" \
  CROSS_PREFIX="$(TARGET_CROSS)" SYSROOT="$(STAGING_DIR)" PREFIX="$(STAGING_DIR)/usr" -C $(@D)/amadec install
 $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" HEADERS_DIR="$(STAGING_DIR)/usr/include/amlplayer" CROSS_PREFIX="$(TARGET_CROSS)" \
  SYSROOT="$(STAGING_DIR)" PREFIX="$(STAGING_DIR)/usr" SRC=$(@D)/amcodec -C $(@D)/amcodec install
 $(MAKE) CROSS="$(TARGET_CROSS)" CC="$(TARGET_CC)" LD="$(TARGET_LD)" PREFIX="$(STAGING_DIR)/usr" \
  SRC="$(@D)/amplayer" -C $(@D)/amplayer
endef

define LIBAMPLAYER_BUILD_CMDS
 $(call LIBAMPLAYER_COMMON_SOURCE_BUILD_CLEANUP)
 $(call AMAVUTILS_BUILD_CMDS)
 $(call AMAVUTILS_INSTALL_STAGING_CMDS)
 $(call LIBAMPLAYER_COMMON_SOURCE_BUILD_CMDS)
endef

define LIBAMPLAYER_INSTALL_SOURCE_STAGING_CMDS
 $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" INSTALL_DIR="$(STAGING_DIR)/usr/lib" \
  STAGING="$(STAGING_DIR)/usr" PREFIX="$(STAGING_DIR)/usr" -C $(@D)/amplayer install
 cp -rf $(@D)/amcodec/include/* $(STAGING_DIR)/usr/include
 cd $(STAGING_DIR)/usr/include; ln -sf amlplayer amcodec
endef

define LIBAMPLAYER_INSTALL_STAGING_CMDS
 $(call LIBAMPLAYER_INSTALL_SOURCE_STAGING_CMDS)
endef

ifeq ($(BR2_BOARD_TYPE_AMLOGIC_M6),y)
FIRMWARE = firmware-m6
else
FIRMWARE = firmware
endif

define LIBAMPLAYER_INSTALL_SOURCE_COMMON_CMDS
 $(call AMFFMPEG_INSTALL_TARGET_CMDS)
 mkdir -p $(TARGET_DIR)/lib/firmware
 install -m 644 $(@D)/amadec/$(FIRMWARE)/*.bin $(TARGET_DIR)/lib/firmware
 mkdir -p $(TARGET_DIR)/usr/lib
 install -m 755 $(STAGING_DIR)/usr/lib/*.so* $(TARGET_DIR)/usr/lib
 cd $(TARGET_DIR)/usr/lib/; ln -sf libamcodec.so.0.0 libamcodec.so
 $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" INSTALL_DIR="$(TARGET_DIR)/usr/lib" \
  STAGING="$(TARGET_DIR)/usr" PREFIX="$(STAGING_DIR)/usr" -C $(@D)/amplayer install
endef

define LIBAMPLAYER_INSTALL_TARGET_CMDS
 $(call AMAVUTILS_INSTALL_TARGET_CMDS)
 $(call LIBAMPLAYER_INSTALL_SOURCE_COMMON_CMDS)
endef

$(eval $(call generic-package))
