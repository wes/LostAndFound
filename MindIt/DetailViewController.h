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
@class ReportObj;

@interface DetailViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
    IBOutlet UILabel    *itemFound;
    IBOutlet UILabel    *itemDescription;
    IBOutlet MKMapView  *locationMap;
    IBOutlet UIButton   *claimMine;
    IBOutlet UIButton   *rewardFinder;
    
    BOOL myItem;
    RewardViewController *rewardVC;
}
@property (retain, nonatomic) UILabel *itemFound;
@property (retain, nonatomic) UILabel *itemDescription;
@property (retain, nonatomic) MKMapView *locationMap;
@property (retain, nonatomic) UIButton *claimMine;
@property (retain, nonatomic) UIButton *rewardFinder;
@property (retain, nonatomic) ReportObj *report;

- (id)initWithReport:(ReportObj *)report;
-(NSString *)GetItemFound;
-(NSString *)GetItemDescription;
-(MKMapView *)GetLocationMap;

@property (retain) RewardViewController *rewardVC;

@end
