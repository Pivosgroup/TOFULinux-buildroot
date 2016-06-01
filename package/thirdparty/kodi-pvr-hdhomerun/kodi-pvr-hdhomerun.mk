################################################################################
#
# kodi-pvr-hdhomerun
#
################################################################################

KODI_PVR_HDHOMERUN_VERSION = 154896a857e6a071e5fe5332f1d02639b9d05650
KODI_PVR_HDHOMERUN_SITE = $(call github,kodi-pvr,pvr.hdhomerun,$(KODI_PVR_HDHOMERUN_VERSION))
KODI_PVR_HDHOMERUN_LICENSE = GPLv2+
KODI_PVR_HDHOMERUN_LICENSE_FILES = src/client.h
KODI_PVR_HDHOMERUN_DEPENDENCIES = kodi-platform

$(eval $(cmake-package))
