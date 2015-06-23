
################################################################################
#
## kodi
#
#################################################################################

KODI_VERSION = b2664515f7081ff920b04c3ab10488d16e901271
KODI_SITE = $(call github,Pivosgroup,TOFULinux-app-private,$(KODI_VERSION))
KODI_LICENSE = GPLv2
XMBC_LICENSE_FILES = LICENSE.GPL
KODI_INSTALL_STAGING = YES

KODI_DEPENDENCIES = host-gawk host-gettext host-gperf host-infozip host-lzo \
	host-nasm host-sdl_image host-swig

KODI_DEPENDENCIES += avahi boost bzip2 dbus expat ffmpeg flac fontconfig freetype jasper jpeg \
	libass libbluray libcdio libcec libcurl libfribidi libgcrypt libmad libmicrohttpd libmodplug libmpeg2 \
	libnfs libogg libplist libpng libsamplerate libshairplay libssh libssh2 libtheora libungif libusb-compat libvorbis libxml2 libxslt lzo mysql ncurses \
	opengl openssl pcre python readline samba sqlite taglib tiff tinyxml udev wavpack yajl zlib

KODI_CONF_ENV = \
	PYTHON_VERSION="$(PYTHON_VERSION_MAJOR)" \
	PYTHON_LDFLAGS="-lpython$(PYTHON_VERSION_MAJOR) -lpthread -ldl -lutil -lm" \
	PYTHON_CPPFLAGS="-I$(STAGING_DIR)/usr/include/python$(PYTHON_VERSION_MAJOR)" \
	PYTHON_SITE_PKG="$(STAGING_DIR)/usr/lib/python$(PYTHON_VERSION_MAJOR)/site-packages" \
	PYTHON_NOVERSIONCHECK="no-check" \
	use_texturepacker_native=yes \
	USE_TEXTUREPACKER_NATIVE_ROOT="$(HOST_DIR)/usr" \
	TEXTUREPACKER_NATIVE_ROOT="$(HOST_DIR)/usr"

# For braindead apps like mysql that require running a binary/script
KODI_CONF_ENV += PATH="$(STAGING_DIR)/usr/bin:$(HOST_DIR)/usr/bin:$(PATH)"

KODI_CONF_OPTS += --with-ffmpeg=shared --enable-neon --enable-gles --disable-sdl --disable-x11 --disable-xrandr \
  --disable-projectm --enable-debug --disable-joystick --with-cpu=cortex-a9

# Add HOST_DIR to PATH for codegenerator.mk to find swig
define KODI_BOOTSTRAP
	cd $(@D) && PATH=$(BR_PATH) ./bootstrap
endef
KODI_PRE_CONFIGURE_HOOKS += KODI_BOOTSTRAP

ifeq ($(BR2_ARM_AMLOGIC),y)
KODI_CONF_OPTS += --enable-codec=amcodec
endif

ifeq ($(BR2_KODI_POWERDOWN),y)
KODI_CONF_OPTS += --enable-powerdown
endif

ifeq ($(BR2_KODI_SUSPEND),y)
KODI_CONF_OPTS += --enable-suspend
endif

ifeq ($(BR2_KODI_HIBERNATE),y)
KODI_CONF_OPTS += --enable-hibernate
endif

ifeq ($(BR2_KODI_REBOOT),y)
KODI_CONF_OPTS += --enable-reboot
endif

ifneq ($(BR2_CCACHE),y)
KODI_CONF_OPTS += --disable-ccache
endif

ifneq ($(BR2_KODI_REMOTE_CONF),"")
KODI_REMOTE_CONF = package/thirdparty/kodi/remotes/$(call qstrip,$(BR2_KODI_REMOTE_CONF)).conf
else
KODI_REMOTE_CONF = package/thirdparty/kodi/remotes/xios_remote.conf
endif

ifneq ($(BR2_KODI_KEYMAP),"")
KODI_KEYMAP = package/thirdparty/kodi/keymaps/$(call qstrip,$(BR2_KODI_KEYMAP)).xml
else
KODI_KEYMAP = package/thirdparty/kodi/keymaps/variant.xios.keyboard.xml
endif

ifneq ($(BR2_KODI_SETTINGS),"")
KODI_SETTINGS = package/thirdparty/kodi/settings/$(call qstrip,$(BR2_KODI_SETTINGS)).xml
else
KODI_SETTINGS = package/thirdparty/kodi/settings/xios_settings.xml
endif

ifneq ($(BR2_KODI_ADV_SETTINGS),"")
KODI_ADV_SETTINGS = package/thirdparty/kodi/settings/$(call qstrip,$(BR2_KODI_ADV_SETTINGS)).xml
endif

ifneq ($(BR2_KODI_SPLASH),"")
KODI_SPLASH_FILE = package/thirdparty/kodi/logos/$(call qstrip,$(BR2_KODI_SPLASH)).png
else
KODI_SPLASH_FILE = package/thirdparty/kodi/logos/ds.splash.png
endif

ifneq ($(BR2_KODI_RSS_FEEDS),"")
KODI_RSS_FEEDS = package/thirdparty/kodi/settings/$(call qstrip,$(BR2_KODI_RSS_FEEDS)).xml
endif

ifneq ($(BR2_KODI_OVERLAY_FB),y)
ifneq ($(BR2_KODI_STARTING_FB),"")
KODI_STARTING_FB = package/thirdparty/kodi/fb_splashs/$(call qstrip,$(BR2_KODI_STARTING_FB)).fb.lzo
else
KODI_STARTING_FB = package/thirdparty/kodi/fb_splashs/xios_starting.fb.lzo
endif

ifneq ($(BR2_KODI_STOPPING_FB),"")
KODI_STOPPING_FB = package/thirdparty/kodi/fb_splashs/$(call qstrip,$(BR2_KODI_STOPPING_FB)).fb.lzo
else
KODI_STOPPING_FB = package/thirdparty/kodi/fb_splashs/ds.shutting.down.fb.lzo
endif

ifneq ($(BR2_KODI_COMPLETE_FB),"")
KODI_COMPLETE_FB = package/thirdparty/kodi/fb_splashs/$(call qstrip,$(BR2_KODI_COMPLETE_FB)).fb.lzo
else
KODI_COMPLETE_FB = package/thirdparty/kodi/fb_splashs/ds.shutdown.complete.fb.lzo
endif

ifneq ($(BR2_KODI_COPYING_FB),"")
KODI_COPYING_FB = package/thirdparty/kodi/fb_splashs/$(call qstrip,$(BR2_KODI_COPYING_FB)).fb.lzo
else
KODI_COPYING_FB = package/thirdparty/kodi/fb_splashs/ds.copy.fb.lzo
endif
endif

ifneq ($(BR2_KODI_REBOOTING_FB),"")
KODI_REBOOTING_FB = package/thirdparty/kodi/fb_splashs/$(call qstrip,$(BR2_KODI_REBOOTING_FB)).fb.lzo
else
KODI_REBOOTING_FB = package/thirdparty/kodi/fb_splashs/ds.rebooting.fb.lzo
endif

ifeq ($(BR2_KODI_SET_CONFLUENCE_POWER_BUTTON_POWERDOWN),y)
CONFLUENCE_POWER_BUTTON_FUNCTION = KODI.Powerdown()
else ifeq ($(BR2_KODI_SET_CONFLUENCE_POWER_BUTTON_SUSPEND),y)
CONFLUENCE_POWER_BUTTON_FUNCTION = KODI.Suspend()
else ifeq ($(BR2_KODI_SET_CONFLUENCE_POWER_BUTTON_HIBERNATE),y)
CONFLUENCE_POWER_BUTTON_FUNCTION = KODI.Hibernate()
else ifeq ($(BR2_KODI_SET_CONFLUENCE_POWER_BUTTON_REBOOT),y)
CONFLUENCE_POWER_BUTTON_FUNCTION = KODI.Reset()
else
CONFLUENCE_POWER_BUTTON_FUNCTION = ActivateWindow(ShutdownMenu)
endif

define KODI_INSTALL_ETC
  cp -rf package/thirdparty/kodi/etc $(TARGET_DIR)
endef

define KODI_INSTALL_SETTINGS
  cp -f $(KODI_SETTINGS) $(TARGET_DIR)/usr/share/kodi/system/settings/settings.xml
endef

define KODI_INSTALL_ADV_SETTINGS
  cp -f $(KODI_ADV_SETTINGS) $(TARGET_DIR)/usr/share/kodi/system/advancedsettings.xml
endef

define KODI_INSTALL_KEYMAP
  cp -f $(KODI_KEYMAP) $(TARGET_DIR)/usr/share/kodi/system/keymaps/
  cp -f package/thirdparty/kodi/keymaps/nobs.xml $(TARGET_DIR)/usr/share/kodi/system/keymaps/
endef

define KODI_INSTALL_REMOTE_CONF
  mkdir -p $(TARGET_DIR)/etc/kodi
  cp -f $(KODI_REMOTE_CONF) $(TARGET_DIR)/etc/kodi/remote.conf
  cp -f package/thirdparty/kodi/remotes/remote-lirc.conf $(TARGET_DIR)/etc/kodi/
endef

define KODI_SET_DEFAULT_SKIN
  sed -i '/<default>skin./c\          <default>skin.$(call qstrip,$(BR2_KODI_DEFAULT_SKIN))</default>' $(TARGET_DIR)/usr/share/kodi/system/settings/settings.xml
endef

define KODI_SET_DEFAULT_DEVICE_NAME
  sed -i 's/<default>kodi<\/default>/<default>$(call qstrip,$(BR2_KODI_DEFAULT_DEVICE_NAME))<\/default>/gI' $(TARGET_DIR)/usr/share/kodi/system/settings/settings.xml
  sed -i 's/kodi/$(call qstrip,$(BR2_KODI_DEFAULT_DEVICE_NAME))/gI' $(TARGET_DIR)/usr/share/kodi/language/*/strings.po
endef

define KODI_INSTALL_SPLASH
  mkdir -p $(TARGET_DIR)/usr/share/splash
  cp -f $(KODI_SPLASH_FILE) $(TARGET_DIR)/usr/share/kodi/media/Splash.png
endef

define KODI_INSTALL_FB_SPLASHS
  cp -f $(KODI_STARTING_FB) $(TARGET_DIR)/usr/share/splash/starting.fb.lzo
  cp -f $(KODI_STOPPING_FB) $(TARGET_DIR)/usr/share/splash/stopping.fb.lzo
  cp -f $(KODI_COMPLETE_FB) $(TARGET_DIR)/usr/share/splash/complete.fb.lzo
  cp -f $(KODI_COPYING_FB) $(TARGET_DIR)/usr/share/splash/copying.fb.lzo
  cp -f $(KODI_REBOOTING_FB) $(TARGET_DIR)/usr/share/splash/rebooting.fb.lzo
endef

define KODI_INSTALL_RSS_FEEDS
  cp -f $(KODI_RSS_FEEDS) $(TARGET_DIR)/usr/share/kodi/userdata/RssFeeds.xml
endef

define KODI_CLEAN_UNUSED_ADDONS
  rm -rf $(TARGET_DIR)/usr/share/kodi/addons/screensaver.rsxs.euphoria
  rm -rf $(TARGET_DIR)/usr/share/kodi/addons/screensaver.rsxs.plasma
  rm -rf $(TARGET_DIR)/usr/share/kodi/addons/screensaver.rsxs.solarwinds
  rm -rf $(TARGET_DIR)/usr/share/kodi/addons/visualization.milkdrop
  rm -rf $(TARGET_DIR)/usr/share/kodi/addons/visualization.projectm
  rm -rf $(TARGET_DIR)/usr/share/kodi/addons/visualization.itunes
  rm -rf $(TARGET_DIR)/usr/share/kodi/addons/service.kodi.versioncheck
endef

define KODI_SET_CONFLUENCE_POWER_BUTTON
  sed -i '/				####Compiler will set function####/c\				<onclick>$(CONFLUENCE_POWER_BUTTON_FUNCTION)</onclick>' $(TARGET_DIR)/usr/share/kodi/addons/skin.confluence/720p/Home.xml
endef

define KODI_CLEAN_CONFLUENCE_SKIN
  find $(TARGET_DIR)/usr/share/kodi/addons/skin.confluence/media -name *.png -delete
  find $(TARGET_DIR)/usr/share/kodi/addons/skin.confluence/media -name *.jpg -delete
endef

define KODI_REMOVE_CONFLUENCE_SKIN
  rm -rf $(TARGET_DIR)/usr/share/kodi/addons/skin.confluence
endef

define KODI_REMOVE_TOFU_BLUR_SKIN
  rm -rf $(TARGET_DIR)/usr/share/kodi/addons/skin.tofu-blur
endef

define KODI_STRIP_BINARIES
  find $(TARGET_DIR)/usr/lib/kodi/ -name "*.so" -exec $(STRIPCMD) $(STRIP_STRIP_UNNEEDED) {} \;
  $(STRIPCMD) $(STRIP_STRIP_UNNEEDED) $(TARGET_DIR)/usr/lib/kodi/kodi.bin
endef

KODI_POST_INSTALL_TARGET_HOOKS += KODI_INSTALL_ETC
KODI_POST_INSTALL_TARGET_HOOKS += KODI_INSTALL_ADV_SETTINGS
KODI_POST_INSTALL_TARGET_HOOKS += KODI_INSTALL_KEYMAP
KODI_POST_INSTALL_TARGET_HOOKS += KODI_INSTALL_SPLASH
KODI_POST_INSTALL_TARGET_HOOKS += KODI_CLEAN_UNUSED_ADDONS
KODI_POST_INSTALL_TARGET_HOOKS += KODI_CLEAN_CONFLUENCE_SKIN
KODI_POST_INSTALL_TARGET_HOOKS += KODI_INSTALL_REMOTE_CONF
KODI_POST_INSTALL_TARGET_HOOKS += KODI_INSTALL_RSS_FEEDS

ifneq ($(BR2_KODI_OVERLAY_FB),y)
KODI_POST_INSTALL_TARGET_HOOKS += KODI_INSTALL_FB_SPLASHS
endif

ifneq ($(BR2_KODI_SETTINGS),"")
KODI_POST_INSTALL_TARGET_HOOKS += KODI_INSTALL_SETTINGS
endif

ifneq ($(BR2_ENABLE_DEBUG),y)
KODI_POST_INSTALL_TARGET_HOOKS += KODI_STRIP_BINARIES
endif

ifneq ($(BR2_KODI_DEFAULT_SKIN),"")
KODI_POST_INSTALL_TARGET_HOOKS += KODI_SET_DEFAULT_SKIN
endif

ifeq ($(BR2_KODI_NO_CONFLUENCE),y)
KODI_POST_INSTALL_TARGET_HOOKS += KODI_REMOVE_CONFLUENCE_SKIN
else
KODI_POST_INSTALL_TARGET_HOOKS += KODI_SET_CONFLUENCE_POWER_BUTTON
endif

ifeq ($(BR2_KODI_NO_TOFU_BLUR),y)
KODI_POST_INSTALL_TARGET_HOOKS += KODI_REMOVE_TOFU_BLUR_SKIN
endif

ifneq ($(BR2_KODI_DEFAULT_DEVICE_NAME),"")
KODI_POST_INSTALL_TARGET_HOOKS += KODI_SET_DEFAULT_DEVICE_NAME
endif

$(eval $(autotools-package))
