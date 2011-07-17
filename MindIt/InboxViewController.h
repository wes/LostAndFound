//
//  InboxViewController.h
//  MindIt
//
//  Created by Sveta on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageObj.h"
#import "MindItAppDelegate.h"
@interface InboxViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    MessageObj *msg;
    NSArray *aDict;
}

@property (nonatomic, retain) MindItAppDelegate *appDelegate;
@property (nonatomic, retain) IBOutlet UITableView *tblMessages;
@property (nonatomic, retain) MessageObj *msg;
@property (retain,nonatomic) NSArray *aDict;
@end
