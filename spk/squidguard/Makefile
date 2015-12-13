SPK_NAME = squidguard
SPK_REV = 5
BETA = 1
SPK_ICON = src/squidguard.png
SPK_DEPENDS = "AntiVirus>1.2:Perl"

ifneq ($(findstring $(TCVERSION),3.1 4.0 4.1 4.2 4.3),)
$(error Sorry, this package does not support the $(ARCH)-$(TCVERSION) architecture.)
endif
ifneq ($(findstring $(TCVERSION),3.1 4.0 4.1 4.2 4.3),$(TCVERSION))
SPK_VERS = 4.0.3
DEPENDS = cross/busybox cross/squid cross/squidguard cross/squidguardmanager cross/squidclamav
CHANGELOG="\
1. Update to Squid 4.0.3<br>\
2. Update to Openssl 1.0.2e<br>\
3. Update to Busybox 1.24.1<br>\
4. Update to C_icap 0.4.2<br>\
5. Update to Libcap 2.24<br>\
6. Update to Openldap 2.4.43<br>\
7. Update to Squidclamav 6.14<br>\
8. Add TPROXY support for x64 platform<br>\
9. Fixe multiples minors bugs<br>\
"
endif
ifneq ($(findstring $(ARCH),avoton braswell bromolow cedarview x86 x64),$(ARCH))
SPK_VERS = 3.5.12
DEPENDS = cross/busybox cross/squid-3.5 cross/squidguard cross/squidguardmanager cross/squidclamav
CHANGELOG="\
1. Update to Squid 3.5.12<br>\
2. Update to Openssl 1.0.2e<br>\
3. Update to Busybox 1.24.1<br>\
4. Update to C_icap 0.4.2<br>\
5. Update to Libcap 2.24<br>\
6. Update to Openldap 2.4.43<br>\
7. Update to Squidclamav 6.14<br>\
8. Fixe multiples minors bugs<br>\
"
endif

INSTALL_DEP_SERVICES = "apache-web"
START_DEP_SERVICES = "apache-web"

MAINTAINER = Cambier Gaetan
DESCRIPTION = SquidGuard is a URL redirector used to use blacklists with the proxysoftware Squid. This package also includes SquidClamav for viruses protection and SquidGuard Manager.
DESCRIPTION_FRE = SquidGuard est un proxy HTTP, basé sur squid, qui permet de filtrer les accès selon une liste noire. Ce paquet contient également SquidClamav pour une protection antivirus et SquidGuard Manager.
RELOAD_UI = no
DISPLAY_NAME = SquidGuard

HOMEPAGE   = http://www.squidguard.org/
LICENSE    = GNU PL - Copyright © 1990,2007 Oracle.  All rights reserved for berkeley db library. See LICENSE file.

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh
FWPORTS          = src/${SPK_NAME}.sc

INSTALL_PREFIX = /usr/local/$(SPK_NAME)
POST_STRIP_TARGET = xz-compress

BUSYBOX_CONFIG = usrmng
ENV += BUSYBOX_CONFIG="$(BUSYBOX_CONFIG)"

include ../../mk/spksrc.spk.mk

.PHONY: xz-compress
xz-compress:
	install -m 755 -d $(STAGING_DIR)/etc
	install -m 755 -d $(STAGING_DIR)/libexec
	install -m 755 -d $(STAGING_DIR)/bin
	install -m 755 -d $(STAGING_DIR)/share/c_icap/templates/
	install -m 755 -d $(STAGING_DIR)/share/icons
	install -m 755 -d $(STAGING_DIR)/share/errors
	install -m 755 -d $(STAGING_DIR)/var/logs
	install -m 755 -d $(STAGING_DIR)/var/run/c-icap
	install -m 755 -d $(STAGING_DIR)/var/run/clamd
	install -m 755 -d $(STAGING_DIR)/var/cache
	install -m 755 -d $(STAGING_DIR)/var/db
	install -m 755 src/update_db.sh $(STAGING_DIR)/bin/
	install -m 750 src/logrotate.sh $(STAGING_DIR)/bin/
	install -m 755 src/etc/* $(STAGING_DIR)/etc/
	install -m 644 src/app/config $(STAGING_DIR)/share/www/squidguardmgr/
	install -m 755 src/app/squidGuard.cgi $(STAGING_DIR)/share/www/squidguardmgr/
	install -m 644 src/app/babel.* $(STAGING_DIR)/share/www/squidguardmgr/
	install -m 644 src/app/synocommunity.png $(STAGING_DIR)/share/www/squidguardmgr/
	install -m 644 src/app/blocked.gif $(STAGING_DIR)/share/www/squidguardmgr/
	for size in 16 24 32 48 72 ; \
	do \
	    convert $(SPK_ICON) -thumbnail $${size}x$${size} -transparent white \
	            $(STAGING_DIR)/share/www/squidguardmgr/images/icon$${size}.png ; \
	done	
	chmod 644 $(STAGING_DIR)/share/www/squidguardmgr/images/i*.png

