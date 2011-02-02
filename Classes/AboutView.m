//
//  AboutView.m
//  TNWLM2
//
//  Created by Nick Pack on 26/01/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "AboutView.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation AboutView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"About/Credits";
		self.tableViewStyle = UITableViewStyleGrouped;
        self.variableHeightRows = YES;
	}

	return self;
}

- (void) viewDidLoad {
	[super viewDidLoad];
	UIBarButtonItem *close = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(exit)];
	self.navigationItem.leftBarButtonItem = close;
	close = nil;
	[close release];
}

- (void) createModel {
	TTTableCaptionItem* appCopyright = [TTTableCaptionItem
									 itemWithText:@"TNWLM2 for iOS Copyright 2010 Nikki James Pack."
									 caption: @"TNWLM2"
									 URL: nil];
	TTTableCaptionItem* photoCopyright = [TTTableCaptionItem
										itemWithText:@"All photography displayed by this application is Copyright Amy Constantine, used with permission."
										caption: @"Photography"
										URL: nil];
	TTTableCaptionItem* musicCopyright = [TTTableCaptionItem
										  itemWithText:@"Music broadcasted by this application is Copyright The Nurse Who Loved Me or used under licence from the respective copyright holder."
										  caption: @"Music"
										  URL: nil];
	TTTableCaptionItem* artworkCopyright = [TTTableCaptionItem
										  itemWithText:@"Artwork displayed in this application is Copyright Steve Weston c/o The Nurse Who Loved Me."
										  caption: @"Visual Artwork"
										  URL: nil];

	NSArray* copyright = [NSArray arrayWithObjects:appCopyright,photoCopyright,musicCopyright,artworkCopyright,nil];

	self.dataSource = [[TTSectionedDataSource alloc] initWithItems:[NSArray arrayWithObjects:copyright, nil] sections:[NSArray arrayWithObjects:@"Copyright Information", nil]];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void) exit{
	[self dismissModalViewControllerAnimated:YES];
}

-(void)dealloc {
	self.dataSource = nil;
	[super dealloc];
}

@end

