PKG_NAME = flex
PKG_VERS = 2.6.3
PKG_EXT = tar.gz
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)
PKG_DIST_NAME = $(PKG_DIR).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/westes/flex/releases/download/v$(PKG_VERS)

DEPENDS =

HOMEPAGE = http://flex.sourceforge.net/
COMMENT  = Flex is a tool for generating scanners
LICENSE  =

GNU_CONFIGURE = 1

CONFIGURE_ARGS = --disable-bootstrap

include ../../mk/spksrc.cross-cc.mk

