PKG_NAME = squid
PKG_VERS = 4.0.3
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = http://www.squid-cache.org/Versions/v4
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

ifneq ($(findstring $(ARCH),avoton braswell bromolow cedarview x86 x64),$(ARCH))
$(error Sorry, this package does not support the $(ARCH) architecture.)
endif

DEPENDS = cross/libcap2 cross/linux-pam cross/openssl cross/openldap native/$(PKG_NAME)

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
