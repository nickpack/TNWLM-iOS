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
#import "RegexKitLite.h"
#import <Three20Core/NSDateAdditions.h>

@implementation TwitterDataSource

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithUsername:(NSString*)username {
    if ((self = [super init])) {
        _twitterFeedModel = [[TwitterModel alloc] initWithUsername:username];
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    TT_RELEASE_SAFELY(_twitterFeedModel);
    
    [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTModel>)model {
    return _twitterFeedModel;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView*)tableView {
    NSMutableArray* items = [[NSMutableArray alloc] init];
    TTStyle* style =
	[TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
	 [TTSolidBorderStyle styleWithColor:[UIColor colorWithWhite:0.86 alpha:1]
								  width:1 next:
	  [TTInsetStyle styleWithInset:UIEdgeInsetsMake(2, 2, 2, 2) next:
	   [TTContentStyle styleWithNext:
        [TTImageStyle styleWithImageURL:nil
						   defaultImage:nil
							contentMode:UIViewContentModeScaleAspectFill
								   size:CGSizeMake(50, 50) next:nil]]]]];
    
    if(_twitterFeedModel.username == @"steve_weston") {
        [items addObject:[TTTableImageItem itemWithText: @"@steve_weston"
                          imageURL: @"http://app.thenursewholovedme.com/steveweston.jpg"
                      defaultImage: TTIMAGE(@"bundle://bio-head.png")
                        imageStyle: style
                               URL: @"http://twitter.com/steve_weston"]];
    } else if (_twitterFeedModel.username == @"meatarm") {
        [items addObject:[TTTableImageItem itemWithText: @"@meatarm"
                                               imageURL: @"http://app.thenursewholovedme.com/meatarm.jpg"
                                           defaultImage: TTIMAGE(@"bundle://bio-head.png")
                                             imageStyle: style
                                                    URL: @"http://twitter.com/meatarm"]];
    } else {
        [items addObject:[TTTableImageItem itemWithText: @"@tnwlm"
                                               imageURL: @"fail"
                                           defaultImage: TTIMAGE(@"bundle://bio-head.png")
                                             imageStyle: style
                                                    URL: @"http://twitter.com/tnwlm"]];
    }
    
    for (Tweet* tweet in _twitterFeedModel.tweets) {
              
        tweet.text = [[tweet.text stringByReplacingOccurrencesOfRegex:@"(\\A|\\s)@(\\w+)" withString:@" <a href=\"http://www.twitter.com/$2\">@$2</a>"] 
                                  stringByReplacingOccurrencesOfRegex:@"(\\A|\\s)#(\\w+)" withString:@" <a href=\"http://search.twitter.com/search?q=$2\">$2</a>"];
        
        TTStyledText* styledText = [TTStyledText textFromXHTML:
                                    [NSString stringWithFormat:@"%@\n<b>%@</b> from %@",
                                     [tweet.text stringByReplacingOccurrencesOfString:@"&"
                                                                            withString:@"&amp;"],
                                     [tweet.created formatRelativeTime],
                                     tweet.source]
                                                    lineBreaks:YES URLs:NO];
        // If this asserts, it's likely that the tweet.text contains an HTML character that caused
        // the XML parser to fail.
        TTDASSERT(nil != styledText);
        [items addObject:[TTTableStyledTextItem itemWithText:styledText]];
    }
    
    if (!_twitterFeedModel.finished) {
        [items addObject:[TTTableMoreButton itemWithText:@"More Tweets…"]];
    }
    
    self.items = items;
    TT_RELEASE_SAFELY(items);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
    if (reloading) {
        return NSLocalizedString(@"Updating Twitter Feed...", @"Twitter feed updating text");
    } else {
        return NSLocalizedString(@"Loading Twitter Feed...", @"Twitter feed loading text");
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
