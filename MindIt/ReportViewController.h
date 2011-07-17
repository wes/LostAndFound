//
//  ReportViewController.h
//  MindIt
//
//  Created by Sohel Siddique on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportObj.h"
#import "LFTableViewController.h"

#import "WhatTableCell.h"
#import "WhereTableCell.h"
#import "WhereMapTableCell.h"
#import "DescriptionTableCell.h"

#import "CustomCellBackgroundView.h"

@interface ReportViewController : LFTableViewController <UITableViewDataSource, UITableViewDelegate, JSONConsumerDelegate> {
    ReportObj *report;
	NSMutableArray *lostOptions;
    BOOL isFound;
    NSURLConnection *connRec;
    NSMutableData *responseData;
}

@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *connRec;

@property (nonatomic, readwrite) BOOL isFound;

@property (nonatomic, retain) IBOutlet WhatTableCell        *whatTableCell;
@property (nonatomic, retain) IBOutlet WhereTableCell       *whereTableCell;
@property (nonatomic, retain) IBOutlet WhereMapTableCell    *whereMapTableCell;
@property (nonatomic, retain) IBOutlet DescriptionTableCell *descriptionTableCell;
@property (nonatomic, retain) IBOutlet UISegmentedControl   *segmentedControl;
@property (nonatomic, retain) NSArray *tableCells;

@property (nonatomic, retain) IBOutlet ReportObj *report;
@property (nonatomic, retain) IBOutlet UITextField *text;


- (IBAction)toggleLostFoundAction:(id)sender;

- (void) setEditingButtons;
- (void) getTableCells;
- (void) whatRowClicked;

- (IBAction) textFieldFocused:(id) sender;
//- (IBAction) textFieldDone:(id) sender;

@end
