//
//  MembersView.m
//  TNWLM2
//
//  Created by Nick on 28/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import "MembersView.h"
#import <Three20UI/UIViewAdditions.h>

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation MembersView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"Bio";
	}
	
	return self;
}

- (void)loadView {
	CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
	
	self.view = [[[UIView alloc] initWithFrame:applicationFrame] autorelease];
	self.view.backgroundColor = TTSTYLEVAR(tabTintColor);
	_memberTabs = [[TTTabBar alloc] initWithFrame:CGRectMake(0, _memberTabs.bottom, applicationFrame.size.width, 40)];
	_memberTabs.tabItems = [NSArray arrayWithObjects:
					 [[[TTTabItem alloc] initWithTitle:@"The Band"] autorelease],
					 [[[TTTabItem alloc] initWithTitle:@"Steve"] autorelease],
					 [[[TTTabItem alloc] initWithTitle:@"Toby"] autorelease],
					 [[[TTTabItem alloc] initWithTitle:@"Lee"] autorelease],
					 nil];
	_memberTabs.delegate = self;
	[self.view addSubview:_memberTabs];
}

- (void)tabBar:(TTTabBar*)tabBar tabSelected:(NSInteger)selectedIndex 
{ 
	NSLog(@"Tab %i is selected",selectedIndex); 
} 

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)dealloc { 
	TT_RELEASE_SAFELY(_memberTabs); 
	[super dealloc]; 
} 

@end

