PKG_NAME = libcap
PKG_VERS = 2.25
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

DEPENDS = cross/attr

HOMEPAGE = http://kernel.org/
COMMENT  = 
LICENSE  = 

CONFIGURE_TARGET = nope
ADDITIONAL_CFLAGS = "-I$(WORK_DIR)/$(PKG_DIR)/libcap/include"
ADDITIONAL_LDFLAGS = "-L$(WORK_DIR)/$(PKG_DIR)/libcap"
ENV += BUILD_CFLAGS="\$$(CFLAGS)" BUILD_CC="cc"


include ../../mk/spksrc.cross-cc.mk

