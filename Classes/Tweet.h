//
//  Tweet.h
//  TNWLM2
//
//  Created by Nick on 17/03/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Tweet : NSObject {
    NSDate*   _created;
    NSNumber* _tweetId;
    NSString* _text;
    NSString* _source;
}

@property (nonatomic, retain) NSDate*   created;
@property (nonatomic, retain) NSNumber* tweetId;
@property (nonatomic, copy)   NSString* text;
@property (nonatomic, copy)   NSString* source;

@end
