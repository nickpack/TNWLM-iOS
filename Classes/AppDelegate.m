//
//  TNWLM2AppDelegate.m
//  TNWLM2
//
//  Created by Nick on 18/09/2010.
//  Copyright Nikki James Pack 2010. All rights reserved.
//

#import "AppDelegate.h"
#import "LauncherView.h"
#import "ReleasesView.h"
#import "NewsView.h"
#import "AudioPlayer.h"
#import "AudioStreamer.h"
#import "MembersView.h"
#import "VideosView.h"
#import "NPStyles.h"
#import "PhotosView.h"
#import "AlbumView.h"
#import "NewsItemView.h"
#import "AboutView.h"
#import "TwitterView.h"
#import "Reachability.h"
#import "iRate.h"

#define kStoreType      NSSQLiteStoreType
#define kStoreFilename  @"db.sqlite"
#define kHostName @"thor.nickpack.com"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface AppDelegate()
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSString *)applicationDocumentsDirectory;

@end
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation AppDelegate

@synthesize uiIsVisible;
@synthesize shouldOpenStream;

+ (void)initialize
{
	// Nobody really uses this app much so set the limits low
	[iRate sharedInstance].appStoreID = 418966284;
	[iRate sharedInstance].applicationName = @"TNWLM";
	[iRate sharedInstance].daysUntilPrompt = 1;
	[iRate sharedInstance].usesUntilPrompt = 2;
	[iRate sharedInstance].debug = NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication *)app didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  	[[NSNotificationCenter defaultCenter] addObserver: self selector:  @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
	hostReach = [[Reachability reachabilityWithHostName: kHostName] retain];
    [hostReach startNotifier];

	[TTStyleSheet setGlobalStyleSheet:[[[NPStyles alloc] init] autorelease]];
	TTNavigator* navigator = [TTNavigator navigator];
	navigator.persistenceMode = TTNavigatorPersistenceModeAll;

	TTURLMap* map = navigator.URLMap;

	[map from:@"*" toViewController:[TTWebController class]];
	[map from:@"tt://launcher" toSharedViewController:[LauncherView class]];
	[map from:@"tt://streamer" toSharedViewController:[AudioPlayer class]];
	[map from:@"tt://releases" toModalViewController:[ReleasesView class]];
	[map from:@"tt://about" toModalViewController:[AboutView class]];
	[map from:@"tt://album/(initWithIndex:)" toModalViewController:[AlbumView class]];
	[map from:@"tt://news" toViewController:[NewsView class]];
	[map from:@"tt://members" toViewController:[MembersView class]];
	[map from:@"tt://videos" toViewController:[VideosView class]];
	[map from:@"tt://photos" toViewController:[PhotosView class]];
	[map from:@"tt://viewnews" toViewController:[NewsItemView class]];
    [map from:@"tt://twitter" toViewController:[TwitterView class]];
	/* Check for push notifications and open the request action if we have one
	NSDictionary *remoteNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotif) {
		NSString *itemName = [NSString stringWithFormat:@"tt://%@",[remoteNotif objectForKey:@"action"]];
		[navigator openURLAction:[TTURLAction actionWithURLPath:itemName]];
		DLog(@"I got some action: %@",itemName);
	} else*/

	if (![navigator restoreViewControllers]) {
		[navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://launcher"]];
	}

	//[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];

	return YES;
}

- (void) reachabilityChanged: (NSNotification* )note {
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self updateReachability: curReach];
}

- (void) updateReachability: (Reachability*) curReach {

    if(curReach == hostReach) {
		CommonData* commonData = [CommonData sharedCommonData];
        NetworkStatus netStatus = [curReach currentReachabilityStatus];
		commonData.internetReachable = (netStatus != NotReachable);

		/*if (commonData.internetReachable == NO) {
			[TTURLCache sharedCache].invalidationAge = TT_CACHE_EXPIRATION_AGE_NEVER;
		} else {
			[TTURLCache sharedCache].invalidationAge = TT_DEFAULT_CACHE_EXPIRATION_AGE;
		}*/
	}
}


/*- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    NSString *str = [NSString
					 stringWithFormat:@"%@",deviceToken];
	TTURLRequest* request = [TTURLRequest requestWithURL:@"http://thor.nickpack.com/phone.php" delegate: self];
    request.httpMethod = @"POST";
    request.cachePolicy = TTURLRequestCachePolicyNoCache;
	[request.parameters addObject:str forKey:@"device"];
    request.response = [[[TTURLDataResponse alloc] init] autorelease];
	[request send];
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	//TTURLDataResponse* deviceResponse = (TTURLDataResponse*)request.response;

	DLog(@"Device token submit finished");
}

- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
	DLog(@"Failed to send device token, try again.");
}


- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    DLog(@"Error: %@", err);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	application.applicationIconBadgeNumber = -1;
    for (id key in userInfo) {
		 DLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
    }

}*/
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_managedObjectContext);
	TT_RELEASE_SAFELY(_managedObjectModel);
	TT_RELEASE_SAFELY(_persistentStoreCoordinator);
	[super dealloc];
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)navigator:(TTNavigator*)navigator shouldOpenURL:(NSURL*)URL {
  return YES;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
  [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
	self.uiIsVisible = NO;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	self.uiIsVisible = NO;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
	self.uiIsVisible = YES;
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(presentAlertWithTitle:)
	 name:ASPresentAlertWithTitleNotification
	 object:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
	self.uiIsVisible = YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationWillTerminate:(UIApplication *)application {
  NSError* error = nil;
  if (_managedObjectContext != nil) {
    if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
      DLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }

	self.uiIsVisible = NO;
	[[NSNotificationCenter defaultCenter]
	 removeObserver:self
	 name:ASPresentAlertWithTitleNotification
	 object:nil];

}
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Core Data stack


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSManagedObjectContext*)managedObjectContext {
  if( _managedObjectContext != nil ) {
    return _managedObjectContext;
  }

  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (coordinator != nil) {
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    [_managedObjectContext setUndoManager:nil];
    [_managedObjectContext setRetainsRegisteredObjects:YES];
  }
  return _managedObjectContext;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSManagedObjectModel*)managedObjectModel {
  if( _managedObjectModel != nil ) {
    return _managedObjectModel;
  }
  _managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
  return _managedObjectModel;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)storePath {
  return [[self applicationDocumentsDirectory]
    stringByAppendingPathComponent: kStoreFilename];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSURL*)storeUrl {
  return [NSURL fileURLWithPath:[self storePath]];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSDictionary*)migrationOptions {
  return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSPersistentStoreCoordinator*)persistentStoreCoordinator {
  if( _persistentStoreCoordinator != nil ) {
    return _persistentStoreCoordinator;
  }

  NSString* storePath = [self storePath];
  NSURL *storeUrl = [self storeUrl];

	NSError* error;
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
    initWithManagedObjectModel: [self managedObjectModel]];

  NSDictionary* options = [self migrationOptions];

  // Check whether the store already exists or not.
  NSFileManager* fileManager = [NSFileManager defaultManager];
  BOOL exists = [fileManager fileExistsAtPath:storePath];

  TTDINFO(storePath);
  if( !exists ) {
    _modelCreated = YES;
  } else {
    if( _resetModel ||
        [[NSUserDefaults standardUserDefaults] boolForKey:@"erase_all_preference"] ) {
      [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"erase_all_preference"];
      [fileManager removeItemAtPath:storePath error:nil];
      _modelCreated = YES;
    }
  }

  if (![_persistentStoreCoordinator
    addPersistentStoreWithType: kStoreType
                 configuration: nil
                           URL: storeUrl
                       options: options
                         error: &error
  ]) {
    // We couldn't add the persistent store, so let's wipe it out and try again.
    [fileManager removeItemAtPath:storePath error:nil];
    _modelCreated = YES;

    if (![_persistentStoreCoordinator
      addPersistentStoreWithType: kStoreType
                   configuration: nil
                             URL: storeUrl
                         options: nil
                           error: &error
    ]) {
      // Something is terribly wrong here.
    }
  }

  return _persistentStoreCoordinator;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Application's documents directory


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)applicationDocumentsDirectory {
  return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
    lastObject];
}


- (void)presentAlertWithTitle:(NSNotification *)notification
{
	if (!uiIsVisible)
		return;
	NSString *title = [[notification userInfo] objectForKey:@"title"];
	NSString *message = [[notification userInfo] objectForKey:@"message"];
	UIAlertView *alert = [
						  [[UIAlertView alloc]
						   initWithTitle:title
						   message:message
						   delegate:self
						   cancelButtonTitle:NSLocalizedString(@"OK", @"")
						   otherButtonTitles: nil]
						  autorelease];
	[alert
	 performSelector:@selector(show)
	 onThread:[NSThread mainThread]
	 withObject:nil
	 waitUntilDone:NO];

}

@end

