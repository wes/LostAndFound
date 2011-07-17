//
//  ReportViewController.h
//  MindIt
//
//  Created by Sohel Siddique on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ReportObj.h"
#import "LFTableViewController.h"

#import "WhatTableCell.h"
#import "WhereTableCell.h"
#import "WhereMapTableCell.h"
#import "DescriptionTableCell.h"

#define METERS_PER_MILE 1609.344


@interface ReportViewController : LFTableViewController <UITableViewDataSource, UITableViewDelegate, JSONConsumerDelegate,CLLocationManagerDelegate, MKMapViewDelegate> {
    BOOL _doneInitialZoom;
    MKMapView *mapView;
    CLLocationManager *locationManager;
    IBOutlet UIImageView *mapOverlay;
    float centerLat;
    float centerLng;
    ReportObj *report;
    IBOutlet UIButton *what;
    IBOutlet UITextField *text;
	NSMutableArray *lostOptions;
    BOOL isFound;
}
@property (nonatomic, readwrite) BOOL isFound;
@property float centerLat;
@property float centerLng;

@property (nonatomic, retain) IBOutlet WhatTableCell        *whatTableCell;
@property (nonatomic, retain) IBOutlet WhereTableCell       *whereTableCell;
@property (nonatomic, retain) IBOutlet WhereMapTableCell    *whereMapTableCell;
@property (nonatomic, retain) IBOutlet DescriptionTableCell *descriptionTableCell;
@property (nonatomic, retain) IBOutlet UISegmentedControl   *segmentedControl;
@property (nonatomic, retain) NSArray *tableCells;

@property IBOutlet UIImageView *mapOverlay;

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet ReportObj *report;
@property (nonatomic, retain) IBOutlet UIButton *what;
@property (nonatomic, retain) IBOutlet UITextField *text;

- (IBAction)toggleLostFoundAction:(id)sender;

-(void)setEditingButtons;

-(void)getTableCells;

- (IBAction) textFieldFocused:(id) sender;
- (IBAction) textFieldDone:(id) sender;
- (IBAction) whatClicked:(id) sender;

@end
