//
//  CommonData.m
//  TNWLM2
//
//  Created by Nick on 09/10/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import "CommonData.h"
#import "SynthesizeSingleton.h"
#import "AudioStreamer.h"

@implementation CommonData

SYNTHESIZE_SINGLETON_FOR_CLASS(CommonData);

@synthesize streamUrl;
@synthesize streamer;
@synthesize currentTrack;
@synthesize currentAlbum;
@synthesize currentArt;
@synthesize internetReachable;

-(void)dealloc{
	TT_RELEASE_SAFELY(streamUrl);
	TT_RELEASE_SAFELY(streamer);
	TT_RELEASE_SAFELY(currentTrack);
	TT_RELEASE_SAFELY(currentAlbum);
	TT_RELEASE_SAFELY(currentArt);
	[super dealloc];
}

@end
