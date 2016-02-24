################################################################################
#
# kodi-pvr-vuplus
#
################################################################################

KODI_PVR_VUPLUS_VERSION = e7bc053069f66c025d825213cc8e4832ec7267b4
KODI_PVR_VUPLUS_SITE = $(call github,kodi-pvr,pvr.vuplus,$(KODI_PVR_VUPLUS_VERSION))
KODI_PVR_VUPLUS_LICENSE = GPLv2+
KODI_PVR_VUPLUS_LICENSE_FILES = src/client.h
KODI_PVR_VUPLUS_DEPENDENCIES = kodi-platform

$(eval $(cmake-package))
