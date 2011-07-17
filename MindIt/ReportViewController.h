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
#define METERS_PER_MILE 1609.344


@interface ReportViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
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
}

@property float centerLat;
@property float centerLng;

@property IBOutlet UIImageView *mapOverlay;

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet ReportObj *report;
@property (nonatomic, retain) IBOutlet UIButton *what;
@property (nonatomic, retain) IBOutlet UITextField *text;

-(void)setEditingButtons;

- (IBAction) textFieldFocused:(id) sender;
- (IBAction) textFieldDone:(id) sender;
- (IBAction) whatClicked:(id) sender;

@end
