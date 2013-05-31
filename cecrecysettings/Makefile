include theos/makefiles/common.mk

BUNDLE_NAME = CecrecySettings
CecrecySettings_FILES = CecrecySettings.mm
CecrecySettings_INSTALL_PATH = /Library/PreferenceBundles
CecrecySettings_FRAMEWORKS = UIKit
CecrecySettings_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/CecrecySettings.plist$(ECHO_END)
