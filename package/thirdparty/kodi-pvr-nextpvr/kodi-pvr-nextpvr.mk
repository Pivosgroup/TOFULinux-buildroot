################################################################################
#
# kodi-pvr-nextpvr
#
################################################################################

KODI_PVR_NEXTPVR_VERSION = 82462e7333f9d335162b67711a0a761c06d6def2
KODI_PVR_NEXTPVR_SITE = $(call github,kodi-pvr,pvr.nextpvr,$(KODI_PVR_NEXTPVR_VERSION))
KODI_PVR_NEXTPVR_LICENSE = GPLv2+
KODI_PVR_NEXTPVR_LICENSE_FILES = src/client.h
KODI_PVR_NEXTPVR_DEPENDENCIES = kodi-platform

$(eval $(cmake-package))
