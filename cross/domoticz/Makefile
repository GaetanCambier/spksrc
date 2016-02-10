PKG_NAME = domoticz
PKG_VERS = fa67272d1edad74dfa344148c159a60e3c93e4c9
PKG_EXT = zip
PKG_DIST_NAME = $(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/domoticz/domoticz/archive
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

DEPENDS = cross/boost cross/sqlite cross/curl

HOMEPAGE = http://www.domoticz.com/
COMMENT  = Domoticz is a Home Automation System
LICENSE  = 

CONFIGURE_TARGET = myConfigure
INSTALL_TARGET = myInstall

BOOST_LIBRARIES = system thread date_time
ENV += BOOST_LIBRARIES="$(BOOST_LIBRARIES)" CMAKE_INCLUDE_PATH="$(STAGING_INSTALL_PREFIX)/include" CMAKE_LIBRARY_PATH="$(STAGING_INSTALL_PREFIX)/lib" PCH_COMPILE_FLAGS="$(CFLAGS)"

include ../../mk/spksrc.cross-cc.mk

.PHONY: myConfigure
myConfigure:
	$(RUN) cmake CMakeLists.txt

.PHONY: myInstall
myInstall:
	@mkdir -p $(STAGING_INSTALL_PREFIX)/bin
	@$(RUN) install -m 755 domoticz $(STAGING_INSTALL_PREFIX)/bin
	@$(RUN) cp -R www $(STAGING_INSTALL_PREFIX)
	@$(RUN) cp -R Config $(STAGING_INSTALL_PREFIX)
	@$(RUN) cp -R scripts $(STAGING_INSTALL_PREFIX)
	@mkdir -p $(STAGING_INSTALL_PREFIX)/var
