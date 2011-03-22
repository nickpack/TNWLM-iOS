//
//  TwitterView.m
//  TNWLM2
//
//  Created by Nick on 16/03/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "TwitterView.h"
#import "TwitterDataSource.h"
#import <Three20UI/UIViewAdditions.h>
@implementation TwitterView

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.title = @"Twitter Feeds";
        self.variableHeightRows = YES;
        
        CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
        _memberTabs = [[TTTabBar alloc] initWithFrame:CGRectMake(0, _memberTabs.bottom, applicationFrame.size.width, 40)];
        _memberTabs.tabItems = [NSArray arrayWithObjects:
                                [[[TTTabItem alloc] initWithTitle:@"Band"] autorelease],
                                [[[TTTabItem alloc] initWithTitle:@"Steve"] autorelease],
                                [[[TTTabItem alloc] initWithTitle:@"Lee"] autorelease],
                                nil];
        _memberTabs.delegate = self;
        _memberTabs.contentMode = UIViewContentModeScaleToFill;
        self.tableView.tableHeaderView = _memberTabs;
        self.tableView.backgroundColor = TTSTYLEVAR(tabTintColor);
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createModel {
    self.dataSource = [[[TwitterDataSource alloc]
                        initWithUsername:@"tnwlm"] autorelease];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {
    return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

- (void)tabBar:(TTTabBar*)tabBar tabSelected:(NSInteger)selectedIndex
{
	[self invalidateModel];
    if(selectedIndex == 0) {
		self.dataSource = [[[TwitterDataSource alloc]
                            initWithUsername:@"tnwlm"] autorelease];
	} else if(selectedIndex == 1) {
		self.dataSource = [[[TwitterDataSource alloc]
                            initWithUsername:@"steve_weston"] autorelease];
	} else {
		self.dataSource = [[[TwitterDataSource alloc]
                            initWithUsername:@"meatarm"] autorelease];
	}    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];	
}

-(void) dealloc {
    [_memberTabs release];
    [super dealloc];
}

@end
