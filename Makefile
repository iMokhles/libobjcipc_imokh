export THEOS_DEVICE_IP=127.0.0.1
export THEOS_DEVICE_PORT=2222

export TARGET = :clang
export ARCHS = armv7 armv7s arm64
TARGET_IPHONEOS_DEPLOYMENT_VERSION = 7.0
export ADDITIONAL_OBJCFLAGS = -fvisibility=default -fvisibility-inlines-hidden -fno-objc-arc -O2

#DEBUG=1

LIBRARY_NAME = libobjcipc_imokh
libobjcipc_imokh_FILES = IPC.m Connection.m Message.m
libobjcipc_imokh_FRAMEWORKS = CoreFoundation Foundation UIKit
libobjcipc_imokh_INSTALL_PATH = /usr/lib/
libobjcipc_imokh_LIBRARIES = substrate

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/library.mk

after-stage::
	$(ECHO_NOTHING)echo " link dylib"$(ECHO_END)
	$(ECHO_NOTHING)sudo ln -s $(THEOS_STAGING_DIR)/usr/lib/libobjcipc_imokh.dylib $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries/libobjcipc_imokh.dylib $(ECHO_END)
	$(ECHO_NOTHING)echo " dylib linked"$(ECHO_END)
	$(ECHO_NOTHING)echo " Installing Library"$(ECHO_END)
	$(ECHO_NOTHING)sudo cp  $(THEOS_STAGING_DIR)/usr/lib/libobjcipc_imokh.dylib /opt/theos/lib$(ECHO_END)
	$(ECHO_NOTHING)sudo mkdir -p /opt/theos/include/libobjcipc/ $(ECHO_END)
	$(ECHO_NOTHING)sudo cp header.h /opt/theos/include/libobjcipc/ $(ECHO_END)
	$(ECHO_NOTHING)sudo cp Connection.h /opt/theos/include/libobjcipc/ $(ECHO_END)
	$(ECHO_NOTHING)sudo cp IPC.h /opt/theos/include/libobjcipc/ $(ECHO_END)
	$(ECHO_NOTHING)sudo cp Message.h /opt/theos/include/libobjcipc/ $(ECHO_END)


after-install::
	install.exec "killall -9 backboardd"