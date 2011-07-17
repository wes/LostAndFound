//
//  HMTTableViewController.h
//  hmtNew
//
//  Created by Androidicus Maximus on 1/25/11.
//  Copyright 2011 Stone Design Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFViewController.h"

@interface LFTableViewController : LFViewController <UITableViewDelegate> {
	UITableView *theTableView;
}
@property (nonatomic, retain) IBOutlet UITableView *theTableView;
@property (nonatomic, readwrite) UITableViewStyle tvStyle;
@end
