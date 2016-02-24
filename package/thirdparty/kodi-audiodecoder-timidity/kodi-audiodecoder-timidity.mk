################################################################################
#
# kodi-audiodecoder-timidity
#
################################################################################

KODI_AUDIODECODER_TIMIDITY_VERSION = f649d32884a528f4af74c6f81980a58445c42bda
KODI_AUDIODECODER_TIMIDITY_SITE = $(call github,notspiff,audiodecoder.timidity,$(KODI_AUDIODECODER_TIMIDITY_VERSION))
KODI_AUDIODECODER_TIMIDITY_LICENSE = GPLv2+
KODI_AUDIODECODER_TIMIDITY_LICENSE_FILES = src/TimidityCodec.cpp
KODI_AUDIODECODER_TIMIDITY_DEPENDENCIES = kodi-platform

$(eval $(cmake-package))
