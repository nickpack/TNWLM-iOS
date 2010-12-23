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

- (void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque]; 
}
- (void) viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void) viewDidLoad {
    [super viewDidLoad];
	
	covers = [[NSArray arrayWithObjects:
			   [UIImage imageNamed:@"cover_2.jpg"],[UIImage imageNamed:@"cover_1.jpg"],
			   [UIImage imageNamed:@"cover_3.jpg"],[UIImage imageNamed:@"cover_4.jpg"],
			   [UIImage imageNamed:@"cover_5.jpg"],[UIImage imageNamed:@"cover_6.jpg"],
			   [UIImage imageNamed:@"cover_7.jpg"],[UIImage imageNamed:@"cover_8.jpg"],
			   [UIImage imageNamed:@"cover_9.jpeg"],nil] retain];
	
	
	coverflow = [[TKCoverflowView alloc] initWithFrame:CGRectMake(0, 0, 480, 300)];
	coverflow.delegate = self;
	coverflow.dataSource = self;
	[self.view addSubview:coverflow];
	[coverflow setNumberOfCovers:580];
	
	
	infoButton = [[UIButton buttonWithType:UIButtonTypeInfoLight] retain];
	[infoButton addTarget:self action:@selector(info) forControlEvents:UIControlEventTouchUpInside];
	infoButton.frame = CGRectMake(480-50, 300-30, 50, 30);
	[self.view addSubview:infoButton];
	
	
	
}

- (void) info{
	NSLog(@"info");
	[self dismissModalViewControllerAnimated:YES];
}


- (void) coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasBroughtToFront:(int)index{
	//NSLog(@"Front %d",index);
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
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cover cache:YES];
	[UIView commitAnimations];
	
	NSLog(@"Index: %d",index);
	
	
	
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
