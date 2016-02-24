################################################################################
#
# kodi-pvr-njoy
#
################################################################################

KODI_PVR_NJOY_VERSION = 7342f9ed339eef0fbd2bc09880af9c99517938b1
KODI_PVR_NJOY_SITE = $(call github,kodi-pvr,pvr.njoy,$(KODI_PVR_NJOY_VERSION))
KODI_PVR_NJOY_LICENSE = GPLv2+
KODI_PVR_NJOY_LICENSE_FILES = src/client.h
KODI_PVR_NJOY_DEPENDENCIES = kodi-platform

$(eval $(cmake-package))
