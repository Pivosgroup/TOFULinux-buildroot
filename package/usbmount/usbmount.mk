################################################################################
#
# usbmount
#
################################################################################

USBMOUNT_VERSION = 0.0.22
USBMOUNT_SOURCE = usbmount_$(USBMOUNT_VERSION).tar.gz
USBMOUNT_SITE = http://snapshot.debian.org/archive/debian/20141023T043132Z/pool/main/u/usbmount
USBMOUNT_DEPENDENCIES = udev lockfile-progs
USBMOUNT_LICENSE = BSD-2c
USBMOUNT_LICENSE_FILES = debian/copyright

define USBMOUNT_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/usbmount $(TARGET_DIR)/usr/share/usbmount/usbmount

	$(INSTALL) -m 0755 -D $(@D)/00_create_model_symlink 	\
		$(TARGET_DIR)/etc/usbmount/usbmount.d/00_create_model_symlink
	$(INSTALL) -m 0755 -D $(@D)/00_remove_model_symlink 	\
		$(TARGET_DIR)/etc/usbmount/usbmount.d/00_remove_model_symlink

	$(INSTALL) -m 0644 -D $(@D)/usbmount.rules $(TARGET_DIR)/lib/udev/rules.d/usbmount.rules
	@if [ ! -f $(TARGET_DIR)/etc/usbmount/usbmount.conf ]; then \
	        $(INSTALL) -m 0644 -D $(@D)/usbmount.conf $(TARGET_DIR)/etc/usbmount/usbmount.conf; \
	fi
endef

$(eval $(generic-package))
