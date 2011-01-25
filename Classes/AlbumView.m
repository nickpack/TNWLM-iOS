//
//  AlbumView.m
//  TNWLM2
//
//  Created by Nick Pack on 19/01/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "AlbumView.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation AlbumView

@synthesize albumInfo;

-(id)initWithIndex:(int)coverIndex {
	if (self = [super init]) {
		self.title = @"Album Information";
		self.tableViewStyle = UITableViewStyleGrouped;
        self.variableHeightRows = YES;
	}
	
	NSString *path=[[NSBundle mainBundle] pathForResource:@"albums" ofType:@"plist"];
	NSMutableArray* dict = [[NSMutableDictionary dictionaryWithContentsOfFile:path] valueForKey:@"Albums"];
	albumInfo = [dict objectAtIndex:coverIndex];
	path = nil;
	dict = nil;
	[path release];
	[dict release];
	return self;
}

- (void) viewDidLoad {
	[super viewDidLoad];	
	UIBarButtonItem *close = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(exit)];
	self.navigationItem.leftBarButtonItem = close;
	close = nil;
	[close release];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) createModel {
			
	NSString* imageUrl = [NSString stringWithFormat:@"bundle://%@",[albumInfo objectAtIndex:1]];
			
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
	
	
	TTTableImageItem* coverTitle = [TTTableImageItem
				  itemWithText: [NSString stringWithFormat:@"%@ (%@)",[albumInfo objectAtIndex:0],[albumInfo objectAtIndex:2]]
				  imageURL: imageUrl
				  defaultImage: nil
				  imageStyle: style
				  URL: nil];
	
	
	TTTableLongTextItem* description = [TTTableLongTextItem
								itemWithText:[albumInfo objectAtIndex:3]
								URL: nil];
	
	
	NSMutableArray* info = [NSMutableArray arrayWithObjects:coverTitle,description,nil];
	
	NSMutableArray* tracklist = [NSMutableArray arrayWithCapacity:1];
	int trackCount = 1;	
	for (id track in [albumInfo objectAtIndex:4]) {
		TTTableCaptionItem* ctrack = [TTTableCaptionItem
									  itemWithText:track
									  caption: [NSString stringWithFormat:@"%i",trackCount]
									  URL: nil];
		[tracklist addObject:ctrack];
		trackCount++;
	}
	self.dataSource = [[TTSectionedDataSource alloc] initWithItems:[NSArray arrayWithObjects:info, tracklist, nil] sections:[NSArray arrayWithObjects:@"Album Information", @"Track List", nil]];
	tracklist = nil;
	imageUrl = nil;
	style = nil;
	coverTitle = nil;
	description = nil;
	info = nil;
	[tracklist release];
	[imageUrl release];
	[style release];
	[coverTitle release];
	[description release];
	[info release];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void) exit{
	albumInfo = nil;
	TT_RELEASE_SAFELY(albumInfo);
	[self dismissModalViewControllerAnimated:YES];
}

@end

