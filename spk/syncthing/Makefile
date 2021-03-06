SPK_NAME = syncthing
SPK_VERS = 0.12.8
SPK_REV = 7
SPK_ICON = src/syncthing.png
DSM_UI_DIR = app

UNSUPPORTED_ARCHS = $(PPC_ARCHES)

DEPENDS  = cross/busybox cross/$(SPK_NAME)

MAINTAINER = cytec
DESCRIPTION = Automatically sync files via secure, distributed technology.
DESCRIPTION_FRE = Synchronisation automatique de fichiers via une technologie sûre et distribuée.
ADMIN_PORT = 7070
RELOAD_UI = yes
DISPLAY_NAME = Syncthing
CHANGELOG = "Update to 0.12.8"

HOMEPAGE   = http://www.syncthing.net
LICENSE    = MPLv2.0

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh
FWPORTS          = src/${SPK_NAME}.sc

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

POST_STRIP_TARGET = syncthing_extra_install

BUSYBOX_CONFIG = usrmng daemon nice
ENV += BUSYBOX_CONFIG="$(BUSYBOX_CONFIG)"

ifneq ($(findstring $(ARCH),armada370 armadaxp armada375 armada38x alpine 88f5281 88f6281 comcerto2k evansport avoton bromolow cedarview x86 x64),$(ARCH))
$(error Unsupported ARCH $(ARCH))
endif

include ../../mk/spksrc.spk.mk

.PHONY: syncthing_extra_install
syncthing_extra_install:
	install -m 755 -d $(STAGING_DIR)/var
	install -m 600 src/config.xml $(STAGING_DIR)/var/config.xml
	install -m 755 -d $(STAGING_DIR)/app
	install -m 644 src/app/config $(STAGING_DIR)/app/config
	install -m 755 -d $(STAGING_DIR)/app/images
	for size in 16 24 32 48 72; do \
		convert $(SPK_ICON) -thumbnail $${size}x$${size} \
		        $(STAGING_DIR)/app/images/$(SPK_NAME)-$${size}.png ; \
	done
