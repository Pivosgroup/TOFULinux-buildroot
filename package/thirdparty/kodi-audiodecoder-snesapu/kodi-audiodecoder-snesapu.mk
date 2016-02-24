################################################################################
#
# kodi-audiodecoder-snesapu
#
################################################################################

KODI_AUDIODECODER_SNESAPU_VERSION = 3b76a2b96516cb76fe05492e125d73958b3cbad7
KODI_AUDIODECODER_SNESAPU_SITE = $(call github,notspiff,audiodecoder.snesapu,$(KODI_AUDIODECODER_SNESAPU_VERSION))
KODI_AUDIODECODER_SNESAPU_LICENSE = GPLv2+
KODI_AUDIODECODER_SNESAPU_LICENSE_FILES = src/SPCCodec.cpp
KODI_AUDIODECODER_SNESAPU_DEPENDENCIES = kodi-platform

$(eval $(cmake-package))
