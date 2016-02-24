################################################################################
#
# kodi-pvr-vbox
#
################################################################################

KODI_PVR_VBOX_VERSION = ceaf494f22fb5f495399f5db6815821ae9949765
KODI_PVR_VBOX_SITE = $(call github,kodi-pvr,pvr.vbox,$(KODI_PVR_VBOX_VERSION))
KODI_PVR_VBOX_LICENSE = GPLv2+
KODI_PVR_VBOX_LICENSE_FILES = src/client.h
KODI_PVR_VBOX_DEPENDENCIES = kodi-platform

$(eval $(cmake-package))
