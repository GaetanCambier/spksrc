PKG_NAME = squid
PKG_VERS = 3.5.21
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = http://www.squid-cache.org/Versions/v3/3.5/
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

DEPENDS_BASE = cross/linux-pam cross/openssl cross/openldap native/$(PKG_NAME)

ifneq (,$(findstring $(ARCH),avoton braswell bromolow cedarview x86 x64))
	DEPENDS = cross/libcap2 $(DEPENDS_BASE)    
else
	DEPENDS = $(DEPENDS_BASE)    
endif

HOMEPAGE = http://www.squid-cache.org/
COMMENT  = Squid is a fully-featured HTTP/1.0 proxy which is almost HTTP/1.1 compliant.
LICENSE  = 

GNU_CONFIGURE = 1

CONFIGURE_ARGS  = --enable-linux-netfilter --with-openssl --enable-ssl-crtd --disable-arch-native --disable-external-acl-helpers squid_cv_gnu_atomics=no

HOSTCFGEN_NATIVE = $(WORK_DIR)/../../../native/$(PKG_NAME)/work-native/$(PKG_DIR)/src/cf_gen
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
