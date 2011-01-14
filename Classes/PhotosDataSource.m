//
//  PhotosDataSource.m
//  TNWLM2
//
//  Created by Nick Pack on 14/01/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "PhotosDataSource.h"
#import "PhotoItem.h"
#import "PhotosModel.h"
#import "Three20/Three20+Additions.h"
#import "extThree20XML/extThree20XML.h"

@implementation PhotosDataSource

@synthesize title = _title;

- (id)init {
	_title = @"Photos";
	
	if (self = [super init]) {
		_feedModel = [PhotosModel alloc];
	}
	_photos = [_feedModel objects];
	return self;
}

- (id<TTModel>)model {
	return _feedModel;
}

- (NSArray *)flickrPhotos
{
    return [[[_feedModel objects] copy] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTPhotoSource

- (NSInteger)numberOfPhotos {
	NSLog(@"Requested number of photos");
	return [_feedModel totalObjectsAvailableOnServer];
}

- (NSInteger)maxPhotoIndex {
	return [self flickrPhotos].count - 1;
}

- (id<TTPhoto>)photoAtIndex:(NSInteger)index {
	NSLog(@"Requested photo index");
	if (index < [self flickrPhotos].count) {
		id<TTPhoto> photo = [[self flickrPhotos] objectAtIndex:index];
		photo.index = index;
		photo.photoSource = self;
		return photo;
	} else {
		return nil;
	}
}

@end
