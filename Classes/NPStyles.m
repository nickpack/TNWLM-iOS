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

- (UIColor*)toolbarTintColor {
	return RGBCOLOR(0, 0, 0);
}

/*- (UITableViewCellSelectionStyle)tableSelectionStyle {
	return UITableViewCellSelectionStyleGray;
}

- (UIColor*)tablePlainBackgroundColor {
	return [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
}

- (UIImage*)tableRefreshHeaderArrowImage {
	return TTIMAGE(@"bundle://Three20.bundle/images/blackArrow.png");
}*/

- (TTStyle*)launcherButton:(UIControlState)state { 
	return 
    [TTPartStyle styleWithName:@"image" style:TTSTYLESTATE 
	 (launcherButtonImage:, state) next: 
	 [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:11] 
						  color:RGBCOLOR(0, 0, 0) 
				minimumFontSize:11 shadowColor:nil 
				   shadowOffset:CGSizeZero next:nil]]; 
} 
@end

