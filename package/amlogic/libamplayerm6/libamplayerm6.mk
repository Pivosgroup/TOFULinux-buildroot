#############################################################
#
# libamplayer
#
#############################################################
LIBAMPLAYERM6_VERSION:=m6
LIBAMPLAYERM6_SOURCE=libamplayerm6-$(LIBAMPLAYERM6_VERSION).tar.gz
LIBAMPLAYERM6_SITE=$(TOPDIR)/package/amlogic/libamplayerm6/src
LIBAMPLAYERM6_SITE_METHOD=local
LIBAMPLAYERM6_INSTALL_STAGING=YES
LIBAMPLAYERM6_INSTALL_TARGET=YES

ifeq ($(BR2_PACKAGE_LIBAMPLAYERM6),y)
# actually required for amavutils and amffmpeg
LIBAMPLAYERM6_DEPENDENCIES += alsa-lib librtmp
AMFFMPEG_DIR = $(BUILD_DIR)/libamplayerm6-$(LIBAMPLAYERM6_VERSION)/amffmpeg
AMAVUTILS_DIR = $(BUILD_DIR)/libamplayerm6-$(LIBAMPLAYERM6_VERSION)/amavutils
AMFFMPEG_EXTRA_LDFLAGS += --extra-ldflags="-lamavutils"
endif

define LIBAMPLAYERM6_BUILD_CMDS
	$(call AMAVUTILS_INSTALL_STAGING_CMDS)
	$(call AMFFMPEG_CONFIGURE_CMDS)
	$(call AMFFMPEG_BUILD_CMDS)
	$(call AMFFMPEG_INSTALL_STAGING_CMDS)
endef

define LIBAMPLAYERM6_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/include
	install -m 644 $(@D)/usr/include/*.h $(STAGING_DIR)/usr/include
	mkdir -p $(STAGING_DIR)/usr/include/amlplayer
	install -m 644 $(@D)/usr/include/amlplayer/*.h $(STAGING_DIR)/usr/include/amlplayer
	mkdir -p $(STAGING_DIR)/usr/include/amlplayer/amports
	install -m 644 $(@D)/usr/include/amlplayer/amports/*.h $(STAGING_DIR)/usr/include/amlplayer/amports
	mkdir -p $(STAGING_DIR)/usr/include/amlplayer/ppmgr
	install -m 644 $(@D)/usr/include/amlplayer/ppmgr/*.h $(STAGING_DIR)/usr/include/amlplayer/ppmgr
	cp -rf $(@D)/usr/include/amlplayer/* $(STAGING_DIR)/usr/include
	cd $(STAGING_DIR)/usr/include; ln -sf amlplayer amcodec
endef

define LIBAMPLAYERM6_INSTALL_TARGET_CMDS
	$(call AMAVUTILS_INSTALL_TARGET_CMDS)
	$(call AMFFMPEG_INSTALL_TARGET_CMDS)
	mkdir -p $(TARGET_DIR)/lib/firmware
	install -m 644 $(@D)/lib/firmware/*.bin $(TARGET_DIR)/lib/firmware
	mkdir -p $(TARGET_DIR)/usr/lib
	install -m 755 $(@D)/usr/lib/*.so* $(TARGET_DIR)/usr/lib
	cd $(TARGET_DIR)/usr/lib/; ln -sf libamcodec.so.0.0 libamcodec.so
endef

$(eval $(call generic-package))
