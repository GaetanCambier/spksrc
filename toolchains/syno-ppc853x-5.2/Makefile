TC_NAME = syno-$(TC_ARCH)

TC_ARCH = ppc853x
TC_VERS = 5.2
TC_FIRMWARE = 5.0-4458

TC_DIST_NAME = 853x-gcc4374_eglibc2874_qoriq-GPL.txz

TC_EXT = txz
TC_DIST_SITE = http://sourceforge.net/projects/dsgpl/files/DSM%205.2%20Tool%20Chains/PowerPC%20853x%20Linux%202.6.32

TC_BASE_DIR = powerpc-none-linux-gnuspe
TC_PREFIX = powerpc-none-linux-gnuspe
TC_TARGET = powerpc-none-linux

TC_CFLAGS = -mtune=8548 -mhard-float -mfloat-gprs=double
TC_CPPFLAGS = -mtune=8548 -mhard-float -mfloat-gprs=double
TC_CXXFLAGS = -mtune=8548 -mhard-float -mfloat-gprs=double
TC_LDFLAGS = -L$(WORK_DIR)/$(TC_BASE_DIR)/$(TC_BASE_DIR)/libc/usr/lib

include ../../mk/spksrc.tc.mk
