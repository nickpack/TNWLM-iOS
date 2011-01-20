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
/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		//self.variableHeightRows = YES;
		self.title = @"Album Information";
		self.tableViewStyle = UITableViewStyleGrouped;
        self.variableHeightRows = YES;
	}
	
	return self;
}*/

-(id)initWithIndex:(int)coverIndex {
	if (self = [super init]) {
		//self.variableHeightRows = YES;
		self.title = @"Album Information";
		self.tableViewStyle = UITableViewStyleGrouped;
        self.variableHeightRows = YES;
	}
	
	NSString *path=[[NSBundle mainBundle] pathForResource:@"albums" ofType:@"plist"];
	NSMutableArray* dict = [[NSMutableDictionary dictionaryWithContentsOfFile:path] valueForKey:@"Albums"];
	albumInfo = [dict objectAtIndex:coverIndex];
	//TT_RELEASE_SAFELY(path);
	//TT_RELEASE_SAFELY(dict);
	return self;
}

- (void) viewDidLoad {
	[super viewDidLoad];	
	UIBarButtonItem *cancelAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(exit)];
	self.navigationItem.leftBarButtonItem = cancelAdd;
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
				  itemWithText: [albumInfo objectAtIndex:0]
				  imageURL: imageUrl
				  defaultImage: nil
				  imageStyle: style
				  URL: nil];
	
	TTTableCaptionItem* year = [TTTableCaptionItem
	 itemWithText:[albumInfo objectAtIndex:2]
	 caption: @"Year"
	 URL: nil];
	
	TTTableCaptionItem* description = [TTTableCaptionItem
								itemWithText:[albumInfo objectAtIndex:3]
								caption: @"Description"
								URL: nil];
	
	
	NSMutableArray* tracklist = [NSMutableArray arrayWithObject:coverTitle];
	[tracklist addObject:year];
	[tracklist addObject:description];
	int trackCount = 1;	
	for (id track in [albumInfo objectAtIndex:4]) {
		TTTableCaptionItem* ctrack = [TTTableCaptionItem
									  itemWithText:track
									  caption: [NSString stringWithFormat:@"Track %i",trackCount]
									  URL: nil];
		[tracklist addObject:ctrack];
		trackCount++;
	}
	
	
	
	/*self.dataSource =
	[TTSectionedDataSource dataSourceWithObjects:
	 @"",
	 coverTitle,
	 year,
	 description,
	 @"Track Listing",
	 tracklist,
	 nil];*/
	
	self.dataSource = [TTSectionedDataSource dataSourceWithItems:tracklist sections: nil];
	
	
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

