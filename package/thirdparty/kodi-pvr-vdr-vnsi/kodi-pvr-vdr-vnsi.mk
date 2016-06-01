################################################################################
#
# kodi-pvr-vdr-vnsi
#
################################################################################

KODI_PVR_VDR_VNSI_VERSION = f4b5eeee897560925a4709c1ceec4fbf4bdd4dcd
KODI_PVR_VDR_VNSI_SITE = $(call github,kodi-pvr,pvr.vdr.vnsi,$(KODI_PVR_VDR_VNSI_VERSION))
KODI_PVR_VDR_VNSI_LICENSE = GPLv2+
KODI_PVR_VDR_VNSI_LICENSE_FILES = src/client.h
KODI_PVR_VDR_VNSI_DEPENDENCIES = kodi-platform

$(eval $(cmake-package))
