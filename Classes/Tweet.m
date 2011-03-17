//
//  Tweet.m
//  TNWLM2
//
//  Created by Nick on 17/03/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "Tweet.h"


@implementation Tweet

@synthesize created   = _created;
@synthesize tweetId   = _tweetId;
@synthesize text      = _text;
@synthesize source    = _source;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
    TT_RELEASE_SAFELY(_created);
    TT_RELEASE_SAFELY(_tweetId);
    TT_RELEASE_SAFELY(_text);
    TT_RELEASE_SAFELY(_source);
    [super dealloc];
}


@end
