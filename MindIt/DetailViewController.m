//
//  DetailViewController.m
//  ilfdb
//
//  Created by John on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "RewardViewController.h"
#import "ReportObj.h"

@implementation DetailViewController
@synthesize itemFound;
@synthesize itemDescription, locationMap,claimMine,rewardFinder;
@synthesize rewardVC;
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
    _report = nil;
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
    self.title = @"Details";
    itemFound.text = [self GetItemFound];
    itemDescription.text = [self GetItemDescription];
    locationMap = [self GetLocationMap];
    [claimMine setTitle: @"Contact!" forState:UIControlStateNormal];
    [rewardFinder setTitle: @"Reward" forState:UIControlStateNormal];  
    myItem = FALSE;
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
    return @"The lost item";
}

-(NSString *)GetItemDescription
{
    return @"A long description of the lost item. Make sure this is three lines long to make it look good.";
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
}

-(IBAction)rewardPressed:(id)sender 
{    
    rewardVC = [[RewardViewController alloc]init];
    [self.navigationController pushViewController:rewardVC animated:YES];
}


@end
