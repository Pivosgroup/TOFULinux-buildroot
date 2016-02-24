################################################################################
#
# kodi-pvr-stalker
#
################################################################################

KODI_PVR_STALKER_VERSION = d54e932af60a0292a1059b91e0362c78914e1d55
KODI_PVR_STALKER_SITE = $(call github,kodi-pvr,pvr.stalker,$(KODI_PVR_STALKER_VERSION))
KODI_PVR_STALKER_LICENSE = GPLv2+
KODI_PVR_STALKER_LICENSE_FILES = src/client.h
KODI_PVR_STALKER_DEPENDENCIES = jsoncpp kodi-platform

$(eval $(cmake-package))
