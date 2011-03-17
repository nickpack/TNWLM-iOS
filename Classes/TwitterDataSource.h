//
//  TwitterDataSource.h
//  TNWLM2
//
//  Created by Nick on 17/03/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

@class TwitterModel;

@interface TwitterDataSource : TTListDataSource {
    TwitterModel* _searchFeedModel;
}

- (id)initWithSearchQuery:(NSString*)searchQuery;

@end
