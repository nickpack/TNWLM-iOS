//
//  iPhoneStreamingPlayerViewController.h
//  iPhoneStreamingPlayer
//
//  Created by Matt Gallagher on 28/10/08.
//  Copyright Matt Gallagher 2008. All rights reserved.
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

@class AudioStreamer, LevelMeterView;

@interface iPhoneStreamingPlayerViewController : UIViewController
{
	IBOutlet UIButton *button;
	IBOutlet UITextField *metadataArtist;
	IBOutlet UITextField *metadataTitle;
	IBOutlet UITextField *metadataAlbum;
	NSTimer *levelMeterUpdateTimer;
	TTImageView *imageView;
	LevelMeterView *levelMeterView;
	CommonData *commonData;
}
@property (nonatomic,retain) TTImageView* imageView;

- (IBAction)buttonPressed:(id)sender;
- (void)spinButton;

@end

