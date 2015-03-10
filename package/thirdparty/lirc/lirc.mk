LIRC_VERSION = 0.8.7
LIRC_SOURCE = lirc-$(LIRC_VERSION).tar.gz
LIRC_SITE = http://downloads.sourceforge.net/project/lirc/LIRC/$(LIRC_VERSION)
LIRC_INSTALL_STAGING = YES
LIRC_INSTALL_TARGET = YES
LIRC_MAKE=$(MAKE1)

LIRC_DEPENDENCIES += linux

LIRC_CONF_OPTS += --with-kerneldir=$(LINUX_DIR)
LIRC_CONF_OPTS += --with-driver=all
LIRC_CONF_OPTS += --with-moduledir="/lib/modules/$(LINUX_VERSION_PROBED)/misc"

# hack to avoid mknod (requires root). This will be populated automatically.
LIRC_CONF_OPTS += ac_cv_path_mknod=$(shell which echo)

# disable X support
LIRC_CONF_OPTS += --without-x

#work-around for hard-coded depmod
define LIRC_DEPMOD
$(HOST_DIR)/sbin/depmod -b $(TARGET_DIR) -a $(LINUX_VERSION_PROBED)
endef

define LIRC_REMOVE_BROKEN_DRIVERS
sed -i 's/lirc_wpc8769l//' $(@D)/drivers/Makefile
endef

define LIRC_INSTALL_ETC
  cp -rf package/thirdparty/lirc/etc $(TARGET_DIR)
endef

LIRC_POST_CONFIGURE_HOOKS += LIRC_REMOVE_BROKEN_DRIVERS
LIRC_POST_INSTALL_TARGET_HOOKS += LIRC_DEPMOD
LIRC_POST_INSTALL_TARGET_HOOKS += LIRC_INSTALL_ETC

$(eval $(autotools-package))

