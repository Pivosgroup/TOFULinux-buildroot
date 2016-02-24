################################################################################
#
# kodi-pvr-argustv
#
################################################################################

KODI_PVR_ARGUSTV_VERSION = ebce517b04e184adc13c4780cc3e76487448b79b
KODI_PVR_ARGUSTV_SITE = $(call github,kodi-pvr,pvr.argustv,$(KODI_PVR_ARGUSTV_VERSION))
KODI_PVR_ARGUSTV_LICENSE = GPLv2+
KODI_PVR_ARGUSTV_LICENSE_FILES = src/client.h
KODI_PVR_ARGUSTV_DEPENDENCIES = jsoncpp kodi-platform

$(eval $(cmake-package))
