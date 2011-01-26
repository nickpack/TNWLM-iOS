//
//  NewsDataSource.m
//  TNWLM2
//
//  Created by Nick Pack on 23/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import "NewsDataSource.h"
#import "FeedModel.h"
#import "FeedItem.h"
#import <Three20Core/NSDateAdditions.h>
#import <Three20Core/NSStringAdditions.h>

@implementation NewsDataSource

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
		NSString* body = [item.description stringByRemovingHTMLTags];
		body = [body stringByReplacingOccurrencesOfString:@"\n" withString:@""];
		TTTableMessageItem* tableRow = [TTTableMessageItem itemWithTitle:item.title caption:[NSString stringWithFormat:@"Posted by: %@",item.poster]
																	text:body timestamp:item.posted
																imageURL:remoteImage URL:@"tt://viewnews"];
		NSDictionary* rowInfo = [NSDictionary dictionaryWithObjectsAndKeys:
								 item.title,
								 @"title",
								 item.poster,
								 @"postedBy",
								 item.body,
								 @"articleBody",
								 item.posted,
								 @"timestamp",
								 item.link,
								 @"original",
								 nil];
		tableRow.userInfo = rowInfo;
		[items addObject:tableRow];
	}

	self.items = items;
	TT_RELEASE_SAFELY(items);
}

@end
