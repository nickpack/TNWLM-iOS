//
//  TwitterDataSource.m
//  TNWLM2
//
//  Created by Nick on 17/03/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "TwitterDataSource.h"
#import "TwitterModel.h"
#import "Tweet.h"

#import <Three20Core/NSDateAdditions.h>

@implementation TwitterDataSource

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithSearchQuery:(NSString*)searchQuery {
    if (self = [super init]) {
        _searchFeedModel = [[TwitterModel alloc] initWithSearchQuery:searchQuery];
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    TT_RELEASE_SAFELY(_searchFeedModel);
    
    [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTModel>)model {
    return _searchFeedModel;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView*)tableView {
    NSMutableArray* items = [[NSMutableArray alloc] init];
    
    for (Tweet* tweet in _searchFeedModel.tweets) {
        TTStyledText* styledText = [TTStyledText textFromXHTML:
                                    [NSString stringWithFormat:@"%@\n<b>%@</b> from %@",
                                     [[tweet.text stringByReplacingOccurrencesOfString:@"&"
                                                                            withString:@"&amp;"]
                                      stringByReplacingOccurrencesOfString:@"<"
                                      withString:@"&lt;"],
                                     [tweet.created formatRelativeTime],
                                     tweet.source]
                                                    lineBreaks:YES URLs:YES];
        // If this asserts, it's likely that the tweet.text contains an HTML character that caused
        // the XML parser to fail.
        TTDASSERT(nil != styledText);
        [items addObject:[TTTableStyledTextItem itemWithText:styledText]];
    }
    
    if (!_searchFeedModel.finished) {
        [items addObject:[TTTableMoreButton itemWithText:@"More Tweets…"]];
    }
    
    self.items = items;
    TT_RELEASE_SAFELY(items);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
    if (reloading) {
        return NSLocalizedString(@"Updating Twitter feed...", @"Twitter feed updating text");
    } else {
        return NSLocalizedString(@"Loading Twitter feed...", @"Twitter feed loading text");
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
    return NSLocalizedString(@"No tweets found.", @"Twitter feed no results");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
    return NSLocalizedString(@"Sorry, there was an error loading the Twitter stream.", @"");
}


@end
