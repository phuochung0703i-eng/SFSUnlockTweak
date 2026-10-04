TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e
include $(THEOS)/makefiles/common.mk
TWEAK_NAME = SFSUnlock
SFSUnlock_FILES = Tweak.xm
SFSUnlock_CFLAGS = -fobjc-arc
include $(THEOS_MAKE_PATH)/tweak.mk
