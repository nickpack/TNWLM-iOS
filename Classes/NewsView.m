//
//  NewsView.m
//  TNWLM2
//
//  Created by Nick Pack on 23/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import "NewsView.h"
#import "NewsDataSource.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NewsView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) init {
	if (self = [super init]) {
		self.title = @"News";
		self.variableHeightRows = YES;
	}
	
	return self;
}

- (void)createModel {
	NSURL *url = [NSURL URLWithString: @"http://www.thenursewholovedme.com/feed"];
	self.dataSource = [[[NewsDataSource alloc]
						initWithFeedUrl:url] autorelease];
}

- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

@end

