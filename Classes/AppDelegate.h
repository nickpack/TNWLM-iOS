//
//  TNWLM2AppDelegate.h
//  TNWLM2
//
//  Created by Nick on 18/09/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#import "Reachability.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface AppDelegate : NSObject <UIApplicationDelegate> {
	NSManagedObjectModel*         _managedObjectModel;
	NSManagedObjectContext*       _managedObjectContext;
	NSPersistentStoreCoordinator* _persistentStoreCoordinator;
	BOOL _modelCreated;
	BOOL _resetModel;
	BOOL shouldOpenStream;
	BOOL uiIsVisible;
	Reachability* hostReach;
}

@property (nonatomic, retain, readonly) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, readonly)         NSString*               applicationDocumentsDirectory;
@property (nonatomic) BOOL				uiIsVisible;
@property (nonatomic) BOOL				shouldOpenStream;

- (void) reachabilityChanged: (NSNotification* )note;
- (void) updateReachability: (Reachability*) curReach;

@end

