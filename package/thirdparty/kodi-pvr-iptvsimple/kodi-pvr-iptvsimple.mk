################################################################################
#
# kodi-pvr-iptvsimple
#
################################################################################

KODI_PVR_IPTVSIMPLE_VERSION = 567eeb3351a7fcefdd39f34fc4e916174c8b75a4
KODI_PVR_IPTVSIMPLE_SITE = $(call github,kodi-pvr,pvr.iptvsimple,$(KODI_PVR_IPTVSIMPLE_VERSION))
KODI_PVR_IPTVSIMPLE_LICENSE = GPLv2+
KODI_PVR_IPTVSIMPLE_LICENSE_FILES = src/client.h
KODI_PVR_IPTVSIMPLE_DEPENDENCIES = kodi-platform

$(eval $(cmake-package))
