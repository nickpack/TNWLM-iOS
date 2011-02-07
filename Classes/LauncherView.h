//  TNWLM2
//
//  Created by Nick Pack on 23/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import <Three20/Three20.h>

@interface LauncherView : TTViewController <TTLauncherViewDelegate, TTActionSheetControllerDelegate> {
	TTLauncherView* _launcherView;
}

-(void)restorePages:(BOOL)forceReset;
-(void)showActionSheet:(id)sender;

@end
