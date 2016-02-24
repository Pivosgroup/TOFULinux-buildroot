################################################################################
#
# kodi-audioencoder-flac
#
################################################################################

KODI_AUDIOENCODER_FLAC_VERSION = f8a9cd0787114458ab8e2978560e01ca86b9575c
KODI_AUDIOENCODER_FLAC_SITE = $(call github,xbmc,audioencoder.flac,$(KODI_AUDIOENCODER_FLAC_VERSION))
KODI_AUDIOENCODER_FLAC_LICENSE = GPLv2+
KODI_AUDIOENCODER_FLAC_LICENSE_FILES = src/EncoderFlac.cpp
KODI_AUDIOENCODER_FLAC_DEPENDENCIES = flac kodi libogg host-pkgconf

$(eval $(cmake-package))
