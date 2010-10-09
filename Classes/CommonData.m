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

-(void)dealloc{
	[super dealloc];
}

@end
