//
//  TwitterModel.m
//  TNWLM2
//
//  Created by Nick on 17/03/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "TwitterModel.h"
#import "Tweet.h"
#import "extThree20JSON/extThree20JSON.h"

static NSString* kTwitterSearchFeedFormat =
@"https://api.twitter.com/1/statuses/user_timeline.json?screen_name=%@&count=%u&page=%u";

@implementation TwitterModel

@synthesize username     = _username;
@synthesize tweets          = _tweets;
@synthesize resultsPerPage  = _resultsPerPage;
@synthesize finished        = _finished;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithUsername:(NSString*)username {
    if ((self = [super init])) {
        self.username = username;
        _resultsPerPage = 10;
        _page = 1;
        _tweets = [[NSMutableArray array] retain];
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_tweets);
    [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    if (!self.isLoading && TTIsStringWithAnyText(_username)) {
        if (more) {
            _page++;
        }
        else {
            _page = 1;
            _finished = NO;
            [_tweets removeAllObjects];
        }
        
        NSString* url = [NSString stringWithFormat:kTwitterSearchFeedFormat, _username, _resultsPerPage, _page];
        TTURLRequest* request = [TTURLRequest
                                 requestWithURL: url
                                 delegate: self];
        
        request.cachePolicy = cachePolicy;
        request.cacheExpirationAge = 300;
        
        TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
        request.response = response;
        TT_RELEASE_SAFELY(response);
        
        [request send];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
    TTURLJSONResponse* response = request.response;
    //TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
    
    NSDictionary* feed = response.rootObject;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];
    
    NSMutableArray* tweets = [NSMutableArray arrayWithCapacity:[feed count]];
    
    for (NSDictionary* entry in feed) {
        Tweet* tweet = [[Tweet alloc] init];
        
        NSDate* date = [dateFormatter dateFromString:[entry objectForKey:@"created_at"]];
        tweet.created = date;
        tweet.tweetId = [NSNumber numberWithLongLong:
                         [[entry objectForKey:@"id"] longLongValue]];
        tweet.text = [entry objectForKey:@"text"];
        tweet.source = [entry objectForKey:@"source"];
        [tweets addObject:tweet];
        TT_RELEASE_SAFELY(tweet);
    }
    _finished = tweets.count < _resultsPerPage;
    [_tweets addObjectsFromArray: tweets];
    
    TT_RELEASE_SAFELY(dateFormatter);
    
    [super requestDidFinishLoad:request];
}

@end
