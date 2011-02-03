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
	return RGBCOLOR(44, 44, 44);
}

-(UIColor*)tabBarTintColor {
	return RGBCOLOR(44, 44, 44);
}

- (UIFont*)font {
	return [UIFont fontWithName:@"AmericanTypewriter" size:14];
}

- (UIColor*)toolbarTintColor {
	return RGBCOLOR(44, 44, 44);
}

/*- (UIColor*)tableHeaderTintColor {
	return RGBCOLOR(44, 44, 44);
}*/

- (UIColor*)tableSubTextColor {
	return [UIColor grayColor];
}

- (TTStyle*)launcherButton:(UIControlState)state {
	return
    [TTPartStyle styleWithName:@"image" style:TTSTYLESTATE
	 (launcherButtonImage:, state) next:
	 [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:12]
						  color:RGBCOLOR(255, 255, 255)
				minimumFontSize:11 shadowColor:[UIColor blackColor]
				   shadowOffset:CGSizeMake(2, -2) next:nil]];
}

- (UITableViewCellSelectionStyle)tableSelectionStyle {
	return UITableViewCellSelectionStyleGray;
}

@end

