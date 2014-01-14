#import <SpringBoard/SpringBoard.h>

NSUInteger rows = 6;
NSUInteger columns = 6;

%hook SBIconListView

+ (NSUInteger)iconRowsForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return rows;
}

+ (NSUInteger)maxVisibleIconRowsInterfaceOrientation:(UIInterfaceOrientation)orientation {
	return rows;
}

+ (NSUInteger)iconColumnsForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return columns;
}

%end

%hook SBFolderIconListView

+ (NSUInteger)iconColumnsForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return columns;
}

+ (NSUInteger)iconRowsForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return rows;
}

%end

%hook SBNewsstandIconListView

+ (NSUInteger)iconColumnsForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return columns;
}

+ (NSUInteger)iconRowsForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return rows;
}

%end

%hook SBAppSwitcherBarView

+ (NSUInteger)iconsPerPage:(NSInteger)page {
	return columns;
}

%end

void ADTSHLoadPrefs() {
	NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/ws.hbang.thatsamehack.plist"];
	rows = prefs[@"Rows"] ? ((NSNumber *)prefs[@"Rows"]).intValue : 5;
	columns = prefs[@"Columns"] ? ((NSNumber *)prefs[@"Columns"]).intValue : 5;
}

void ADTSHRespring() {
	[(SpringBoard *)[UIApplication sharedApplication] _relaunchSpringBoardNow];
}

%ctor {
	@autoreleasepool {
		ADTSHLoadPrefs();
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)ADTSHLoadPrefs, CFSTR("ws.hbang.thatsamehack/ReloadPrefs"), NULL, 0);
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)ADTSHRespring, CFSTR("ws.hbang.thatsamehack/Respring"), NULL, 0);
	}
}
