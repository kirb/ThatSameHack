#import <Preferences/Preferences.h>

@interface ThatSameHackListController: PSListController{}
@end
@implementation ThatSameHackListController
-(id)specifiers{
	if(_specifiers==nil){
		_specifiers=[[self loadSpecifiersFromPlistName:@"ThatSameHack" target:self]retain];
	}
	return _specifiers;
}
-(void)tshrespring:(id)param{
	system("killall SpringBoard");
}
@end