//
//  PhotosDataSource.m
//  TNWLM2
//
//  Created by Nick Pack on 14/01/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "PhotosDataSource.h"
#import "PhotoItem.h"
#import "PhotoResponse.h"
#import "Three20/Three20+Additions.h"
#import "extThree20XML/extThree20XML.h"

@implementation PhotosDataSource

@synthesize title = _title;

- (id)init {
	_title = @"Photos";
	
	page = 1;
    responseProcessor = [[PhotoResponse alloc] init];
	
	return self;
}

- (NSArray *)flickrPhotos
{
    return [[[responseProcessor objects] copy] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTPhotoSource

- (NSInteger)numberOfPhotos {
	return [responseProcessor totalObjectsAvailableOnServer];
}

- (NSInteger)maxPhotoIndex {
	return [self flickrPhotos].count - 1;
}

- (id<TTPhoto>)photoAtIndex:(NSInteger)index {
	if (index < [self flickrPhotos].count) {
		id<TTPhoto> photo = [[self flickrPhotos] objectAtIndex:index];
		photo.index = index;
		photo.photoSource = self;
		return photo;
	} else {
		return nil;
	}
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (more) {
		page++;
	}
	if (!self.isLoading) {
		NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
		 @"flickr.groups.pools.getPhotos", @"method",
		 @"1584352@N23", @"group_id",
		 @"rest", @"format",
		 [NSString stringWithFormat:@"%lu", (unsigned long)page], @"page",
		 @"16", @"per_page",
		 @"url_m,url_t", @"extras",
		 @"b6984df5998a9723e83887d2163e69be", @"api_key", // Admoo Labs three20 key. Please change this.
		 
		 nil];
		 
		 NSString *apiurl = @"http://api.flickr.com/services/rest/";
		 NSString *url = [apiurl stringByAddingQueryDictionary:parameters];
		//NSString *url = @"http://api.flickr.com/services/rest/?method=flickr.groups.pools.getPhotos&group_id=1584352@N23&format=rest&extras=url_m,url_t&page=1&per_page=16&api_key=b6984df5998a9723e83887d2163e69be";
		NSLog(@"url: %@", url);
		
		TTURLRequest* request = [TTURLRequest
								 requestWithURL: url
								 delegate: self];		
		
		request.cachePolicy = cachePolicy;
		request.cacheExpirationAge = 600;

		request.response = responseProcessor;
		[request send];
	}
}

@end
