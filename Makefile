ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:7.1:7.1
CFLAGS = -fobjc-arc

include theos/makefiles/common.mk

TWEAK_NAME = ReturnToCalm
ReturnToCalm_FILES = Tweak.xm
ReturnToCalm_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += returntocalmsettings
include $(THEOS_MAKE_PATH)/aggregate.mk
