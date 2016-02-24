################################################################################
#
# kodi-pvr-pctv
#
################################################################################

KODI_PVR_PCTV_VERSION = 8ea856cbcd11f051b0603249309560105d75f8d9
KODI_PVR_PCTV_SITE = $(call github,kodi-pvr,pvr.pctv,$(KODI_PVR_PCTV_VERSION))
KODI_PVR_PCTV_LICENSE = GPLv2+
KODI_PVR_PCTV_LICENSE_FILES = src/client.h
KODI_PVR_PCTV_DEPENDENCIES = jsoncpp kodi-platform

$(eval $(cmake-package))
