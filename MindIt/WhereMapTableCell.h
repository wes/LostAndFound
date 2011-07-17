//
//  WhereMapTableCell.h
//  MindIt
//
//  Created by Wes Edling on 7/17/11.
//  Copyright 2011 Joe Designs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define METERS_PER_MILE 1609.344

@interface WhereMapTableCell : UITableViewCell <CLLocationManagerDelegate, MKMapViewDelegate> {
    IBOutlet UIImageView *mapOverlayImage;
    IBOutlet MKMapView *mapView;
    float centerLat;
    float centerLng;
    BOOL _doneInitialZoom;
    CLLocationManager *locationManager;
}

@property float centerLat;
@property float centerLng;

@property (nonatomic,retain) IBOutlet UIImageView *mapOverlayImage;
@property (nonatomic,retain) IBOutlet MKMapView *mapView;

@end
