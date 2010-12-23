//
//  FeedModel.h
//  TNWLM2
//
//  Created by Nick Pack on 23/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FeedModel : TTURLRequestModel {
	NSURL* _feedUrl;
	NSArray*  _items;
}

@property (nonatomic, copy)     NSURL* feedUrl;
@property (nonatomic, readonly) NSArray*  items;

- (id)initWithFeedUrl:(NSURL*)feedUrl;

@end
