#import <Preferences/Preferences.h>

@interface ReturnToCalmSettingsListController: PSListController {
}
@end

@implementation ReturnToCalmSettingsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"ReturnToCalmSettings" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
