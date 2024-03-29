//
//  ReleasesView.m
//  TNWLM2
//
//  Created by Nick Pack on 23/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import "ReleasesView.h"

@implementation ReleasesView

@synthesize coverflow;
@synthesize coverIndex;
@synthesize covers;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"Releases";
	}

	NSString *path=[[NSBundle mainBundle] pathForResource:@"albums" ofType:@"plist"];
	NSMutableArray* dict = [[NSMutableDictionary dictionaryWithContentsOfFile:path] valueForKey:@"Albums"];
	self.covers = [NSMutableArray arrayWithCapacity:1];
	for (id album in dict) {
		[self.covers addObject:[UIImage imageNamed:[album objectAtIndex:1]]];
	}

	return self;
}

- (void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
	[self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void) viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void) viewDidLoad {
    [super viewDidLoad];


	CGFloat x = self.view.bounds.size.height + 10;
	CGFloat y = self.view.bounds.size.width;

	coverflow = [[TKCoverflowView alloc] initWithFrame:CGRectMake(0, 0, x, y)];
	coverflow.coverflowDelegate = self;
	coverflow.dataSource = self;
	[self.view addSubview:coverflow];
	[coverflow setNumberOfCovers:[covers count]];

	exitButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	UIImage* buttonImage = [UIImage imageNamed:@"close.png"];
	[exitButton setImage:buttonImage forState:UIControlStateNormal];
	[exitButton addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
	exitButton.frame = CGRectMake(x-60, y-30, 60, 25);
	[self.view addSubview:exitButton];

	infoButton = [[UIButton buttonWithType:UIButtonTypeInfoLight] retain];
	[infoButton addTarget:self action:@selector(info) forControlEvents:UIControlEventTouchUpInside];
	infoButton.frame = CGRectMake(0, y-30, 50, 30);
	[self.view addSubview:infoButton];
}

-(void) info{
	NSString* albumUrl = [NSString stringWithFormat:@"tt://album/%d",self.coverIndex];
	[[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:albumUrl] applyAnimated:YES]];
}

- (void) exit{
	[self dismissModalViewControllerAnimated:YES];
}


- (void) coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasBroughtToFront:(int)index{
	self.coverIndex = index;
}

- (TKCoverflowCoverView*) coverflowView:(TKCoverflowView*)coverflowView coverAtIndex:(int)index{

	TKCoverflowCoverView *cover = [coverflowView dequeueReusableCoverView];

	if(cover == nil){
		cover = [[[TKCoverflowCoverView alloc] initWithFrame:CGRectMake(0, 0, 224, 300)] autorelease]; // 224
		cover.baseline = 224;
	}

	cover.image = [covers objectAtIndex:index%[covers count]];

	return cover;

}

- (void) coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasDoubleTapped:(int)index{
	[self info];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)dealloc {
	[super dealloc];
}

@end
