PKG_NAME = fuse
PKG_VERS = 2.9.5
PKG_DIR_SITE = $(PKG_NAME)_2.9.5
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/libfuse/libfuse/releases/download/$(PKG_DIR_SITE)
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

DEPENDS =

HOMEPAGE = https://github.com/libfuse/libfuse
COMMENT  = File System in User Space
LICENSE  = GNU GPLv2

GNU_CONFIGURE = 1
CONFIGURE_ARGS =  --exec-prefix=$(STAGING_INSTALL_PREFIX)

include ../../mk/spksrc.cross-cc.mk

