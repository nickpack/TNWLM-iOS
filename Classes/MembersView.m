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
		self.title = @"Biography";
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
	self.variableHeightRows = YES;
	self.dataSource = self.bandBio;
}

- (void)tabBar:(TTTabBar*)tabBar tabSelected:(NSInteger)selectedIndex
{
	NSLog(@"Selected Tab: %i",selectedIndex);
	if(selectedIndex == 0) {
		self.dataSource = self.bandBio;
	} else if(selectedIndex == 1) {
		self.dataSource = self.steveBio;
	} else if(selectedIndex == 2) {
		self.dataSource = self.tobyBio;
	} else {
		self.dataSource = self.leeBio;
	}

	[self refresh];

}

-(TTSectionedDataSource* )bandBio {
		bandBio = [TTSectionedDataSource dataSourceWithObjects:
				   @"",
				   [TTTableTextItem itemWithText:@"The Nurse Who Loved Me formed in 2003, blend Riffy Rock with Big ambient guitar sounds. Pulling influences from the Foo Fighters, Doves, Elbow and Feeder. 2009 saw the band return from a 2 year hiatus with their third album ‘Illuminate’ and a whole bigger sound. The band are currently working on a set of new songs in the studio, which will be available as a free download at the end of 2011."
									URL:nil
									accessoryURL:nil],
				   @"Rocksound magazine said:",
				   [TTTableTextItem itemWithText:@"A member lighter and an effects pedal heavier, The Nurse Who Loved Me return for their third LP. For a band named after a Failure track, success is on their side. Accomplished and cohesive, ‘Illuminate’ manages to straddle melody and fuzzy feedback admirably. ‘The Final Sleep’ is lush and angry at the same time, and sees vocalist Steve Weston keening “you are missed” over swampy guitars. Meanwhile, ‘Slowest Summer’ is a sweet and subdued acoustic number that sublimates into post-Pixies fuzz around the halfway mark. ‘Illuminate’? It’s a spark in a dark room."
									         URL:nil
									accessoryURL:nil],

				   nil];
	return bandBio;
}

-(TTSectionedDataSource* )steveBio {
	TTStyle* style =
	[TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
	 [TTSolidBorderStyle styleWithColor:[UIColor colorWithWhite:0.86 alpha:1]
								  width:1 next:
	  [TTInsetStyle styleWithInset:UIEdgeInsetsMake(2, 2, 2, 2) next:
	   [TTContentStyle styleWithNext:
        [TTImageStyle styleWithImageURL:nil
						   defaultImage:nil
							contentMode:UIViewContentModeScaleAspectFill
								   size:CGSizeMake(50, 50) next:nil]]]]];



	steveBio = [TTSectionedDataSource dataSourceWithObjects:
				   @"",
				[TTTableImageItem itemWithText: @"Steve Weston"
									  imageURL: @"http://thenursewholovedme.com/wp-content/uploads/avatars/2/1295103253-bpfull.jpg"
								  defaultImage: TTIMAGE(@"bundle://bio-head.png")
									imageStyle: style
										   URL: nil],
				[TTTableCaptionItem
				 itemWithText:@"Vocals / Guitars / Keyboard"
				 caption: @"plays"
				 URL: nil],
				[TTTableCaptionItem
				 itemWithText:@"@steve_weston"
				 caption: @"twitter"
				 URL: @"http://www.twitter.com/steve_weston"],
				[TTTableCaptionItem
				 itemWithText:@"I've played guitar since I was 14 and like to play a bit of drums. As well as write and produce music, I love graphic design. My favourite bands would have to be Doves, Foo Fighters, Sparklehorse and Portishead."
				 caption: @"bio"
				 URL: nil],
				
				   nil];
	//
	return steveBio;
}
-(TTSectionedDataSource* )leeBio {
	TTStyle* style =
	[TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
	 [TTSolidBorderStyle styleWithColor:[UIColor colorWithWhite:0.86 alpha:1]
								  width:1 next:
	  [TTInsetStyle styleWithInset:UIEdgeInsetsMake(2, 2, 2, 2) next:
	   [TTContentStyle styleWithNext:
        [TTImageStyle styleWithImageURL:nil
						   defaultImage:nil
							contentMode:UIViewContentModeScaleAspectFill
								   size:CGSizeMake(50, 50) next:nil]]]]];
	leeBio = [TTSectionedDataSource dataSourceWithObjects:
			  @"",
			  [TTTableImageItem itemWithText: @"Lee 'Meatarm' Yates"
									imageURL: @"http://thenursewholovedme.com/wp-content/uploads/avatars/3/1295188568-bpfull.jpg"
								defaultImage: TTIMAGE(@"bundle://bio-head.png")
								  imageStyle: style
										 URL: nil],
			  [TTTableCaptionItem
			   itemWithText:@"Bass / Guitar"
			   caption: @"plays"
			   URL: nil],
			  [TTTableCaptionItem
			   itemWithText:@"@meatarm"
			   caption: @"twitter"
			   URL: @"http://www.twitter.com/meatarm"],
			  [TTTableCaptionItem
			   itemWithText:@"As well as play bass for the nurse, I have a solo project called Idée Fixe which is kinda of ambient film music."
			   caption: @"bio"
			   URL: nil],
			  
			  nil];

	return leeBio;
}

-(TTSectionedDataSource* )tobyBio {
	TTStyle* style =
	[TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
	 [TTSolidBorderStyle styleWithColor:[UIColor colorWithWhite:0.86 alpha:1]
								  width:1 next:
	  [TTInsetStyle styleWithInset:UIEdgeInsetsMake(2, 2, 2, 2) next:
	   [TTContentStyle styleWithNext:
        [TTImageStyle styleWithImageURL:nil
						   defaultImage:nil
							contentMode:UIViewContentModeScaleAspectFill
								   size:CGSizeMake(50, 50) next:nil]]]]];
	tobyBio = [TTSectionedDataSource dataSourceWithObjects:
			   @"",
			   [TTTableImageItem itemWithText: @"Toby Gore"
									 imageURL: @"http://thenursewholovedme.com/wp-content/uploads/avatars/4/1295218844-bpfull.jpg"
								 defaultImage: TTIMAGE(@"bundle://bio-head.png")
								   imageStyle: style
										  URL: nil],
			   [TTTableCaptionItem
				itemWithText:@"Drums / Vocals / Samples"
				caption: @"plays"
				URL: nil],
			   [TTTableCaptionItem
				itemWithText:@"I am a dedicated drummer/teacher who plays with The Nurse Who Loved Me. I have also made it my mission to make girls understand why Predator is such a good film."
				caption: @"bio"
				URL: nil],
			   
			   nil];

	return tobyBio;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_memberTabs);
	[super dealloc];
}

@end

