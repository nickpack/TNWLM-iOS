//
//  PhotosView.m
//  TNWLM2
//
//  Created by Nick Pack on 14/01/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "PhotosView.h"
#import "PhotosDataSource.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation PhotosView

- (void)createModel {
	PhotosDataSource *alPhotoSource = [[PhotosDataSource alloc] init];
	self.photoSource = alPhotoSource;
}

@end

