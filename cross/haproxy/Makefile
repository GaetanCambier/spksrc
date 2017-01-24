PKG_NAME = haproxy
PKG_VERS = 1.7.1
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = http://www.haproxy.org/download/1.7/src
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)


HOMEPAGE   = http://www.haproxy.org
COMMENT    = HAProxy is a free, very fast and reliable solution offering high availability, load balancing, and proxying for TCP and HTTP-based applications.
LICENSE    = GNU GPL 2

CPU_AFFINITY=generic
TARGET_AFFINITY=generic
USE_PCRE_AFFINITY=
USE_PCRE_JIT_AFFINITY=
DEPENDS_cross_pcre=
ifeq ($(findstring $(ARCH),88f6281 alpine armada370 armada375 armadaxp comcerto2k monaco),$(ARCH))
CPU_AFFINITY=ARM
TARGET_AFFINITY=linux2628
endif
ifeq ($(findstring $(ARCH),avoton braswell bromolow cedarview x86 x64),$(ARCH))
CPU_AFFINITY=x86_64
TARGET_AFFINITY=linux2628
DEPENDS_cross_pcre=cross/pcre
USE_PCRE_AFFINITY="USE_PCRE=1"
USE_PCRE_JIT_AFFINITY="USE_PCRE_JIT=1"
endif
ifeq (evansport,$(ARCH))
CPU_AFFINITY=i686
TARGET_AFFINITY=linux2628
endif

DEPENDS = cross/openssl cross/zlib $(DEPENDS_cross_pcre)

CONFIGURE_TARGET = nop
COMPILE_TARGET = myCompile
INSTALL_TARGET = myInstall
OFLAG=-O3

include ../../mk/spksrc.cross-cc.mk

.PHONY: myCompile
myCompile: 
	$(RUN) $(MAKE) TARGET=$(TARGET_AFFINITY) CPU=$(CPU_AFFINITY) USE_OPENSSL=1 USE_TPROXY=1 USE_PTHREAD=1_PSHARED USE_ZLIB=1 USE_FUTEX=1 DEBUG=-s $(USE_PCRE_AFFINITY) $(USE_PCRE_JIT_AFFINITY) SPKSRC_CFLAGS="$(CFLAGS) $(OFLAG)" SPKSRC_LDFLAGS="$(LDFLAGS)"

myInstall:
	$(RUN) $(MAKE) install DESTDIR=$(INSTALL_DIR) PREFIX=$(INSTALL_PREFIX)
