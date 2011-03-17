//
//  TwitterView.m
//  TNWLM2
//
//  Created by Nick on 16/03/2011.
//  Copyright 2011 Nikki James Pack. All rights reserved.
//

#import "TwitterView.h"
#import "TwitterDataSource.h"

@implementation TwitterView

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"Twitter feed";
        self.variableHeightRows = YES;
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createModel {
    self.dataSource = [[[TwitterDataSource alloc]
                        initWithSearchQuery:@"tnwlm"] autorelease];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {
    return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

@end
