//
//  ReportViewController.m
//  MindIt
//
//  Created by Sohel Siddique on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ReportViewController.h"
#import "RecordsManager.h"
#import "CustomCellBackgroundView.h"
#import "SelectionListViewController.h"
#import "LFTableViewController.h"

#import "WhatTableCell.h"
#import "WhereTableCell.h"
#import "WhereMapTableCell.h"
#import "DescriptionTableCell.h"


@implementation ReportViewController
@synthesize mapView, centerLng, centerLat, report, what, text, tableCells, isFound, segmentedControl;

@synthesize whatTableCell, whereTableCell, whereMapTableCell, descriptionTableCell;

- (IBAction)toggleLostFoundAction:(id)sender {
    isFound = self.segmentedControl.selectedSegmentIndex;
    
}

//- (void)awakeFromNib {
//    [self getTableCells];
//    self.title = @"Report";
//
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [self initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        self.title = @"Report";
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tabBarController.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [self getTableCells];

    [super viewWillAppear:animated];
    [self.tabBarController.navigationController setNavigationBarHidden:YES animated:YES];
    // or self.navigationItem.title = MyNewTitle;
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


-(void)getTableCells {
    self.tableCells = [NSArray arrayWithObjects: self.whatTableCell, self.whereTableCell, self.whereMapTableCell, self.descriptionTableCell, nil];
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


#pragma mark Table

//- (NSArray *)barCodes {
//	return [_buyer valueForKey:@"barcodes"];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0: // what
        case 1: // where
            return 44;
        break;
        case 2: // map
            return 170;
        break;
        case 3: // desc
            return 70;
        break;
    }
    
}

/*
 buyerNameLabel.text = [buyer name];
 
 buyerTransIdLabel.text = [buyer objectForKey:@"transid"];	
 
 buyerCityLabel.text = [buyer objectForKey:@"city"];
 buyerStateLabel.text = [buyer objectForKey:@"state"];
 buyerZipLabel.text = [buyer objectForKey:@"zip"];
 
 buyerTransTypeLabel.text = [buyer objectForKey:@"trans_type"];
 buyerDatePurchasedLabel.text = [buyer objectForKey:@"purchased"];
 
 buyerPhoneLabel.text = [buyer objectForKey:@"phone"];
 
 buyerEmailLabel.text = [buyer objectForKey:@"email"];
*/

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section {
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableCells objectAtIndex:indexPath.row];
    if (cell) return  cell;
    
    
//    return [self.tableCells objectAtIndex:indexPath.row];
    
    
//    int style = UITableViewCellStyleValue2;
  
//    static NSString *CellIdentifier = @"Cell";
//    static NSString *CellNib = @"";
//    
//    switch (indexPath.row) {
//        case 0:
//            CellIdentifier = @"WhatTableCell";
//            CellNib = @"What";
//        break;
//        case 1:
//            CellIdentifier = @"WhereTableCell";
//            CellNib = @"Where";
//        break;
//        case 2:
//            CellIdentifier = @"WhereMapTableCell";
//            CellNib = @"Where";
//        break;
//        case 3:
//            CellIdentifier = @"DescriptionTableCell";
//            CellNib = @"Description";
//        break;
//    }
    
//    static NSString *CellIdentifier = @"MyCustomCellIdentifier"; // we need to set this in nib as identifier of the cell 
    
//    MyCustomCell *cell = (MyCustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

//        static NSString *MyIdentifier = @"MyIdentifier";
//        MyIdentifier = @"tblCellView";
    
//    static NSString *CellIdentifier = @"Cell";
//    static NSString *CellNib = @"WhatTableCell";
//    
//    WhatTableCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[[WhatTableCell alloc] initNibName:CellNib reuseIdentifier:CellIdentifier] autorelease];
//    }

    // Configure the cell
//    return cell;
    
//        WhatTableCell *cell = (TableCellView *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if(cell == nil) {
//            [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
//            cell = tblCell;
//        }
    
//    TableCellView *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if(cell == nil) {
//        [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
//        cell = tblCell;
//    }
    
//    UITableViewCell *cell = (UITableViewCell *)[theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
//        cell = (UITableViewCell *)[nib objectAtIndex:0];
//        CustomCellBackgroundView *bgView = [[CustomCellBackgroundView alloc] initWithFrame:CGRectZero];
//        bgView.fillColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
//        bgView.borderColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
//        bgView.position = CustomCellBackgroundViewPositionMiddle;
//        cell.backgroundView = bgView;
//    }
    
//	static NSString *CellIdentifier = @"Cell";
	
//	NSString *ident = [NSString stringWithFormat:@"%d",style];
    
//    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];

//    //    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:ident];
	
//	if(cell == nil) {
//		cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:ident]autorelease];
//        
//        UILabel *l = cell.textLabel;
//        l.backgroundColor = [UIColor colorWithWhite:0.0 alpha:1.0];
//        l.textColor = [UIColor colorWithWhite:1.0 alpha:0.70];
//        
//        l = cell.detailTextLabel;
//        l.backgroundColor = [UIColor colorWithWhite:0.0 alpha:1.0];
//        l.textColor = [UIColor colorWithWhite:1.0 alpha:0.90];
//        cell.backgroundColor = [UIColor clearColor];
//        //cell.contentView.backgroundColor = [UIColor clearColor];
//        
//        /*
//        Background: Black @ 50% alpha
//        Stroke: 2 px White @ 9% alpha
//        Drop Shadow: Offset 5px, blur 5px, Black @ 33% alpha
//        */
//        
//        CustomCellBackgroundView *bgView = [[CustomCellBackgroundView alloc] initWithFrame:CGRectZero];
//        
//        bgView.fillColor = [UIColor colorWithWhite:0.f alpha:.5f];
//        bgView.borderColor = [UIColor colorWithWhite:0.3f alpha:0.5f];
//        
////        if (indexPath.row == 0) {
////            bgView.position = CustomCellBackgroundViewPositionTop;
////        } else if (indexPath.row == [self tableView:tv numberOfRowsInSection:0] - 1 ) {
////            bgView.position = CustomCellBackgroundViewPositionBottom;
////        } else {
//        bgView.position = CustomCellBackgroundViewPositionMiddle;
////        }
//
//        cell.backgroundView = bgView;
//        
//        
//	}
    
//    
//    switch (indexPath.row) {
//        case 0:
////            cell.detailTextLabel.text = @"Where";
//            cell.textLabel.text = @"Where?";
//            break;
//        case 1:
////            cell.detailTextLabel.text = [_buyer objectForKey:@"transid"];
//            cell.textLabel.text = @"What?";
//            break;
//        case 2:
////            cell.textLabel.text = @"Address";
////            if([[_buyer objectForKey:@"city"] length] > 0 && [[_buyer objectForKey:@"state"] length] > 0 && [[_buyer objectForKey:@"zip"] length] > 0){
////                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@ %@",[_buyer objectForKey:@"city"], [_buyer objectForKey:@"state"], [_buyer objectForKey:@"zip"]];                
////            }else{
////                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@ %@",[_buyer objectForKey:@"city"], [_buyer objectForKey:@"state"], [_buyer objectForKey:@"zip"]];                
////            }
//            
//            
//            
//            break;
//        case 3:
////            cell.detailTextLabel.text = @";
//            cell.textLabel.text = @"Enter a description of your item...";
//            break;
//
//        default:
//            break;
//    }
	
//	[cell setAccessoryType: UITableViewCellAccessoryNone];
	
    //	cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellbg-light.png"]];
	
//    return cell;
	
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    //	NSDictionary *ticket = [[self barCodes] objectAtIndex:indexPath.row];
    //	NSString *scanCount = [ticket valueForKey:@"scan_count"];
    //	NSString *upc = [ticket valueForKey:@"upc"];
    //	
    //	if([scanCount isEqualToString: @"0"]){
    //		[self beginCheckIn:upc];
    //	}else{
    //		CheckInView *checkInView = [[[CheckInView alloc] initWithUPC:upc] autorelease];
    //		[self.navigationController pushViewController:checkInView animated:YES];
    //	}
    
}

//- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier {
//	
//	CGRect CellFrame = CGRectMake(0, 0, 300, 70);
//	CGRect Label1Frame = CGRectMake(60, 0, 290, 25);
//	CGRect Label2Frame = CGRectMake(60, 14, 290, 25);
//	CGRect Label3Frame = CGRectMake(60, 27, 170, 25);
//	CGRect Label4Frame = CGRectMake(210, 27, 100, 25);
//	UILabel *lblTemp;
//	
//	UITableViewCell *cell = [[[UITableViewCell alloc] initWithFrame:CellFrame reuseIdentifier:cellIdentifier] autorelease];
//	
//	lblTemp = [[UILabel alloc] initWithFrame:Label1Frame];
//	lblTemp.tag = 1;
//	lblTemp.font = [UIFont boldSystemFontOfSize:13];
//	lblTemp.textColor = [UIColor blackColor];
//	lblTemp.backgroundColor = [UIColor clearColor];
//	[cell.contentView addSubview:lblTemp];
//	[lblTemp release];
//	
//	lblTemp = [[UILabel alloc] initWithFrame:Label2Frame];
//	lblTemp.tag = 2;
//	lblTemp.font = [UIFont boldSystemFontOfSize:11];
//	lblTemp.textColor = [UIColor blackColor];
//	lblTemp.backgroundColor = [UIColor clearColor];
//	[cell.contentView addSubview:lblTemp];
//	[lblTemp release];
//	
//	lblTemp = [[UILabel alloc] initWithFrame:Label3Frame];
//	lblTemp.tag = 3;
//	lblTemp.font = [UIFont boldSystemFontOfSize:10];
//	lblTemp.textColor = [UIColor blackColor];
//	lblTemp.backgroundColor = [UIColor clearColor];
//	lblTemp.textColor = [UIColor darkGrayColor];
//	[cell.contentView addSubview:lblTemp];
//	[lblTemp release];
//	
//	lblTemp = [[UILabel alloc] initWithFrame:Label4Frame];
//	lblTemp.tag = 4;
//	lblTemp.font = [UIFont boldSystemFontOfSize:10];
//	lblTemp.textColor = [UIColor blackColor];
//	lblTemp.backgroundColor = [UIColor clearColor];
//	lblTemp.textColor = [UIColor darkGrayColor];
//	[cell.contentView addSubview:lblTemp];
//	[lblTemp release];
//	
//	return cell;
//}
//


#pragma mark endTable




@end
