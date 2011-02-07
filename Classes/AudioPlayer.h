//  TNWLM2
//
//  Created by Nick Pack on 23/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//
//  Initial version created by Matt Gallagher on 28/10/08.
//  Large parts copyright Matt Gallagher 2008. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>
#import "NPStyles.h"
#import "CommonData.h"
#import <TapkuLibrary/TapkuLibrary.h>

@class AudioStreamer, LevelMeterView;

@interface AudioPlayer : UIViewController
{
	TKLoadingView *loading;
	IBOutlet UIButton *button;
	NSTimer *levelMeterUpdateTimer;
	TTImageView *imageView;
	LevelMeterView *levelMeterView;
	CommonData *commonData;
}
@property (nonatomic,retain) TTImageView* imageView;
@property (readonly) TKLoadingView *loading;

- (IBAction)buttonPressed:(id)sender;
- (void)spinButton;
- (TKLoadingView *) loading;

@end

