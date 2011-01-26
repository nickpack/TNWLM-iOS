//
//  ReleasesView.h
//  TNWLM2
//
//  Created by Nick Pack on 23/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TapkuLibrary/TapkuLibrary.h>

@interface ReleasesView : UIViewController <TKCoverflowViewDelegate,TKCoverflowViewDataSource> {
	TKCoverflowView *coverflow;
	UIButton *exitButton;
	UIButton *infoButton;
	NSMutableArray *covers; // album covers images
	int coverIndex;
}

@property (retain,nonatomic) TKCoverflowView *coverflow;
@property (retain,nonatomic) NSMutableArray *covers;
@property (nonatomic) NSInteger coverIndex;

@end
