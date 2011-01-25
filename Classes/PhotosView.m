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
	PhotosDataSource *flickrPhotoSource = [[PhotosDataSource alloc] init];
	self.photoSource = flickrPhotoSource;
	flickrPhotoSource = nil;
	TT_RELEASE_SAFELY(flickrPhotoSource);
}

- (void)didReceiveMemoryWarning {

    [[TTURLCache sharedCache] removeAll:NO];
	
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	
    [[TTURLCache sharedCache] removeAll:NO];
	
    [super viewDidUnload];
}


@end

