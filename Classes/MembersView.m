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
					 [[[TTTabItem alloc] initWithTitle:@"Band"] autorelease],
					 [[[TTTabItem alloc] initWithTitle:@"Steve"] autorelease],
					 [[[TTTabItem alloc] initWithTitle:@"Toby"] autorelease],
					 [[[TTTabItem alloc] initWithTitle:@"Lee"] autorelease],
					 nil];
	_memberTabs.delegate = self;
	_memberTabs.contentMode = UIViewContentModeScaleToFill;
	self.tableView.tableHeaderView = _memberTabs;
	self.tableView.backgroundColor = TTSTYLEVAR(tabTintColor);
	//self.tableView.style = UITableViewStyleGrouped;
	self.variableHeightRows = YES;
}

- (void)tabBar:(TTTabBar*)tabBar tabSelected:(NSInteger)selectedIndex
{

}

- (void) createModel {
	TTTableCaptionItem* appCopyright = [TTTableCaptionItem
										itemWithText:@"TNWLM2 for iOS Copyright 2011 Nikki James Pack."
										caption: @"TNWLM2"
										URL: nil];
	TTTableCaptionItem* photoCopyright = [TTTableCaptionItem
										  itemWithText:@"All photography displayed by this application is Copyright 2011 Amy Constantine, used with permission."
										  caption: @"Photography"
										  URL: nil];
	TTTableCaptionItem* musicCopyright = [TTTableCaptionItem
										  itemWithText:@"Music broadcasted by this application is Copyright 2011 The Nurse Who Loved Me or used under licence from the respective copyright holder."
										  caption: @"Music"
										  URL: nil];
	TTTableCaptionItem* artworkCopyright = [TTTableCaptionItem
											itemWithText:@"Artwork displayed in this application is Copyright 2011 The Nurse Who Loved Me."
											caption: @"Visual Artwork"
											URL: nil];

	NSArray* authors = [NSArray arrayWithObjects:appCopyright,photoCopyright,musicCopyright,artworkCopyright,nil];

	self.dataSource = [[TTSectionedDataSource alloc] initWithItems:[NSArray arrayWithObjects:authors, nil] sections:[NSArray arrayWithObjects:@"", nil]];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_memberTabs);
	[super dealloc];
}

@end

