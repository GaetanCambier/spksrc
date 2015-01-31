PKG_NAME = redis-php
PKG_VERS = 2.2.5
PKG_EXT = tgz
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = http://zlib.net
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

# DEPENDS = cross/glib

CONFIGURE_ARGS = --host --host-alias

GNU_CONFIGURE = 1

PRE_CONFIGURE_TARGET = myPreConfigure

include ../../mk/spksrc.cross-cc.mk

.PHONY: myPreConfigure
myPreConfigure:
	cd $(WORK_DIR)/$(PKG_DIR) ; phpize5
.PHONY: myCompile
myCompile:
	$(RUN) $(MAKE) 

.PHONY: myInstall
myInstall:
		$(RUN) $(MAKE) install PREFIX=$(STAGING_INSTALL_PREFIX)
