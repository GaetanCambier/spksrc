TC_NAME = syno-alpine

TC_ARCH = alpine alpine4k
TC_VERS = 5.2
TC_FIRMWARE = 5.1-5004

TC_DIST_NAME = alpine-gcc464_glibc217_alpine-GPL.txz

TC_EXT = txz
TC_DIST_SITE = http://sourceforge.net/projects/dsgpl/files/DSM%205.2%20Tool%20Chains/Annapurna%20Alpine%20Linux%203.2.40

TC_BASE_DIR = arm-cortex_a15-linux-gnueabi
TC_PREFIX = arm-cortex_a15-linux-gnueabi
TC_TARGET = arm-cortex_a15-linux-gnueabi

TC_CFLAGS = -I$(WORK_DIR)/$(TC_BASE_DIR)/$(TC_BASE_DIR)/sysroot/usr/include -mfloat-abi=hard -mtune=cortex-a15 -mfpu=neon-vfpv4 -mthumb
TC_CPPFLAGS = -I$(WORK_DIR)/$(TC_BASE_DIR)/$(TC_BASE_DIR)/sysroot/usr/include -mfloat-abi=hard -mtune=cortex-a15 -mfpu=neon-vfpv4 -mthumb
TC_CXXFLAGS = -I$(WORK_DIR)/$(TC_BASE_DIR)/$(TC_BASE_DIR)/sysroot/usr/include -mfloat-abi=hard -mtune=cortex-a15 -mfpu=neon-vfpv4 -mthumb
TC_LDFLAGS = -L$(WORK_DIR)/$(TC_BASE_DIR)/$(TC_BASE_DIR)/sysroot/lib -L$(WORK_DIR)/$(TC_BASE_DIR)/$(TC_BASE_DIR)/sysroot/usr/lib -mfloat-abi=hard -mtune=cortex-a15 -mfpu=neon-vfpv4 -mthumb

FIX_TARGET = myFix

include ../../mk/spksrc.tc.mk

.PHONY: myFix
myFix:
	chmod -R u+w $(WORK_DIR)
	@find $(WORK_DIR)/$(TC_BASE_DIR) -type f -name '*.la' -exec sed -i -e "s|^libdir=.*$$|libdir='$(WORK_DIR)/$(TC_BASE_DIR)/$(TC_BASE_DIR)/lib'|" {} \;
