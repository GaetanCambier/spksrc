PKG_NAME = sshfs
PKG_VERS = 2_6
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)_$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/libfuse/sshfs/archive
PKG_DIR = $(PKG_NAME)-$(PKG_NAME)_$(PKG_VERS)

DEPENDS = cross/fuse cross/glib

HOMEPAGE = http://fuse.sourceforge.net/sshfs.html
COMMENT  = sshfs is a filesystem client based on the SSH File Transfer Protocol.
LICENSE  = GNU GPLv2

GNU_CONFIGURE = 1
PRE_CONFIGURE_TARGET = myPreConfigure

include ../../mk/spksrc.cross-cc.mk

.PHONY: myPreConfigure
myPreConfigure:
	$(RUN) autoreconf -i

