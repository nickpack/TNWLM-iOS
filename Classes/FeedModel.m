//
//  FeedModel.m
//  TNWLM2
//
//  Created by Nick Pack on 23/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import "FeedModel.h"
#import "FeedItem.h"
#import "extThree20XML/extThree20XML.h"

@implementation FeedModel

@synthesize feedUrl = _feedUrl;
@synthesize items = _items;

- (id)initWithFeedUrl:(NSString*)feedUrl {
	if (self = [super init]) {
		self.feedUrl = feedUrl;
	}
	NSLog(@"Feed Model init with: %@",feedUrl);
	return self;
}

- (void) dealloc {
	TT_RELEASE_SAFELY(_feedUrl);
	TT_RELEASE_SAFELY(_items);
	[super dealloc];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	NSLog(@"Feed model load");
	if (!self.isLoading) {
		NSLog(@"Feed Model is not loading");
		//NSURL *url = [NSURL URLWithString: self.feedUrl];
		TTURLRequest* request = [TTURLRequest
								 requestWithURL: self.feedUrl
								 delegate: self];
		
		request.cachePolicy = cachePolicy;
		request.cacheExpirationAge = 1;
		
		TTURLXMLResponse* response = [[TTURLXMLResponse alloc] init];
		response.isRssFeed = YES;
		request.response = response;
		TT_RELEASE_SAFELY(response);
		
		[request send];
	}
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	NSLog(@"Feed request finished");
	TTURLXMLResponse* response = request.response;
	TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
	
	NSDictionary* feed = response.rootObject;
	
	for (id key in feed) {
		
        NSLog(@"key: %@, value: %@", key, [feed objectForKey:key]);
		
    }
	
	
	TTDASSERT([[feed objectForKey:@"item"] isKindOfClass:[NSArray class]]);
	
	NSArray* entries = [[feed objectForKey:@"channel"] objectForKey:@"item"];
	NSLog(@"%d",[entries count]);
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeStyle:NSDateFormatterFullStyle];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
	
	TT_RELEASE_SAFELY(_items);
	NSMutableArray* items = [[NSMutableArray alloc] initWithCapacity:[entries count]];
	
	for (NSDictionary* entry in entries) {
		FeedItem* item = [[FeedItem alloc] init];
		/*
		 NSDate*   _posted;
		 NSString* _title;
		 NSString* _body;
		 NSURL* _link;
		 */
		NSDate* date = [dateFormatter dateFromString:[[entry objectForKey:@"pubDate"]
													  objectForXMLNode]];
		
		item.posted = date;
		item.title = [[entry objectForKey:@"title"] objectForXMLNode];
		item.body = [[entry objectForKey:@"description"] objectForXMLNode];
		item.link = [[entry objectForKey:@"link"] objectForXMLNode];
		[items addObject:item];
		NSLog(@"Parsed: %@",item.body);
		TT_RELEASE_SAFELY(item);
		
	}
	_items = items;
	
	TT_RELEASE_SAFELY(dateFormatter);
	
	[super requestDidFinishLoad:request];
}

@end
