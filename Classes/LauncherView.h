#import <Three20/Three20.h>

@interface LauncherView : TTViewController <TTLauncherViewDelegate, TTActionSheetControllerDelegate> {
	TTLauncherView* _launcherView;
}

-(void)restorePages:(BOOL)forceReset;
-(void)showActionSheet:(id)sender;

@end
