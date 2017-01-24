PKG_NAME = CGI
PKG_VERS = 4.35
PKG_EXT = tar.gz
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)
PKG_DIST_NAME = $(PKG_DIR).$(PKG_EXT)
PKG_DIST_SITE = http://search.cpan.org/CPAN/authors/id/L/LE/LEEJO
DEPENDS =

HOMEPAGE = http://search.cpan.org/dist/CGI/
COMMENT  = Handle Common Gateway Interface requests and responses
LICENSE  = GPL 1

CONFIGURE_TARGET = nop
COMPILE_TARGET = nop
INSTALL_TARGET = myInstall
GNU_CONFIGURE = 1

include ../../mk/spksrc.cross-cc.mk

.PHONY: myInstall
myInstall:
	$(RUN) mkdir -p $(STAGING_INSTALL_PREFIX)/share/perl_modules/
	$(RUN) cp -R lib/* $(STAGING_INSTALL_PREFIX)/share/perl_modules/

