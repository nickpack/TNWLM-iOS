//  TNWLM2
//
//  Created by Nick Pack on 23/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import "AppDelegate.h"
#import "AudioPlayer.h"
#import "AudioStreamer.h"
#import "LevelMeterView.h"
#import "RegexKitLite.h"
#import <QuartzCore/CoreAnimation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CFNetwork/CFNetwork.h>
#import "CommonData.h"
#import <Three20/Three20.h>
#import <Three20UI/UIViewAdditions.h>

@implementation AudioPlayer

@synthesize imageView;
//
// setButtonImage:
//
// Used to change the image on the playbutton. This method exists for
// the purpose of inter-thread invocation because
// the observeValueForKeyPath:ofObject:change:context: method is invoked
// from secondary threads and UI updates are only permitted on the main thread.
//
// Parameters:
//    image - the image to set on the play button.
//
- (void)setButtonImage:(UIImage *)image
{

	[button.layer removeAllAnimations];

	if (!image)
	{
		[button setImage:[UIImage imageNamed:@"playbutton.png"] forState:0];
	}
	else
	{
		[button setImage:image forState:0];

		if ([button.currentImage isEqual:[UIImage imageNamed:@"loadingbutton.png"]])
		{
			[self.view addSubview:self.loading];
			[self spinButton];
		} else {
			[self.loading removeFromSuperview];
		}
	}
}

//
// destroyStreamer
//
// Removes the streamer, the UI update timer and the change notification
//
- (void)destroyStreamer
{
	if (commonData.streamer)
	{
		[[NSNotificationCenter defaultCenter]
			removeObserver:self
			name:ASStatusChangedNotification
			object:commonData.streamer];

		[commonData.streamer stop];
		[commonData.streamer release];
		commonData.streamer = nil;
	}
}

//
// createStreamer
//
// Creates or recreates the AudioStreamer object.
//
- (void)createStreamer
{

	if (commonData.streamer)
	{
		return;
	}

	[self destroyStreamer];

	commonData.streamUrl = [NSURL URLWithString:@"http://app.thenursewholovedme.com:9000"];
	commonData.streamer = [[AudioStreamer alloc] initWithURL:commonData.streamUrl];
	levelMeterUpdateTimer =
	[NSTimer
			scheduledTimerWithTimeInterval:.1
			target:self
			selector:@selector(updateLevelMeters:)
			userInfo:nil
			repeats:YES];
	[[NSNotificationCenter defaultCenter]
		addObserver:self
		selector:@selector(playbackStateChanged:)
		name:ASStatusChangedNotification
		object:commonData.streamer];
#ifdef SHOUTCAST_METADATA
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(metadataChanged:)
	 name:ASUpdateMetadataNotification
	 object:commonData.streamer];
#endif
}

//
// viewDidLoad
//
// Creates the volume slider, sets the default path for the local file and
// creates the streamer immediately if we already have a file at the local
// location.
//
- (void)viewDidLoad
{
	[super viewDidLoad];
	[[TTURLRequestQueue mainQueue] setMaxContentLength:500000];

	// Hacky work around for TTStyleSheet not loading if UIViewController is the first view shown
	self.navigationController.navigationBar.tintColor =	RGBCOLOR(44, 44, 44);
	// End hacky workaround

	commonData = [CommonData sharedCommonData];

	levelMeterView = [[LevelMeterView alloc] initWithFrame:CGRectMake(0, 362.0, self.view.width, 60.0)];
	[self.view addSubview:levelMeterView];

	UIView *btn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];

	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 200, 16)];
	label.tag = 1;
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:14];
	label.adjustsFontSizeToFitWidth = NO;
	label.textAlignment = UITextAlignmentCenter;
	label.textColor = [UIColor whiteColor];
	label.text = @"Listen";
	label.highlightedTextColor = [UIColor whiteColor];
	label.shadowColor = [UIColor blackColor];
	label.shadowOffset = CGSizeMake(0,1);

	UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 200, 16)];
	label2.tag = 2;
	label2.backgroundColor = [UIColor clearColor];
	label2.font = [UIFont boldSystemFontOfSize:10];
	label2.adjustsFontSizeToFitWidth = NO;
	label2.textAlignment = UITextAlignmentCenter;
	label2.textColor = [UIColor grayColor];
	label2.text = @"The Nurse Who Loved Me";
	label2.highlightedTextColor = [UIColor lightGrayColor];
	label2.shadowColor = [UIColor blackColor];
	label2.shadowOffset = CGSizeMake(0,1);

	if ([commonData.streamer isPlaying]) {
		levelMeterUpdateTimer =
		[NSTimer
		 scheduledTimerWithTimeInterval:.1
		 target:self
		 selector:@selector(updateLevelMeters:)
		 userInfo:nil
		 repeats:YES];
		[[NSNotificationCenter defaultCenter]
		 addObserver:self
		 selector:@selector(playbackStateChanged:)
		 name:ASStatusChangedNotification
		 object:commonData.streamer];

		[[NSNotificationCenter defaultCenter]
		 addObserver:self
		 selector:@selector(metadataChanged:)
		 name:ASUpdateMetadataNotification
		 object:commonData.streamer];

		label.text = commonData.currentTrack;
		label2.text = commonData.currentAlbum;
		imageView = [[[TTImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width)]
					 autorelease];
		imageView.urlPath = commonData.currentArt;
		[self.view addSubview:imageView];
		[self setButtonImage:[UIImage imageNamed:@"stopbutton.png"]];
	} else {
		[self createStreamer];
		[self setButtonImage:[UIImage imageNamed:@"loadingbutton.png"]];
		[commonData.streamer start];
	}

	[btn addSubview:label];
	[label release];
	[btn addSubview:label2];
	[label2 release];
	self.navigationItem.titleView = btn;
}

- (void)viewDidAppear:(BOOL)animated {
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	appDelegate.uiIsVisible = YES;
	[super viewDidAppear:animated];
	[[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
	[self becomeFirstResponder]; // this enables listening for events
	// update the UI in case we were in the background
	NSNotification *notification =
	[NSNotification
	 notificationWithName:ASStatusChangedNotification
	 object:self];
	[[NSNotificationCenter defaultCenter]
	 postNotification:notification];
}

- (BOOL)canBecomeFirstResponder {
	return YES;
}

//
// spinButton
//
// Shows the spin button when the audio is loading. This is largely irrelevant
// now that the audio is loaded from a local file.
//
- (void)spinButton
{
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
	CGRect frame = [button frame];
	button.layer.anchorPoint = CGPointMake(0.5, 0.5);
	button.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
	[CATransaction commit];

	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
	[CATransaction setValue:[NSNumber numberWithFloat:2.0] forKey:kCATransactionAnimationDuration];

	CABasicAnimation *animation;
	animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	animation.fromValue = [NSNumber numberWithFloat:0.0];
	animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
	animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
	animation.delegate = self;
	[button.layer addAnimation:animation forKey:@"rotationAnimation"];

	[CATransaction commit];
}

//
// animationDidStop:finished:
//
// Restarts the spin animation on the button when it ends. Again, this is
// largely irrelevant now that the audio is loaded from a local file.
//
// Parameters:
//    theAnimation - the animation that rotated the button.
//    finished - is the animation finised?
//
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)finished
{
	if (finished)
	{
		[self spinButton];
	}
}

//
// buttonPressed:
//
// Handles the play/stop button. Creates, observes and starts the
// audio streamer when it is a play button. Stops the audio streamer when
// it isn't.
//
// Parameters:
//    sender - normally, the play/stop button.
//
- (IBAction)buttonPressed:(id)sender
{
	if ([button.currentImage isEqual:[UIImage imageNamed:@"playbutton.png"]])
	{
		[self createStreamer];
		[self setButtonImage:[UIImage imageNamed:@"loadingbutton.png"]];
		[commonData.streamer start];
	}
	else
	{
		[commonData.streamer stop];
		[self setButtonImage:[UIImage imageNamed:@"playbutton.png"]];
	}
}


//
// playbackStateChanged:
//
// Invoked when the AudioStreamer
// reports that its playback status has changed.
//
- (void)playbackStateChanged:(NSNotification *)aNotification
{
	if ([commonData.streamer isWaiting])
	{
		[levelMeterView updateMeterWithLeftValue:0.0
									  rightValue:0.0];
		[commonData.streamer setMeteringEnabled:NO];
		[self setButtonImage:[UIImage imageNamed:@"loadingbutton.png"]];
	}
	else if ([commonData.streamer isPlaying])
	{
		[commonData.streamer setMeteringEnabled:YES];
		[self setButtonImage:[UIImage imageNamed:@"stopbutton.png"]];
	}
	else if ([commonData.streamer isIdle])
	{
		[levelMeterView updateMeterWithLeftValue:0.0
									  rightValue:0.0];
		[self destroyStreamer];
		[self setButtonImage:[UIImage imageNamed:@"playbutton.png"]];
	}
}

/** Example metadata
 *
 StreamTitle='Kim Sozzi / Amuka / Livvi Franc - Secret Love / It's Over / Automatik',
 StreamUrl='&artist=Kim%20Sozzi%20%2F%20Amuka%20%2F%20Livvi%20Franc&title=Secret%20Love%20%2F%20It%27s%20Over%20%2F%20Automatik&album=&duration=1133453&songtype=S&overlay=no&buycd=&website=&picture=',

 Format is generally "Artist hypen Title" although servers may deliver only one. This code assumes 1 field is artist.
 */
- (void)metadataChanged:(NSNotification *)aNotification
{
	NSString *streamTitle;
	NSString *streamAlbum;
	NSArray *metaParts = [[[aNotification userInfo] objectForKey:@"metadata"] componentsSeparatedByString:@";"];
	NSString *item;
	NSMutableDictionary *hash = [[[NSMutableDictionary alloc] init] autorelease];
	for (item in metaParts) {
		// split the key/value pair
		NSArray *pair = [item componentsSeparatedByString:@"="];
		// don't bother with bad metadata
		if ([pair count] == 2)
			[hash setObject:[pair objectAtIndex:1] forKey:[pair objectAtIndex:0]];
	}

	NSString *streamString = [[hash objectForKey:@"StreamTitle"] stringByReplacingOccurrencesOfString:@"'" withString:@""];
	NSArray *streamParts = [streamString componentsSeparatedByString:@" - "];

	if ([streamParts count] >= 2) {
		streamTitle = [streamParts objectAtIndex:1];
		if ([streamParts count] >= 3) {
			streamAlbum = [streamParts objectAtIndex:2];
		} else {
			streamAlbum = @"";
		}
	} else {
		streamTitle = @"";
		streamAlbum = @"";
	}

	streamParts = nil;
	[streamParts release];

	AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	if (appDelegate.uiIsVisible) {
		UILabel *headerTrack = (UILabel*)[self.navigationItem.titleView viewWithTag:1];
		UILabel *headerAlbum = (UILabel*)[self.navigationItem.titleView viewWithTag:2];
		NSString *albumArt = [streamAlbum stringByReplacingOccurrencesOfRegex:@"\\W+"
																   withString:@""];
		NSString *albumArtName = [albumArt lowercaseString];
		NSString *albumArtUrl = [NSString stringWithFormat:@"http://app.thenursewholovedme.com/audio/%@.jpg", albumArtName];

		if (imageView == nil) {
			imageView = [[[TTImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width)] autorelease];
			imageView.defaultImage = [UIImage imageNamed:@"musicplaceholder.png"];
			imageView.urlPath = albumArtUrl;
			[self.view addSubview:imageView];
		} else {
			imageView.urlPath = albumArtUrl;
		}

		headerTrack.text = [NSString stringWithFormat:@"%@", streamTitle];
		headerAlbum.text = [NSString stringWithFormat:@"%@",streamAlbum];
		commonData.currentTrack = [NSString stringWithFormat:@"%@", streamTitle];
		commonData.currentAlbum = [NSString stringWithFormat:@"%@",streamAlbum];
		commonData.currentArt = albumArtUrl;
	}
}

//
// updateLevelMeters:
//

- (void)updateLevelMeters:(NSTimer *)timer {
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	if([commonData.streamer isMeteringEnabled] && appDelegate.uiIsVisible) {
		[levelMeterView updateMeterWithLeftValue:[commonData.streamer averagePowerForChannel:0]
									  rightValue:[commonData.streamer averagePowerForChannel:1]];
	}
}


//
// dealloc
//
// Releases instance memory.
//
- (void)dealloc
{
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	appDelegate.uiIsVisible = NO;
	[[NSNotificationCenter defaultCenter]
	 removeObserver:self
	 name:ASStatusChangedNotification
	 object:commonData.streamer];

	[[NSNotificationCenter defaultCenter]
	 removeObserver:self
	 name:ASUpdateMetadataNotification
	 object:commonData.streamer];

	if(levelMeterUpdateTimer) {
		[levelMeterUpdateTimer invalidate];
		levelMeterUpdateTimer = nil;
	}

	[levelMeterView release];
	[imageView release];
	[loading release];
	[super dealloc];
}

#pragma mark Remote Control Events
/* The iPod controls will send these events when the app is in the background */
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
	switch (event.subtype) {
		case UIEventSubtypeRemoteControlTogglePlayPause:
			if ([commonData.streamer isPlaying])
				[commonData.streamer stop];
			else {
				[self createStreamer];
				[commonData.streamer start];
			}
			break;
		case UIEventSubtypeRemoteControlPlay:
			[commonData.streamer start];
			break;
		case UIEventSubtypeRemoteControlPause:
			[commonData.streamer pause];
			break;
		case UIEventSubtypeRemoteControlStop:
			[commonData.streamer stop];
			break;
		default:
			break;
	}
}

- (TKLoadingView *) loading{
	if(loading==nil){
		loading  = [[TKLoadingView alloc] initWithTitle:@"Buffering Stream..."];
		[loading startAnimating];
		loading.center = CGPointMake(self.view.bounds.size.width/2, 160);
	}
	return loading;
}

@end
