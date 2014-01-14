include theos/makefiles/common.mk

TWEAK_NAME = ThatSameHack
ThatSameHack_FILES = Tweak.xm
ThatSameHack_FRAMEWORKS = UIKit

SUBPROJECTS = prefs

include $(THEOS_MAKE_PATH)/aggregate.mk
include $(THEOS_MAKE_PATH)/tweak.mk
