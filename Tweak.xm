#import <CoreFoundation/CFNotificationCenter.h>

#define prefpath @"/var/mobile/Library/Preferences/ws.hbang.thatsamehack.plist"
static int rows=6;
static int cols=6;

%hook SBIconListView
+(unsigned)iconRowsForInterfaceOrientation:(int)interfaceOrientation{return rows;}
+(unsigned)maxVisibleIconRowsInterfaceOrientation:(int)orientation{return cols;}
+(unsigned)iconColumnsForInterfaceOrientation:(int)interfaceOrientation{return cols;}
//-(unsigned)iconRowsForCurrentOrientation{return rows;}
//-(unsigned)iconColumnsForCurrentOrientation{return cols;}
%end
/*icons glitch up, so temporarily disabled
%hook SBDockIconListView
+(unsigned)iconColumnsForInterfaceOrientation:(int)interfaceOrientation{return cols;}
+(unsigned)iconRowsForInterfaceOrientation:(int)interfaceOrientation{return rows;}
%end*/
%hook SBFolderIconListView
+(unsigned)iconColumnsForInterfaceOrientation:(int)interfaceOrientation{return cols;}
+(unsigned)iconRowsForInterfaceOrientation:(int)interfaceOrientation{return rows;}
%end
%hook SBNewsstandIconListView
+(unsigned)iconColumnsForInterfaceOrientation:(int)interfaceOrientation{return cols;}
+(unsigned)iconRowsForInterfaceOrientation:(int)interfaceOrientation{return rows;}
%end
%hook SBAppSwitcherBarView
+(unsigned)iconsPerPage:(int)page{return rows;}
%end

static void ADTSHPrefsLoad(){
    NSDictionary *prefs;
    if([[NSFileManager defaultManager]fileExistsAtPath:prefpath]){
        prefs=[[NSDictionary alloc]initWithContentsOfFile:prefpath];
        if(!prefs) return;
        rows=[[prefs objectForKey:@"Rows"]intValue];
        if(!rows) rows=5;
        cols=[[prefs objectForKey:@"Columns"]intValue];
        if(!cols) cols=10;
    }else{
        prefs=[[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:6],@"Rows",[NSNumber numberWithInt:6],@"Columns",nil];
        [prefs writeToFile:prefpath atomically:YES];
    }
    [prefs release];
}

static void ADTSHPrefsUpdate(CFNotificationCenterRef center,void *observer,CFStringRef name,const void *object,CFDictionaryRef userInfo){
    ADTSHPrefsLoad();
}
%ctor{
    NSAutoreleasePool *p=[[NSAutoreleasePool alloc]init];
    ADTSHPrefsLoad();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),NULL,&ADTSHPrefsUpdate,CFSTR("ws.hbang.thatsamehack/ReloadPrefs"),NULL,0);
    %init;
    [p drain];
}
