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

	return self;
}

- (void) viewWillAppear:(BOOL)animated{
	NSLog(@"ViewWillAppear");
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
	NSString *path=[[NSBundle mainBundle] pathForResource:@"albums" ofType:@"plist"];
	NSMutableArray* dict = [[NSMutableDictionary dictionaryWithContentsOfFile:path] valueForKey:@"Albums"];
	covers = [NSMutableArray arrayWithCapacity:1];
	for (id album in dict) {
		[covers addObject:[UIImage imageNamed:[album objectAtIndex:1]]];
	}

	path = nil;
	dict = nil;
	[path release];
	[dict release];
	coverflow = [[TKCoverflowView alloc] initWithFrame:CGRectMake(0, 0, x, y)];
	coverflow.coverflowDelegate = self;
	coverflow.dataSource = self;
	[self.view addSubview:coverflow];
	[coverflow setNumberOfCovers:[covers count]];
	
	exitButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	[exitButton setTitle:@"Close" forState:UIControlStateNormal];
	[exitButton addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
	exitButton.frame = CGRectMake(x-80, y-30, 60, 25);
	[self.view addSubview:exitButton];

	infoButton = [[UIButton buttonWithType:UIButtonTypeInfoLight] retain];
	[infoButton addTarget:self action:@selector(info) forControlEvents:UIControlEventTouchUpInside];
	infoButton.frame = CGRectMake(0, y-30, 50, 30);
	[self.view addSubview:infoButton];
}

-(void) info{
	NSString* albumUrl = [NSString stringWithFormat:@"tt://album/%d",self.coverIndex];
	[[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:albumUrl] applyAnimated:YES]];
	albumUrl = nil;
	TT_RELEASE_SAFELY(albumUrl);
}

- (void) exit{
	infoButton = nil;
	coverflow = nil;
	covers = nil;
	[infoButton release];
	[coverflow release];
	[covers release];
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
	NSLog(@"YOU FUCKING SUCK");
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	infoButton = nil;
	coverflow = nil;
	covers = nil;
	[infoButton release];
	[coverflow release];
	[covers release];
    [super dealloc];
}

@end
