################################################################################
#
## libssh
#
#################################################################################

LIBSSH_VERSION = 0.7.0
LIBSSH_SITE = https://git.libssh.org/projects/libssh.git/snapshot
LIBSSH_INSTALL_STAGING = YES
LIBSSH_TEMP_BUILDDIR=output/build/libssh-build
LIBSSH_CONF_OPTS += -DWITH_SERVER=OFF

define LIBSSH_CONFIGURE_CMDS
        (mkdir -p $(LIBSSH_TEMP_BUILDDIR) && rm -rf $(LIBSSH_TEMP_BUILDDIR)/* && \
         cd $(LIBSSH_TEMP_BUILDDIR) && \
        $(LIBSSH_CONF_ENV) $(HOST_DIR)/usr/bin/cmake $(LIBSSH_SRCDIR) \
                -DCMAKE_TOOLCHAIN_FILE="$(BASE_DIR)/host/usr/share/buildroot/toolchainfile.cmake" \
                -DCMAKE_INSTALL_PREFIX="/usr" \
                $(LIBSSH_CONF_OPTS) \
        )
endef

define LIBSSH_BUILD_CMDS
        $(HOST_MAKE_ENV) $(LIBSSH_MAKE_ENV) $(LIBSSH_MAKE) $(LIBSSH_MAKE_OPTS) -C $(LIBSSH_TEMP_BUILDDIR)
endef

define LIBSSH_INSTALL_STAGING_CMDS
        $(TARGET_MAKE_ENV) $(LIBSSH_MAKE_ENV) $(LIBSSH_MAKE) $(LIBSSH_MAKE_OPTS) $(LIBSSH_INSTALL_STAGING_OPTS) -C $(LIBSSH_TEMP_BUILDDIR)
endef

define LIBSSH_INSTALL_TARGET_CMDS
        $(TARGET_MAKE_ENV) $(LIBSSH_MAKE_ENV) $(LIBSSH_MAKE) $(LIBSSH_MAKE_OPTS) $(LIBSSH_INSTALL_TARGET_OPTS) -C $(LIBSSH_TEMP_BUILDDIR) && \
        rm -rf $(LIBSSH_TEMP_BUILDDIR)
endef

$(eval $(cmake-package))
