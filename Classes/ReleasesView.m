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
	covers = [[NSArray arrayWithObjects:
										[UIImage imageNamed:@"lemonheads.png"],
										[UIImage imageNamed:@"echoesinthealleyway.png"],
										[UIImage imageNamed:@"ill.png"],
										[UIImage imageNamed:@"hereagainsomewhere.png"],
										[UIImage imageNamed:@"inthisroom.png"],
										[UIImage imageNamed:@"vandalattack.png"],
										[UIImage imageNamed:@"nursecd2004.png"],nil] retain];	
	
	
	coverflow = [[TKCoverflowView alloc] initWithFrame:CGRectMake(0, 0, x, y)];
	
	coverflow.coverflowDelegate = self;
	coverflow.dataSource = self;
	[self.view addSubview:coverflow];
	[coverflow setNumberOfCovers:[covers count]];
	
	exitButton = [[UIButton buttonWithType:UIButtonTypeDetailDisclosure] retain];
	[exitButton addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
	exitButton.frame = CGRectMake(x-60, y-30, 50, 30);
	[self.view addSubview:exitButton];
	
	infoButton = [[UIButton buttonWithType:UIButtonTypeInfoLight] retain];
	[infoButton addTarget:self action:@selector(info) forControlEvents:UIControlEventTouchUpInside];
	infoButton.frame = CGRectMake(0, y-30, 50, 30);
	[self.view addSubview:infoButton];
	
}

-(void) info{
	[[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:@"tt://album"] applyAnimated:YES]];
}

- (void) exit{
	//NSLog(@"info: %@",self.coverIndex);
	
	[self dismissModalViewControllerAnimated:YES];
}


- (void) coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasBroughtToFront:(int)index{
	self.coverIndex = index;
	NSLog(@"Front %d",index);
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
	TKCoverflowCoverView *cover = [coverflowView coverAtIndex:index];
	if(cover == nil) return;
	[self info];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}
- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[infoButton release];
	[coverflow release];
	[covers release];
    [super dealloc];
}

@end
