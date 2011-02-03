//
//  MembersView.h
//  TNWLM2
//
//  Created by Nick on 28/12/2010.
//  Copyright 2010 Nikki James Pack. All rights reserved.
//
#import <Three20/Three20.h>

@interface MembersView : TTTableViewController<TTTabDelegate> {
	TTTabBar* _memberTabs;
	TTSectionedDataSource* bandBio;
	TTSectionedDataSource* steveBio;
	TTSectionedDataSource* leeBio;
	TTSectionedDataSource* tobyBio;
}
@property (readonly) TTSectionedDataSource *bandBio;
@property (readonly) TTSectionedDataSource *steveBio;
@property (readonly) TTSectionedDataSource *leeBio;
@property (readonly) TTSectionedDataSource *tobyBio;

@end
