#import <Three20/Three20.h>

@interface LauncherView : TTViewController <TTLauncherViewDelegate> {
	TTLauncherView* _launcherView;
}

- (void)restorePages;

@end
