@interface PSListController
{
	id _specifiers;
}
-(id)specifiers;
-(id)loadSpecifiersFromPlistName:(id)name target:(id)tar;
@end

@interface CecrecySettingsListController: PSListController {
}
@end

@implementation CecrecySettingsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"CecrecySettings" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
