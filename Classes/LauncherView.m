#import "LauncherView.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation LauncherView

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    self.title = @"Home";
  }
	
  return self;
}

- (void)dealloc {
	_launcherView = nil;
	TT_RELEASE_SAFELY(_launcherView);
	[super dealloc];
}

- (void)restorePages {
	NSData *pages = [[NSUserDefaults standardUserDefaults] objectForKey:@"launcher.pages"];
	if (pages != nil) {
		_launcherView.pages = [NSKeyedUnarchiver unarchiveObjectWithData:pages];
	} else {
		_launcherView.pages = [NSArray arrayWithObjects:
		 [NSArray arrayWithObjects:
		  [[[TTLauncherItem alloc] initWithTitle:@"News"
										   image:@"bundle://News.png"
											 URL:@"tt://news" canDelete:NO] autorelease],
		  [[[TTLauncherItem alloc] initWithTitle:@"Listen"
										   image:@"bundle://Listen.png"
											 URL:@"tt://streamer" canDelete:NO] autorelease],
		  [[[TTLauncherItem alloc] initWithTitle:@"Bio"
										   image:@"bundle://Members.png"
											 URL:@"tt://members" canDelete:NO] autorelease],
		  [[[TTLauncherItem alloc] initWithTitle:@"Videos"
										   image:@"bundle://Videos.png"
											 URL:@"tt://videos" canDelete:NO] autorelease],
		  [[[TTLauncherItem alloc] initWithTitle:@"Releases"
										   image:@"bundle://Releases.png"
											 URL:@"tt://releases" canDelete:NO] autorelease],
		  [[[TTLauncherItem alloc] initWithTitle:@"Photos"
										   image:@"bundle://Pictures.png"
											 URL:@"tt://photos" canDelete:NO] autorelease],
		  nil],
		 nil];	
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (void)loadView {
  [super loadView];
  //UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
  _launcherView = [[TTLauncherView alloc] initWithFrame:self.view.bounds];
  _launcherView.backgroundColor = RGBCOLOR(116, 14, 14);
  _launcherView.delegate = self;
  [self restorePages];
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
	[[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:item.URL] applyAnimated:YES]];
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
