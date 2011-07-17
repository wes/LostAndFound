//
//  DetailViewController.h
//  ilfdb
//
//  Created by John on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "RewardViewController.h"
#import "Annotation.h"

#define METERS_PER_MILE 1609.344

@class ReportObj;

@interface DetailViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
    CLLocationManager *locationManager;
    IBOutlet UILabel *itemFound;
    IBOutlet UILabel *itemDescription;
    IBOutlet MKMapView *locationMap;
    IBOutlet UIButton *claimMine;
    IBOutlet UIButton *rewardFinder;
    IBOutlet UIButton *flagButton;
    
    BOOL myItem;
    RewardViewController *rewardVC;
}
@property (retain, nonatomic) CLLocationManager *locationManager;
@property (retain,nonatomic) IBOutlet UILabel *lblThanks;
@property (retain, nonatomic) UILabel *itemFound;
@property (retain, nonatomic) UILabel *itemDescription;
@property (retain, nonatomic) MKMapView *locationMap;
@property (retain, nonatomic) UIButton *claimMine;
@property (retain, nonatomic) UIButton *rewardFinder;
@property (retain, nonatomic) UIButton *flagButton;
@property (retain, nonatomic) ReportObj *report;
@property (retain,nonatomic)AddressAnnotation *addAnnotation;
- (id)initWithReport:(ReportObj *)report;
-(NSString *)GetItemFound;
-(NSString *)GetItemDescription;
-(MKMapView *)GetLocationMap;

@property (retain) RewardViewController *rewardVC;
- (IBAction) flagPost;
@end
