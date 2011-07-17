//
//  WhereMapTableCell.m
//  MindIt
//
//  Created by Wes Edling on 7/17/11.
//  Copyright 2011 Joe Designs. All rights reserved.
//

#import "WhereMapTableCell.h"

@implementation WhereMapTableCell

@synthesize mapOverlayImage, mapView, centerLng, centerLat;

-(void)awakeFromNib {

    // Initialization code
    self.mapOverlayImage.image = [UIImage imageNamed:@"mapoverlay.png"];
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager startUpdatingLocation];
    
    [mapView setMapType:MKMapTypeStandard];
    
    
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.span.longitudeDelta = 0.005;
    region.span.latitudeDelta = 0.005;
    [mapView setRegion:region animated:YES]; 
    [mapView setDelegate:self];
    [mapView setShowsUserLocation:YES];
    mapView.showsUserLocation = YES;   
    
    
    //        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"stripe.png"]]];
    //        self.mapView.clipsToBounds = YES;
    //        self.mapView.layer.borderColor = [[UIColor whiteColor] CGColor];
    //        self.mapView.layer.shadowOffset = CGSizeMake(0, 3);
    //        self.mapView.layer.shadowRadius = 5.0;
    //        self.mapView.layer.shadowColor = [UIColor blackColor].CGColor;
    //        self.mapView.layer.shadowOpacity = 0.8;
    //        self.mapView.layer.borderWidth = 4.0;
    //        self.mapView.layer.cornerRadius = 5.0;

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //init
    }
    return self;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    self.centerLat = self.mapView.centerCoordinate.latitude;
    self.centerLng = self.mapView.centerCoordinate.longitude;
    
    //    NSLog(@"%f,%f",self.centerLat, self.centerLng);
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation  {
    CLLocationCoordinate2D loc = [newLocation coordinate];
    [mapView setCenterCoordinate:loc];      
}

-(MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    static NSString *AnnotationViewID = @"annotationViewID";
    MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    if (annotationView == nil) {
        annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID] autorelease];
    }
    
    annotationView.canShowCallout = YES;
    
    if ([annotationView.annotation.title isEqualToString:@"One"]) {
        UIImage *pinImage = [UIImage imageNamed:@"one.png"];
        [annotationView setImage:pinImage];
    }
    
    if ([annotationView.annotation.title isEqualToString:@"Two"]) {
        UIImage *pinImage = [UIImage imageNamed:@"two.png"];
        [annotationView setImage:pinImage];
    }
    
    annotationView.annotation = annotation;
    return annotationView;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
}

@end
