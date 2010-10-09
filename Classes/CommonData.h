//
//  CommonData.h
//  TNWLM2
//
//  Created by Nick on 09/10/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudioStreamer.h"

@interface CommonData : NSObject {
	NSURL *streamUrl;
	AudioStreamer *streamer;
}

+(CommonData *)sharedCommonData;

@property (nonatomic, retain) NSURL *streamUrl;
@property (nonatomic, retain) AudioStreamer *streamer;

@end
