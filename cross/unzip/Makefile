PKG_NAME = unzip
PKG_VERS = 60
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = http://downloads.sourceforge.net/infozip
PKG_DIR = $(PKG_NAME)$(PKG_VERS)

DEPENDS =

HOMEPAGE = http://infozip.sourceforge.net/
COMMENT  = UnZip is an extraction utility for archives compressed in .zip format (also called "zipfiles").

CONFIGURE_TARGET = nope
COMPILE_TARGET = myCompile
INSTALL_TARGET = myInstall
GNU_CONFIGURE = 1

include ../../mk/spksrc.cross-cc.mk

.PHONY: myCompile
myCompile:
	$(RUN) $(MAKE) -f unix/Makefile generic CC="$(TC_PATH)$(TC_PREFIX)gcc \$$(ALLFLAGS) $(OFLAG)" CXX="$(TC_PATH)$(TC_PREFIX)g++ \$$(ALLFLAGS) $(OFLAG)" CPPFLAGS="$(CPPFLAGS)" LDFLAGS="$(LDFLAGS)"

.PHONY: myInstall
myInstall:
	$(RUN) mkdir -p $(INSTALL_DIR)/$(INSTALL_PREFIX)/bin/
	$(RUN) cp unzip $(INSTALL_DIR)/$(INSTALL_PREFIX)/bin/
	$(RUN) cp funzip $(INSTALL_DIR)/$(INSTALL_PREFIX)/bin/
	$(RUN) cp unzipsfx $(INSTALL_DIR)/$(INSTALL_PREFIX)/bin/
