PKG_NAME = openssl
PKG_VERS = 1.0.2i
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = ftp://ftp.openssl.org/source
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

DEPENDS = 

HOMEPAGE = http://www.openssl.org
COMMENT  = Compression Library
LICENSE  = http://www.openssl.org/source/license.html

CONFIGURE_TARGET = myConfigure

INSTALL_TARGET = myInstall

STAGING_INSTALL_PREFIX := $(INSTALL_DIR)

include ../../mk/spksrc.cross-cc.mk

PATCHES = 
ifneq ($(findstring $(ARCH), avoton braswell bromolow cedarview x86 x64),)
OPENSSL_ARCH = linux-x86_64
EC_NIST=enable-ec_nistp_64_gcc_128
PATCHES = $(sort $(wildcard patches/openssl__chacha20_poly1305*.patch))
endif
ifneq ($(findstring $(ARCH), evansport),)
OPENSSL_ARCH = linux-generic32
endif
ifneq ($(findstring $(ARCH), 88f6281 alpine armada370 armada375 armada38x armadaxp comcerto2k monaco ),)
OPENSSL_ARCH = linux-armv4
endif
ifneq ($(findstring $(ARCH), powerpc ppc853x qoriq),)
OPENSSL_ARCH = linux-ppc
endif

.PHONY: myConfigure
myConfigure:
	$(RUN) ./Configure --openssldir=$(INSTALL_PREFIX) $(OPENSSL_ARCH) shared threads no-ssl2 $(EC_NIST)

.PHONY: myInstall
myInstall:
	$(RUN) $(MAKE) install_sw INSTALL_PREFIX=$(INSTALL_DIR)
