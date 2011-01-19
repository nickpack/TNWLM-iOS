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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		//self.variableHeightRows = YES;
		self.title = @"Album Information";
		self.tableViewStyle = UITableViewStyleGrouped;
        self.variableHeightRows = YES;
	}
	
	return self;
}

- (void) viewDidLoad {
	[super viewDidLoad];	
	UIBarButtonItem *cancelAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(exit)];
	self.navigationItem.leftBarButtonItem = cancelAdd;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) createModel {
	
	NSString* imageUrl = @"bundle://ill.png";
	
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
				  itemWithText: @"Illuminate"
				  imageURL: imageUrl
				  defaultImage: TTIMAGE(@"bundle://gravatar-48.png")
				  imageStyle: style
				  URL: nil];
	
	TTTableCaptionItem* year = [TTTableCaptionItem
	 itemWithText:@"2009"
	 caption: @"Year"
	 URL: nil];
	
	self.dataSource =
	[TTSectionedDataSource dataSourceWithObjects:
	 @"",
	 coverTitle,
	 year,
	 @"Track Listing",
	 nil];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void) exit{
	[self dismissModalViewControllerAnimated:YES];
}

@end

