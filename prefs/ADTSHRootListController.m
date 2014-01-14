#import "ADTSHRootListController.h"
#import <notify.h>

@implementation ADTSHRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"ThatSameHack" target:self] retain];
	}

	return _specifiers;
}

- (void)respring {
	notify_post("ws.hbang.thatsamehack/Respring");
}

@end
