//
//  MindItAppDelegate.h
//  MindIt
//
//  Created by Sohel Siddique on 6/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MindItAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    NSMutableArray *arr_Records;
    NSMutableArray *arr_Messages;
}
@property (nonatomic, retain) NSMutableArray *arr_Records;
@property (nonatomic, retain) NSMutableArray *arr_Messages;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end


