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
	
	for (FeedItem* item in _feedModel.items) {
		TTStyledText* styledText = [TTStyledText textFromXHTML:[NSString stringWithFormat:@"<b>%@</b>\n%@\n<b>%@</b>",item.title,item.body,
									 [item.posted formatRelativeTime]]
													lineBreaks:YES URLs:YES];
		
		// If this asserts, it's likely that the tweet.text contains an HTML character that caused
		// the XML parser to fail.
		TTDASSERT(nil != styledText);
		[items addObject:[TTTableStyledTextItem itemWithText:styledText]];
	}
	
	self.items = items;
	TT_RELEASE_SAFELY(items);
}

@end
