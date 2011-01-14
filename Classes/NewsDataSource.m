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
	NSString* remoteImage = TTIMAGE(@"bundle://TapkuLibrary.bundle/Images/chatbubble.png");
	for (FeedItem* item in _feedModel.items) {
		/*TTStyledText* styledText = [TTStyledText textFromXHTML:[NSString stringWithFormat:@"%@",item.body]
																			   lineBreaks:YES URLs:YES];*/
		/*TTTableMessageItem* row =[TTTableMessageItem itemWithTitle:item.title caption:@"TTTableMessageItem"
									 text:item.body timestamp:item.posted
								 imageURL:@"" URL:item.link]*/
		
		
		
		// If this asserts, it's likely that the tweet.text contains an HTML character that caused
		// the XML parser to fail.
		//TTDASSERT(nil != styledText);
		NSString* body = [item.body stringByRemovingHTMLTags];
		[items addObject:[TTTableMessageItem itemWithTitle:item.poster caption:item.title
													  text:body timestamp:item.posted
												  imageURL:remoteImage URL:item.link]];
	}
	
	self.items = items;
	TT_RELEASE_SAFELY(items);
}

@end
