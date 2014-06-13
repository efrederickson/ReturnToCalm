#import <UIKit/UIColor.h>

#define CALLBAR_LENIENCY 0.1
#define NEON_COLOR [UIColor colorWithRed:0.0862745 green:0.94902 blue:0.0862745 alpha:1]
#define RED_COLOR [UIColor colorWithRed:1 green:0 blue:0 alpha:1] // All other double-height status bar programs use this.

@interface UIColor (Private)
- (BOOL)_isSimilarToColor:(UIColor *)color withinPercentage:(CGFloat)percentage;
@end

BOOL enabled = YES;
int colorMode = 1;
UIColor *dynamicColor;

static void reloadSettings(CFNotificationCenterRef center,
                                    void *observer,
                                    CFStringRef name,
                                    const void *object,
                                    CFDictionaryRef userInfo)
{
    NSDictionary *prefs = [NSDictionary 
        dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.efrederickson.returntocalm.settings.plist"];
    
    if ([prefs objectForKey:@"enabled"] != nil)
        enabled = [[prefs objectForKey:@"enabled"] boolValue];
    else
        enabled = YES;
 
    if ([prefs objectForKey:@"color"] != nil)
        colorMode = [[prefs objectForKey:@"color"] intValue];
    else
        colorMode = 1;
}

UIColor *getCustomColor()
{
    if (colorMode == 0)
        return dynamicColor;
    if (colorMode == 1)
        return [UIColor blackColor];
    if (colorMode == 2)
        return [UIColor colorWithRed:76/255.0 green:217/255.0 blue:100/255.0 alpha:1.0];
    if (colorMode == 3)
        return [UIColor colorWithRed:0 green:191/255.0 blue:1 alpha: 1.0];
    if (colorMode == 4)
        return [UIColor colorWithRed:0.6 green:0.1 blue:0 alpha:1.0];
        
    return NEON_COLOR;
}

%hook UIStatusBarBackgroundView
- (id)initWithFrame:(CGRect)arg1 style:(id)arg2 backgroundColor:(UIColor *)arg3 {
    if (enabled && ([arg3 _isSimilarToColor:NEON_COLOR withinPercentage:CALLBAR_LENIENCY] || [arg3 _isSimilarToColor:RED_COLOR withinPercentage:CALLBAR_LENIENCY])) {
        return %orig(arg1, arg2, getCustomColor());
    }
    return %orig();
}

%end

%hook UIStatusBar
+ (id)statusBarTintColorForNavBarTintColor:(id)arg1
{
    dynamicColor =  %orig;
    return %orig;
}
%end

%ctor
{
     // Register for the preferences-did-change notification
    CFNotificationCenterRef r = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterAddObserver(r, NULL, &reloadSettings, CFSTR("com.efrederickson.returntocalm/reloadSettings"), NULL, 0);
    reloadSettings(nil, nil, nil, nil, nil);
}