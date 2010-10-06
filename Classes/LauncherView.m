#import "LauncherView.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation LauncherView

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    self.title = @"TNWLM";
  }
  return self;
}

- (void)dealloc {
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (void)loadView {
  [super loadView];
  UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
  _launcherView = [[TTLauncherView alloc] initWithFrame:self.view.bounds];
  _launcherView.backgroundColor = background;
  _launcherView.delegate = self;
  _launcherView.pages = [NSArray arrayWithObjects:
						 [NSArray arrayWithObjects:
						  [[[TTLauncherItem alloc] initWithTitle:@"News"
														   image:@"bundle://News.png"
															 URL:@"tt://streamer" canDelete:YES] autorelease],
      [[[TTLauncherItem alloc] initWithTitle:@"Listen"
                               image:@"bundle://Listen.png"
                               URL:@"tt://streamer" canDelete:NO] autorelease],
      [[[TTLauncherItem alloc] initWithTitle:@"Members"
                               image:@"bundle://Members.png"
                               URL:@"fb://item3" canDelete:NO] autorelease],
      [[[TTLauncherItem alloc] initWithTitle:@"Videos"
                               image:@"bundle://Videos.png"
                               URL:@"fb://item4" canDelete:NO] autorelease],
      [[[TTLauncherItem alloc] initWithTitle:@"Releases"
                               image:@"bundle://Releases.png"
                               URL:nil canDelete:NO] autorelease],
      [[[TTLauncherItem alloc] initWithTitle:@"Pictures"
                               image:@"bundle://Pictures.png"
                               URL:nil canDelete:NO] autorelease],
	  nil],
	nil
    ];
  [self.view addSubview:_launcherView];
  [background release];
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

- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item 
{
    TTNavigator *navigator = [TTNavigator navigator];
    [navigator openURLAction:[TTURLAction actionWithURLPath:item.URL]];
}

- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher {
  [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc]
    initWithBarButtonSystemItem:UIBarButtonSystemItemDone
    target:_launcherView action:@selector(endEditing)] autorelease] animated:YES];
}

- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher {
  [self.navigationItem setRightBarButtonItem:nil animated:YES];
}

@end