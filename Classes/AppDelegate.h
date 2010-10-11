//
//  TNWLM2AppDelegate.h
//  TNWLM2
//
//  Created by Nick on 18/09/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface AppDelegate : NSObject <UIApplicationDelegate> {
  NSManagedObjectModel*         _managedObjectModel;
  NSManagedObjectContext*       _managedObjectContext;
  NSPersistentStoreCoordinator* _persistentStoreCoordinator;

  // App State
  BOOL                          _modelCreated;
  BOOL                          _resetModel;
	BOOL shouldOpenStream;	
  BOOL uiIsVisible;
}

@property (nonatomic, retain, readonly) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, readonly)         NSString*               applicationDocumentsDirectory;
@property (nonatomic) BOOL uiIsVisible;
@property (nonatomic) BOOL shouldOpenStream;

@end

