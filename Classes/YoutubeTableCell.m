//
//  YoutubeTableCell.m
//  TNWLM2
//
//  Created by Nick Pack on 24/01/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "YoutubeTableCell.h"
#import "YoutubeTextItem.h"
#import <Three20UI/UIViewAdditions.h>

const CGFloat    kYouTubeCellHeight = 75;
const CGFloat    kYouTubeCellWidth = 100;
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation YoutubeTableCell

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
	return kYouTubeCellHeight + kTableCellVPadding*2;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
		_youtubeView = [[TTYouTubeView alloc] initWithFrame:CGRectMake(kTableCellHPadding,
																	   kTableCellVPadding,
																	   kYouTubeCellWidth,
																	   kYouTubeCellHeight)];
		[self.contentView addSubview:_youtubeView];
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	UIView* cv = (UIView *)self.contentView;
	
	CGFloat innerWidth = cv.width - ((kTableCellHPadding * 4) + kYouTubeCellWidth);
	CGFloat innerHeight = cv.height - kTableCellVPadding * 2;
	
	self.textLabel.frame = CGRectMake((kTableCellHPadding * 2) + kYouTubeCellWidth, kTableCellVPadding,
									  innerWidth, innerHeight);
	
	_youtubeView.frame = CGRectMake(kTableCellHPadding,
									kTableCellVPadding,
									kYouTubeCellWidth,
									kYouTubeCellHeight);
	
}

- (void)setObject:(id)object {
	if (_item != object) {
		[super setObject:object];
		
		YoutubeTextItem* item = object;
		[_youtubeView setUrlPath:item.urlPath];
	}
}

@end

