################################################################################
#
# kodi-pvr-wmc
#
################################################################################

KODI_PVR_WMC_VERSION = 77923a098fbe5d6b7b2ec4d67f59df5ab3e4d64d
KODI_PVR_WMC_SITE = $(call github,kodi-pvr,pvr.wmc,$(KODI_PVR_WMC_VERSION))
KODI_PVR_WMC_LICENSE = GPLv2+
KODI_PVR_WMC_LICENSE_FILES = src/client.h
KODI_PVR_WMC_DEPENDENCIES = kodi-platform

$(eval $(cmake-package))
