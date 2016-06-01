################################################################################
#
# kodi-audiodecoder-stsound
#
################################################################################

KODI_AUDIODECODER_STSOUND_VERSION = ce7f50a00c07c8562c192d0dcb61e7074576590b
KODI_AUDIODECODER_STSOUND_SITE = $(call github,notspiff,audiodecoder.stsound,$(KODI_AUDIODECODER_STSOUND_VERSION))
KODI_AUDIODECODER_STSOUND_LICENSE = GPLv2+
KODI_AUDIODECODER_STSOUND_LICENSE_FILES = src/YMCodec.cpp
KODI_AUDIODECODER_STSOUND_DEPENDENCIES = kodi-platform

$(eval $(cmake-package))
