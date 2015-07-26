################################################################################
#
# libsquish
#
################################################################################

LIBSQUISH_VERSION = 1.10-openelec
LIBSQUISH_SOURCE = libsquish-$(LIBSQUISH_VERSION).tar.gz
LIBSQUISH_SITE = http://sources.openelec.tv/devel
LIBSQUISH_INSTALL_STAGING = YES
LIBSQUISH_LICENSE = MIT
LIBSQUISH_LICENSE_FILES = README

define LIBSQUISH_INSTALL_STAGING_CMDS
	CXX=$(TARGET_CXX) CXXFLAGS="$(TARGET_CXXFLAGS)" \
	$(MAKE) -C $(@D) install PREFIX=/usr INSTALL_DIR=$(STAGING_DIR)/usr
endef

define LIBSQUISH_INSTALL_TARGET_CMDS
	CXX=$(TARGET_CXX) CXXFLAGS="$(TARGET_CXXFLAGS)" \
	$(MAKE) -C $(@D) install PREFIX=/usr INSTALL_DIR=$(TARGET_DIR)/usr
endef

$(eval $(generic-package))
