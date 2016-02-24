################################################################################
#
# kodi-audiodecoder-nosefart
#
################################################################################

KODI_AUDIODECODER_NOSEFART_VERSION = 47b69360ef4aca6d9be4e937fa4d0621e896760e
KODI_AUDIODECODER_NOSEFART_SITE = $(call github,notspiff,audiodecoder.nosefart,$(KODI_AUDIODECODER_NOSEFART_VERSION))
KODI_AUDIODECODER_NOSEFART_LICENSE = GPLv2+
KODI_AUDIODECODER_NOSEFART_LICENSE_FILES = src/NSFCodec.cpp
KODI_AUDIODECODER_NOSEFART_DEPENDENCIES = kodi-platform

$(eval $(cmake-package))
