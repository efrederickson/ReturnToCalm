#import <Preferences/Preferences.h>

@interface PSListController (RTC)
-(UIView*)view;
-(UINavigationController*)navigationController;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
@end

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

- (void)viewWillAppear:(BOOL)animated {
    self.view.tintColor = [UIColor orangeColor];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];

    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    
    self.view.tintColor = nil;
    self.navigationController.navigationBar.tintColor = nil;
}

@end

@interface RTCListItemsController : PSListItemsController
@end

@implementation RTCListItemsController
- (void)viewWillAppear:(BOOL)animated {
    self.view.tintColor = [UIColor orangeColor];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    
    self.view.tintColor = nil;
    self.navigationController.navigationBar.tintColor = nil;
}
@end