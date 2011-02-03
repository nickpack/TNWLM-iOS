#import "LauncherView.h"
#import "CommonData.h"
///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation LauncherView

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    self.title = @"Home";
	  UIImage *image = [UIImage imageNamed:@"navlogo.png"];
	  UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	  self.navigationItem.titleView = imageView;

  }

  return self;
}

- (void) viewDidLoad {
	[super viewDidLoad];
	UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
																   style:UIBarButtonItemStyleBordered
																  target:self
																  action:@selector(showActionSheet:)];
	self.navigationItem.leftBarButtonItem = menuButton;

}

- (void)showActionSheet:(id)sender{
	TTActionSheetController * controller = [[[TTActionSheetController alloc] init] autorelease];
	controller.delegate = self;
	[controller addDestructiveButtonWithTitle:@"Reset Launcher Items" URL:nil];
	[controller addButtonWithTitle:@"Help" URL:nil];
	[controller addButtonWithTitle:@"About" URL:nil];
	[controller addCancelButtonWithTitle:@"Cancel" URL:nil];
	[controller showInView:self.view animated:YES];
}

- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case 0:
			// Reset launcher items
			[self restorePages:YES];
			break;
		case 1:
			// Halp, I are failz
			//
			[[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:@"http://thenursewholovedme.com/app/"] applyAnimated:YES]];
			break;
		case 2:
			// About
			[[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:@"tt://about"] applyAnimated:YES]];
			break;
	}
}


- (void)dealloc {
	_launcherView = nil;
	TT_RELEASE_SAFELY(_launcherView);
	[super dealloc];
}

- (void)restorePages:(BOOL)forceReset {
	NSData *pages = nil;

	if (!forceReset) {
		pages = [[NSUserDefaults standardUserDefaults] objectForKey:@"launcher.pages"];
	}

	if (pages != nil) {
		_launcherView.pages = [NSKeyedUnarchiver unarchiveObjectWithData:pages];
	} else {
		_launcherView.pages = [NSArray arrayWithObjects:
		 [NSArray arrayWithObjects:
		  [[[TTLauncherItem alloc] initWithTitle:@"News"
										   image:@"bundle://News.png"
											 URL:@"tt://news" canDelete:YES] autorelease],
		  [[[TTLauncherItem alloc] initWithTitle:@"Listen"
										   image:@"bundle://Listen.png"
											 URL:@"tt://streamer" canDelete:YES] autorelease],
		  [[[TTLauncherItem alloc] initWithTitle:@"Bio"
										   image:@"bundle://Members.png"
											 URL:@"tt://members" canDelete:YES] autorelease],
		  [[[TTLauncherItem alloc] initWithTitle:@"Videos"
										   image:@"bundle://Videos.png"
											 URL:@"tt://videos" canDelete:YES] autorelease],
		  [[[TTLauncherItem alloc] initWithTitle:@"Releases"
										   image:@"bundle://Releases.png"
											 URL:@"tt://releases" canDelete:YES] autorelease],
		  [[[TTLauncherItem alloc] initWithTitle:@"Photos"
										   image:@"bundle://Pictures.png"
											 URL:@"tt://photos" canDelete:YES] autorelease],
		  nil],
		 nil];
	}

	if (forceReset) {
		NSData *pages = [NSKeyedArchiver archivedDataWithRootObject:_launcherView.pages];
		[[NSUserDefaults standardUserDefaults] setObject:pages forKey:@"launcher.pages"];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (void)loadView {
	[super loadView];

	CAGradientLayer *gradient = [CAGradientLayer layer];
	gradient.frame = self.view.bounds;
	gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor grayColor] CGColor], (id)[[UIColor blackColor] CGColor],nil];
	[self.view.layer insertSublayer:gradient atIndex:0];
	_launcherView = [[TTLauncherView alloc] initWithFrame:self.view.bounds];
	_launcherView.backgroundColor = [UIColor clearColor];
	_launcherView.delegate = self;
	[self restorePages:NO];
	[self.view addSubview:_launcherView];
  //[background release];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTLauncherViewDelegate

- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {
	CommonData* commonData = [CommonData sharedCommonData];
	if (commonData.internetReachable == NO) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Error" message:@"Sorry, this feature requires an active internet connection. Please reconnect and try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
	} else {
		[[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:item.URL] applyAnimated:YES]];
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	[alertView release];
}

- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher {
  [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc]
    initWithBarButtonSystemItem:UIBarButtonSystemItemDone
    target:_launcherView action:@selector(endEditing)] autorelease] animated:YES];
}

- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher {
	[self.navigationItem setRightBarButtonItem:nil animated:YES];
	NSData *pages = [NSKeyedArchiver archivedDataWithRootObject:_launcherView.pages];
	[[NSUserDefaults standardUserDefaults] setObject:pages forKey:@"launcher.pages"];
}

@end
