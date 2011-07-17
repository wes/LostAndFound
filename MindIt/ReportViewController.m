//
//  ReportViewController.m
//  MindIt
//
//  Created by Sohel Siddique on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ReportViewController.h"
#import "RecordsManager.h"

#import "SelectionListViewController.h"

@implementation ReportViewController
@synthesize mapView, centerLng, centerLat, report, what, text;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    
    self.title = @"Report";

//    [self.navigationItem.rightBarButtonItem setText:@"Save"];

    mapOverlay.image = [UIImage imageNamed:@"mapoverlay.png"];
    
    
  /*   CLLocationCoordinate2D zoomLocation;
    mapView.showsUserLocation = YES;
    zoomLocation.latitude = mapView.userLocation.coordinate.latitude;//  39.281516;
    zoomLocation.longitude = mapView.userLocation.coordinate.longitude;// -76.580806;
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    // 3
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];                
    // 4
    [mapView setRegion:adjustedRegion animated:YES];       */ 
}



-(IBAction)textFieldFocused:(id) sender {
    text.frame = CGRectMake(0.0, 45.0, 320.0, 150.0);
    text.returnKeyType = UIReturnKeyDone;
    [what setHidden:true];
}

-(IBAction)textFieldDone:(id) sender {
    text.frame = CGRectMake(0.0, 45.0, 320.0, 150.0);
    [what setHidden:false];
}

- (void)dealloc
{

    [super dealloc];
    [mapView release];
	[lostOptions release];
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
    
//    [what addTarget:self action:@selector(whatClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    UIButton *btn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
//    [self.navigationItem.rightBarButtonItem :[[UIBarButtonItem alloc] initWithCustomView:btn]];
	
    lostOptions = [[NSMutableArray alloc] init];
	[lostOptions addObject:@"Wallet"];
	[lostOptions addObject:@"Keys"];
	[lostOptions addObject:@"Car"];
	[lostOptions addObject:@"Pet"];

}

- (IBAction) whatClicked:(id) sender {
    SelectionListViewController *controller = [[SelectionListViewController alloc] init];
    controller.delegate = self;
    controller.list = lostOptions;
//    controller.initialSelection = theIndexOfTheCurrentlySelectedItem;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}

- (void)rowChosen:(NSInteger)row {
    [self.what setTitle:[lostOptions objectAtIndex:row] forState:UIControlStateNormal];
}

- (void)setEditingButtons {

    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(done)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    [self.navigationItem.leftBarButtonItem setAlpha: 0];
    [leftBarButtonItem release];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    [self.navigationItem.rightBarButtonItem setAlpha: 0];
    [rightBarButtonItem release];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation  {
    CLLocationCoordinate2D loc = [newLocation coordinate];
    [mapView setCenterCoordinate:loc];      
}

-(IBAction)navigationButtonEvent:(id)sender
{
	if([sender tag] == 1)
	{
        //lot
		[self.navigationController popViewControllerAnimated:TRUE];
	}
	else
	{
        //found
        report.title = self.what.titleLabel.text;
        report.subtitle = self.text.text;
        report.lat = self.centerLat;
        report.lng = self.centerLng;
        report.categoryid = 0;
        RecordsManager *rm = [[RecordsManager alloc]init];
        [rm addReport:report];
        [rm release];
		
	}
}



- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    self.centerLat = self.mapView.centerCoordinate.latitude;
    self.centerLng = self.mapView.centerCoordinate.longitude;
    
//    NSLog(@"%f,%f",self.centerLat, self.centerLng);
    
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
- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
