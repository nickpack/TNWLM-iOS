//
//  PhotosModel.m
//  TNWLM2
//
//  Created by Nick Pack on 14/01/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "PhotosModel.h"
#import "PhotoItem.h"
#import "extThree20XML/extThree20XML.h"
#import "Three20/Three20+Additions.h"

@implementation PhotosModel
@synthesize objects, totalObjectsAvailableOnServer;

- (id)init {
    page = 1;
	objects = [[NSMutableArray alloc] init];
	return self;
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	NSLog(@"LOAD");
	if (more) {
		page++;
	}
	NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"flickr.photos.search", @"method",
                                @"mac wallpaper", @"text",
                                //@"url_m,url_t", @"extras",
                                @"b6984df5998a9723e83887d2163e69be", @"api_key", // Admoo Labs three20 key. Please change this.
                                @"xmlrpc", @"format",
                                [NSString stringWithFormat:@"%lu", (unsigned long)page], @"page",
                                @"16", @"per_page",
                                //@"1", @"nojsoncallback",
                                nil];
	
    NSString *apiurl = @"http://api.flickr.com/services/rest/";
	NSString *url = [apiurl stringByAddingQueryDictionary:parameters];
	NSLog(@"url: %@", url);
	
	TTURLRequest* request = [TTURLRequest
							 requestWithURL: url
							 delegate: self];
	request.cachePolicy = cachePolicy;
	request.cacheExpirationAge = 1;
	
	TTURLXMLResponse* response = [[TTURLXMLResponse alloc] init];
	response.isRssFeed = YES;
	request.response = response;
	TT_RELEASE_SAFELY(response); 
	NSLog(@"Added and freed response");
    // Dispatch the request.
    [request send];
	NSLog(@"Sent request");
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	NSLog(@"Finished now parse");
	TTURLXMLResponse* response = request.response;
	TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
	
	NSDictionary* feed = response.rootObject;
	
    NSDictionary *root = [feed objectForKey:@"photos"];
    totalObjectsAvailableOnServer = [[root objectForKey:@"total"] integerValue];
	
    // Create the ALPhotos
    NSArray *results = [root objectForKey:@"photo"];
    for (NSDictionary *rawResult in results) {        
		
		NSString* bigURL = [rawResult objectForKey:@"url_m"];
		NSString* smallURL = [rawResult objectForKey:@"url_t"];
		NSString* title = [rawResult objectForKey:@"title"];
		CGSize bigSize = CGSizeMake([[rawResult objectForKey:@"width_m"] floatValue],
									[[rawResult objectForKey:@"height_m"] floatValue]);
		
		PhotoItem* photo = [[[PhotoItem alloc] initWithURL:bigURL smallURL:smallURL size:bigSize caption:title] autorelease];
		
        [self.objects addObject:photo];
    }
    
    [super requestDidFinishLoad:request];
}

@end
