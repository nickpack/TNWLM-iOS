//
//  TwitterModel.h
//  TNWLM2
//
//  Created by Nick on 17/03/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TwitterModel : TTURLRequestModel {
    NSString* _username;
    NSMutableArray*  _tweets;
    
    NSUInteger _page;             // page of search request
    NSUInteger _resultsPerPage;   // results per page, once the initial query is made
    // this value shouldn't be changed
    BOOL _finished;
}

@property (nonatomic, copy)     NSString*       username;
@property (nonatomic, readonly) NSMutableArray* tweets;
@property (nonatomic, assign)   NSUInteger      resultsPerPage;
@property (nonatomic, readonly) BOOL            finished;

- (id)initWithUsername:(NSString*)username;

@end
