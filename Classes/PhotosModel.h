//
//  PhotosModel.h
//  TNWLM2
//
//  Created by Nick Pack on 14/01/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PhotosModel : TTURLRequestModel {
	NSUInteger page;
	NSMutableArray* objects;
	NSUInteger totalObjectsAvailableOnServer;
}
@property (nonatomic, readonly) NSMutableArray *objects;
@property (nonatomic, readonly) NSUInteger totalObjectsAvailableOnServer;

@end
