################################################################################
#
# kodi-audiodecoder-modplug
#
################################################################################

KODI_AUDIODECODER_MODPLUG_VERSION = b864fe77e2460301dc1b4320051b51eee4321644
KODI_AUDIODECODER_MODPLUG_SITE = $(call github,notspiff,audiodecoder.modplug,$(KODI_AUDIODECODER_MODPLUG_VERSION))
KODI_AUDIODECODER_MODPLUG_LICENSE = GPLv2+
KODI_AUDIODECODER_MODPLUG_LICENSE_FILES = src/ModplugCodec.cpp
KODI_AUDIODECODER_MODPLUG_DEPENDENCIES = kodi-platform libmodplug

$(eval $(cmake-package))
