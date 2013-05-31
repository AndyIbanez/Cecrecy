ARCHS = armv7
include theos/makefiles/common.mk

BUNDLE_NAME = Cecrecy
Cecrecy_FILES = Cecrecy.mm
Cecrecy_INSTALL_PATH = /Library/Cecrecy
Cecrecy_FRAMEWORKS = Foundation
SUBPROJECTS += cecrecysettings
include $(THEOS_MAKE_PATH)/aggregate.mk
include $(THEOS_MAKE_PATH)/bundle.mk