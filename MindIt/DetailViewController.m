//
//  DetailViewController.m
//  ilfdb
//
//  Created by John on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>

#import "DetailViewController.h"
#import "RewardViewController.h"
#import "ReportObj.h"
#import "MessageComposeViewController.h"

@implementation DetailViewController
@synthesize itemFound;
@synthesize itemDescription, locationMap,claimMine,rewardFinder,flagButton;
@synthesize rewardVC, locationManager,addAnnotation, lblThanks;
@synthesize report = _report;


- (id)initWithReport:(ReportObj *)report
{
    self = [super initWithNibName:@"DetailViewController" bundle:nil];
    if (self) {
        self.report = report;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"stripe.png"]]];
    locationMap.clipsToBounds = YES;
    locationMap.layer.borderColor = [[UIColor whiteColor] CGColor];
    locationMap.layer.shadowOffset = CGSizeMake(0, 3);
    locationMap.layer.shadowRadius = 5.0;
    locationMap.layer.shadowColor = [UIColor blackColor].CGColor;
    locationMap.layer.shadowOpacity = 0.8;
    locationMap.layer.borderWidth = 4.0;
    locationMap.layer.cornerRadius = 5.0;
    
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager startUpdatingLocation];
    
    [locationMap setMapType:MKMapTypeStandard];
    
    
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.span.longitudeDelta = 0.005;
    region.span.latitudeDelta = 0.005;
    [locationMap setRegion:region animated:YES]; 
    [locationMap setDelegate:self];
    [locationMap setShowsUserLocation:YES];
    locationMap.showsUserLocation = YES;   
    
    
    CLLocationCoordinate2D zoomLocation;
    locationMap.showsUserLocation = YES;
    zoomLocation.latitude =   39.281516;
    zoomLocation.longitude =  -76.580806;
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    // 3
    MKCoordinateRegion adjustedRegion = [locationMap regionThatFits:viewRegion];                
    // 4
    [locationMap setRegion:viewRegion animated:YES];
    self.title = @"Details";
    itemFound.text = [self GetItemFound];
    itemDescription.text = [self GetItemDescription];
    locationMap = [self GetLocationMap];
    
    myItem = FALSE;
    
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation  {
    CLLocationCoordinate2D loc = [newLocation coordinate];
    [locationMap setCenterCoordinate:loc];
    
    if(addAnnotation != nil) {
        [locationMap removeAnnotation:addAnnotation];
        [addAnnotation release];
        addAnnotation = nil;
    }
    addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:loc];
    [locationMap addAnnotation:addAnnotation];
}
-(void)viewWillAppear:(BOOL)animated{
    self.lblThanks.hidden = YES;
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
    MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
    annView.pinColor = MKPinAnnotationColorGreen;
    annView.animatesDrop=TRUE;
    annView.canShowCallout = YES;
    annView.calloutOffset = CGPointMake(-5, 5);
    return annView;
}
-(IBAction) flagPost{
    self.lblThanks.hidden = NO;
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark custom functions

-(NSString *)GetItemFound 
{
    return @"Keys";
}

-(NSString *)GetItemDescription
{
    return @"I found a car key with other keys near a bush. Please contact Sohel.";
}

-(MKMapView *)GetLocationMap
{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager startUpdatingLocation];
    
    [locationMap setMapType:MKMapTypeStandard];
    
    
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.span.longitudeDelta = 0.005;
    region.span.latitudeDelta = 0.005;
    [locationMap setRegion:region animated:YES]; 
    [locationMap setDelegate:self];
    [locationMap setShowsUserLocation:YES];
    locationMap.showsUserLocation = YES;   
    return locationMap;
}

    
#pragma mark -
#pragma mark Button Actions

-(IBAction)claimMinePressed:(id)sender 
{
    myItem = TRUE;
    NSLog(@"This is my item. I have claimed it");
	
	MessageComposeViewController *messageComposerView = [[MessageComposeViewController alloc] init];
	[self.navigationController pushViewController:messageComposerView animated:YES];
	[messageComposerView release];
}

-(IBAction)rewardPressed:(id)sender 
{    
    rewardVC = [[RewardViewController alloc]init];
    [self.navigationController pushViewController:rewardVC animated:YES];
}


@end
