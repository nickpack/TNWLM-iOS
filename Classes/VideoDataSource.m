//
//  VideoDataSource.m
//  TNWLM2
//
//  Created by Nick on 28/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import "VideoDataSource.h"
#import "FeedModel.h"
#import "FeedItem.h"
#import <Three20Core/NSDateAdditions.h>
#import <Three20Core/NSStringAdditions.h>

@implementation VideoDataSource

- (id)initWithFeedUrl:(NSString*)feedUrl {
	if (self = [super init]) {
		_feedModel = [[FeedModel alloc] initWithFeedUrl:feedUrl];
	}
	
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_feedModel);
	
	[super dealloc];
}

- (id<TTModel>)model {
	return _feedModel;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	NSString* remoteImage = @"bundle://News.png";
	for (FeedItem* item in _feedModel.items) {
		NSString* body = [item.body stringByRemovingHTMLTags];
		[items addObject:[TTTableMessageItem itemWithTitle:item.poster caption:item.title
													  text:body timestamp:item.posted
												  imageURL:item.thumb URL:item.link]];
	}
	
	self.items = items;
	TT_RELEASE_SAFELY(items);
}

@end
