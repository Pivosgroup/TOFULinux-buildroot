################################################################################
#
# kodi-pvr-mediaportal-tvserver
#
################################################################################

KODI_PVR_MEDIAPORTAL_TVSERVER_VERSION = 58a3d3dac67ca85968ca0f09de5a5b0040b67b74
KODI_PVR_MEDIAPORTAL_TVSERVER_SITE = $(call github,kodi-pvr,pvr.mediaportal.tvserver,$(KODI_PVR_MEDIAPORTAL_TVSERVER_VERSION))
KODI_PVR_MEDIAPORTAL_TVSERVER_LICENSE = GPLv2+
KODI_PVR_MEDIAPORTAL_TVSERVER_LICENSE_FILES = src/client.h
KODI_PVR_MEDIAPORTAL_TVSERVER_DEPENDENCIES = kodi-platform

$(eval $(cmake-package))
