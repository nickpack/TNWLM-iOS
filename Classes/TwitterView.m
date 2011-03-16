//
//  TwitterView.m
//  TNWLM2
//
//  Created by Nick on 16/03/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "TwitterView.h"
#import "NewsDataSource.h"

@implementation TwitterView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"Twitter";
		self.variableHeightRows = YES;
	}
    
	return self;
}

- (void)createModel {
	self.dataSource = [[[NewsDataSource alloc]
						initWithFeedUrl:@"https://api.twitter.com/1/statuses/user_timeline.atom?screen_name=tnwlm"] autorelease];
}

- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

@end
