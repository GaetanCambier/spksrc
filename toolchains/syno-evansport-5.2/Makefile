TC_NAME = syno-$(TC_ARCH)

TC_ARCH = evansport
TC_VERS = 5.2
TC_FIRMWARE = 5.0-4458

TC_DIST_NAME = evansport-gcc463_glibc213_i686_patched-GPL.txz

TC_EXT = txz
TC_DIST_SITE = http://sourceforge.net/projects/dsgpl/files/DSM%205.2%20Tool%20Chains/Intel%20x86%20Linux%203.2.40%20%28Evansport%29

TC_BASE_DIR = i686-pc-linux-gnu
TC_PREFIX = i686-pc-linux-gnu
TC_TARGET = i686-pc-linux-gnu

TC_CFLAGS =
TC_CPPFLAGS =
TC_CXXFLAGS =
TC_LDFLAGS = -L$(WORK_DIR)/$(TC_BASE_DIR)/$(TC_BASE_DIR)/sys-root/usr/lib

FIX_TARGET = myFix

include ../../mk/spksrc.tc.mk

.PHONY: myFix
myFix:
	chmod -R u+w $(WORK_DIR)
	@find $(WORK_DIR)/$(TC_BASE_DIR) -type f -name '*.la' -exec sed -i -e "s|^libdir=.*$$|libdir='$(WORK_DIR)/$(TC_BASE_DIR)/$(TC_BASE_DIR)/lib'|" {} \;
