PKG_NAME = Netgear-A6210
PKG_VERS = m-7
PKG_EXT = zip
PKG_DIST_NAME = $(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/jurobystricky/Netgear-A6210/archive
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

DEPENDS = 

HOMEPAGE = https://github.com/jurobystricky/Netgear-A6210/
COMMENT  = 
LICENSE  = 

REQ_KERNEL = 1
CONFIGURE_TARGET = nop
COMPILE_TARGET = myCompile

include ../../mk/spksrc.cross-cc.mk

.PHONY: myCompile
myCompile:
	@$(RUN) $(MAKE) LINUX_SRC=$(KERNEL_DIR) LINUX_SRC_MODULE=$(KERNEL_DIR)/net/wireless
