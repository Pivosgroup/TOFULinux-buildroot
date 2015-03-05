################################################################################
#
## boblight
#
#################################################################################

BOBLIGHT_VERSION = r479
BOBLIGHT_SITE_METHOD = svn
BOBLIGHT_SITE = http://boblight.googlecode.com/svn/trunk/
BOBLIGHT_INSTALL_STAGING = YES
BOBLIGHT_INSTALL_TARGET = YES
BOBLIGHT_AUTORECONF = YES
BOBLIGHT_CONF_OPTS += --without-portaudio --without-opengl --without-x11

BOBLIGHT_DEPENDENCIES += linux

ifeq ($(findstring yy,$(BR2_PACKAGE_BOBLIGHT_LIBUSB)$(BR2_PACKAGE_LIBUSB)),yy)
  BOBLIGHT_DEPENDENCIES += libusb
else
  BOBLIGHT_CONF_OPTS += --without-libusb
endif

define BOBLIGHT_INSTALL_INITSCRIPTS_CONFIG
	# install start/stop script
	@if [ ! -f $(TARGET_DIR)/etc/init.d/S70boblight ]; then \
		$(INSTALL) -m 0755 -D package/thirdparty/boblight/S70boblight $(TARGET_DIR)/etc/init.d/S70boblight; \
	fi
	# install config
	@if [ ! -f $(TARGET_DIR)/etc/boblight.conf ]; then \
		$(INSTALL) -m 0644 -D package/thirdparty/boblight/lightpack-single.conf $(TARGET_DIR)/etc/boblight.conf; \
	fi
endef

BOBLIGHT_POST_INSTALL_TARGET_HOOKS += BOBLIGHT_INSTALL_INITSCRIPTS_CONFIG

$(eval $(autotools-package))
