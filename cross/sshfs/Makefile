PKG_NAME = sshfs
PKG_VERS = 2_6
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)_$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/libfuse/sshfs/archive
PKG_DIR = $(PKG_NAME)-$(PKG_NAME)_$(PKG_VERS)

DEPENDS = cross/fuse cross/glib

HOMEPAGE = https://github.com/libfuse/sshfs
COMMENT  = sshfs is a network filesystem client to connect to SSH servers
LICENSE  = GNU GPLv2

GNU_CONFIGURE = 1
PRE_CONFIGURE_TARGET = myPreConfigure

include ../../mk/spksrc.cross-cc.mk

.PHONY: myPreConfigure
myPreConfigure:
	$(RUN) autoreconf -i

