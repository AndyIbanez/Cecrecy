#import <Foundation/Foundation.h>
#import "libhide_functions.mm"

@interface Cecrecy : NSObject
{
}
-(void)hideIcons;
-(void)showIcons;
@end

@implementation Cecrecy
-(void)hideIcons
{
	NSDictionary *appsToHide = [NSDictionary dictionaryWithContentsOfFile: 
								[NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"com.andyibanez.Cecrecy.HiddenApps.plist"]];
	[appsToHide enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
	{
		NSString *sKey = (NSString *)key;
		if([obj boolValue] == YES)
		{
			HideIconViaDisplayId(sKey);
		}
		
	}];
}
-(void)showIcons
{
	NSDictionary *appsToShow = [NSDictionary dictionaryWithContentsOfFile: 
								[NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"com.andyibanez.Cecrecy.HiddenApps.plist"]];
	[appsToShow enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
	{
		NSString *sKey = (NSString *)key;
		if([obj boolValue] == YES)
		{
			UnHideIconViaDisplayId(sKey);
		}
	}];
}
@end