PKG_NAME = squid
PKG_VERS = 3.5.12
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = http://www.squid-cache.org/Versions/v3/3.5
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

DEPENDS = cross/linux-pam cross/openssl cross/openldap native/$(PKG_NAME)-3.5

HOMEPAGE = http://www.squid-cache.org/
COMMENT  = Squid is a fully-featured HTTP/1.0 proxy which is almost HTTP/1.1 compliant.
LICENSE  = 

ifneq (,$(findstring $(TCVERSION),"3.1 4.0 4.1 4.2"))
  @$(error $(PKG_NAME)-$(PKG_VERS) require newer Toolchain)
endif

GNU_CONFIGURE = 1

CONFIGURE_ARGS  = --enable-linux-netfilter --with-openssl --enable-ssl-crtd --disable-arch-native --disable-external-acl-helpers squid_cv_gnu_atomics=no

HOSTCFGEN_NATIVE = $(WORK_DIR)/../../../native/$(PKG_NAME)-3.5/work-native/$(PKG_DIR)/src/cf_gen
HOSTCFGEN = $(WORK_DIR)/$(PKG_DIR)/cf_gen

# Compile
PRE_CONFIGURE_TARGET = myPreConfigure
PRE_COMPILE_TARGET = myPreCompile


include ../../mk/spksrc.cross-cc.mk

.PHONY: myPreConfigure
myPreConfigure:
	mkdir -p $(WORK_DIR)/install/$(INSTALL_PREFIX)/include/security/
	cp $(WORK_DIR)/install/$(INSTALL_PREFIX)/include/pam_appl.h $(WORK_DIR)/install/$(INSTALL_PREFIX)/include/security/
	cp $(WORK_DIR)/install/$(INSTALL_PREFIX)/include/_pam_types.h $(WORK_DIR)/install/$(INSTALL_PREFIX)/include/security/
	cp $(WORK_DIR)/install/$(INSTALL_PREFIX)/include/_pam_compat.h $(WORK_DIR)/install/$(INSTALL_PREFIX)/include/security/

myPreCompile:
	cp $(HOSTCFGEN_NATIVE) $(HOSTCFGEN)
