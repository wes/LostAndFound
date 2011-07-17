//
//  LFViewController
//  hmtNew
//
//  Created by Wes Edling on 1/25/11.
//  Copyright 2011 Stone Design Corp. All rights reserved.
//

#import "LFViewController.h"
//#import "Loading.h"

@implementation LFViewController
//@synthesize eventLabel;

- (NSString *)navigationTitle {
	return @"IMPLEMENT navigationTitle";
}
//
//- (void)eventChanged:(NSNotification *)notification {
//	Event *event = (Event *)[notification object];
//	eventLabel.text = [event prettyName];
//}

- (NSString *)buttonImageName {
	return @"test.png";
}

- (id)init {
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        self.title = [self navigationTitle];
        self.tabBarItem.image = [UIImage imageNamed:[self buttonImageName]];
//		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eventChanged:) name:CurrentEventChangedNotification object:nil];
    }
    return self;
}

//-(void)showLoaderScreen {
//    
////    [[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
//    
////    Loading *loadingController = [[Loading alloc] initWithNibName:@"Loading" bundle:nil];
//    
////    [self.view addSubview:loadingController animated:YES];
////    [[NSBundle mainBundle] loadNibNamed:@"Loading" owner:self options:0];
////    self.myCustomView.frame=self.view.bounds; // make view fill screen - customize as necessary
////    [self.view addSubview:self.myCustomView];
//
////    Loading *loadingView = [[Loading alloc] initWithNibName:@"Loading" bundle:nil];
//////    loadingView = loading;
//////    [loading release];
////    loadingView.view.frame = self.view.frame;
////    loadingView.view.autoresizingMask = self.view.autoresizingMask;
//////    [customView removeFromSuperview];
////    
////    [UIView beginAnimations:@"ASDF" context:nil];
////    [UIView setAnimationDuration:1.0];
////    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown
////                           forView:loadingView.view
////                             cache:YES];
////    
//
////    [self.view addSubview:loadingView.view];
//    
//    Loading *loadingView = [[Loading alloc] initWithNibName:@"Loading" bundle:nil];
//    
////    [UIView beginAnimations:nil context:nil];
////    [UIView setAnimationDuration:1.0];
////    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown
////                           forView:loadingView.view
////                             cache:YES];
//
//    
//    [self.view addSubview:loadingView.view];
//
//    
//}

//-(void)hideLoaderScreen{
//
//    [loadingView setHidden: YES];
//    
//}

//-(void)didReceivePropertyList:(id)propertyList headers:(NSDictionary *)header code:(int)code{
//    [self hideLoaderScreen];
//}
//
//-(void)networkOfflineWithRequest:(NSString *)request{
//    [self hideLoaderScreen];
//}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
//	eventLabel = [[UILabel alloc ] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 30.0) ];
//	eventLabel.textAlignment =  UITextAlignmentCenter;
//	eventLabel.textColor = [UIColor colorWithWhite:0.98 alpha:1.0];
//	eventLabel.textColor = [UIColor whiteColor];
//	eventLabel.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"event-bg.png"]];
//	eventLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
//	eventLabel.font = [UIFont fontWithMarkupDescription:@"font-family: Helvetica; color: #cccccc; font-size: 12px; font-weight: bold;"];
//	[self.view addSubview:eventLabel];
//	eventLabel.text = @"";    
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
//	eventLabel.text = [[[EventManager eventManager] currentEvent] prettyName];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
	return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (void)didReceivePropertyList:(id)propertyList headers:(NSDictionary *)header code:(int)code{
//	DLog([propertyList description]);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
//	self.eventLabel = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
//	[eventLabel release];
    [super dealloc];
}

//- (void)networkOfflineWithRequest:(NSString *)request {
//	
//}


//- (NSString *)archiveKey; // if nil, don't cache, otherwise cache under this key for a file name
//{
//	return nil;
//}
//- (id)propertyListRepresentation; // if nil, don't cache
//{
//	return nil;
//}

//- (void)loadFromPropertyList:(id)list {
//	
//}

@end
