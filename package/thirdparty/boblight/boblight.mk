################################################################################
#
## boblight
#
#################################################################################

BOBLIGHT_VERSION = 424ff42b7d41d299c060ff373c18360a7e22a4b8
BOBLIGHT_SITE_METHOD = git
BOBLIGHT_SITE = https://github.com/Pivosgroup/boblight.git
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
	$(INSTALL) -m 0755 -D package/thirdparty/boblight/S70boblight $(TARGET_DIR)/etc/init.d/S70boblight; \
	# install config
	$(INSTALL) -m 0644 -D package/thirdparty/boblight/lightpack-single.conf $(TARGET_DIR)/etc/boblight.conf; \
	# install udev rule
	$(INSTALL) -m 0644 -D package/thirdparty/boblight/97-lightpack.rules $(TARGET_DIR)/etc/udev/rules.d/97-lightpack.rules;
endef

BOBLIGHT_POST_INSTALL_TARGET_HOOKS += BOBLIGHT_INSTALL_INITSCRIPTS_CONFIG

$(eval $(autotools-package))
