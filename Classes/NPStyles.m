//
//  NPStyles.m
//  TNWLM2
//
//  Created by Nick on 29/09/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//

#import "Three20/Three20.h"
#import "NPStyles.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NPStyles

- (UIColor*)navigationBarTintColor {
	return RGBCOLOR(116, 14, 14);
}

-(UIColor*)tabBarTintColor {
	return RGBCOLOR(116, 14, 14);
}

/*- (UIFont*)font {
	return [UIFont fontWithName:@"AmericanTypewriter" size:14];
}*/

- (UIColor*)toolbarTintColor {
	return RGBCOLOR(0, 0, 0);
}

- (UIColor*)tableSubTextColor {
	return [UIColor grayColor];
}

/*- (UIColor*)tableGroupedBackgroundColor {
	return [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
}*/

- (TTStyle*)launcherButton:(UIControlState)state {
	return
    [TTPartStyle styleWithName:@"image" style:TTSTYLESTATE
	 (launcherButtonImage:, state) next:
	 [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:13]
						  color:RGBCOLOR(255, 255, 255)
				minimumFontSize:11 shadowColor:nil
				   shadowOffset:CGSizeZero next:nil]];
}

- (UIColor*)timestampTextColor {
	return RGBCOLOR(116, 14, 14);
}

- (UIColor*)moreLinkTextColor {
	return RGBCOLOR(116, 14, 14);
}

- (UITableViewCellSelectionStyle)tableSelectionStyle {
	return UITableViewCellSelectionStyleGray;
}

@end

