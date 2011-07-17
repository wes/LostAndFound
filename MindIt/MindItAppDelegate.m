//
//  MindItAppDelegate.m
//  MindIt
//
//  Created by Sohel Siddique on 6/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MindItAppDelegate.h"
#import "RecordsManager.h"
#import "PayPal.h"

@implementation MindItAppDelegate

  
@synthesize window=_window;

@synthesize tabBarController=_tabBarController;
@synthesize arr_Records;
@synthesize arr_Messages;
@synthesize navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    arr_Records=[[NSMutableArray alloc] init];
    
    arr_Messages=[[NSMutableArray alloc] init];
    
    /*
    RecordsManager *recManager = [[RecordsManager alloc]init];
    [recManager selectRecords];
    [recManager release];
     */
    [[NSBundle mainBundle] loadNibNamed:@"TabBarController" owner:self options:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.tabBarController];
    self.window.rootViewController = self.navigationController;
	//[self.tabBarController  navigationController
    [self.window makeKeyAndVisible];
	
	[PayPal initializeWithAppID:@"APP-80W284485P519543T" forEnvironment:ENV_NONE];
	
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
