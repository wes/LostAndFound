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

@synthesize report, text, tableCells, isFound, segmentedControl;

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
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getTableCells];
    [self.tabBarController.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.navigationItem.title = @"Report";

//    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:nil];
    
//    [segmentedControl setImage:[UIImage imageNamed:@"foundBtnFound.png"] forSegmentAtIndex:0];
//    [segmentedControl setImage:[UIImage imageNamed:@"foundBtnLost.png"] forSegmentAtIndex:1];
//    [segmentedControl insertSegmentWithImage:[UIImage imageNamed:@"foundBtnLost.png"] atIndex:1 animated:YES];

    
//    UITableView *mapTableCellView = [self.tableCells objectAtIndex:2];
//    [mapTableCellView  
    
    // or self.navigationItem.title = MyNewTitle;
//    [self.navigationItem.rightBarButtonItem setText:@"Save"];


    
    
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
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [self.theTableView setContentInset:UIEdgeInsetsMake(-185.0,0,0,0)];
    [UIView commitAnimations];
    [self setEditingButtons];
}

//-(IBAction)textFieldDone:(id) sender {
//    text.frame = CGRectMake(0.0, 45.0, 320.0, 150.0);
////    [what setHidden:false];
//}

- (void)dealloc
{
    [super dealloc];
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

//    lastOptions = [[NSMutableArray alloc] initWithArray: @"Wallet / Purse",@"Computer",@"Pet",@"Keys", nil ];
    
    lostOptions = [[NSMutableArray alloc] init];
	[lostOptions addObject:@"Wallet"];
	[lostOptions addObject:@"Keys"];
	[lostOptions addObject:@"Car"];
	[lostOptions addObject:@"Pet"];

}

- (void) whatRowClicked {
    SelectionListViewController *controller = [[SelectionListViewController alloc] init];
    controller.delegate = self;
    controller.list = lostOptions;
//    controller.initialSelection = theIndexOfTheCurrentlySelectedItem;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}

- (void)rowChosen:(NSInteger)row {
    
    UITableViewCell *cell = [self.tableCells objectAtIndex:0];
    [cell setLabel:[lostOptions objectAtIndex:row]];

    [self setEditingButtons];
    
//    [self.whatTextLabel setTitle:[lostOptions objectAtIndex:row] forState:UIControlStateNormal];
}

- (void)setEditingButtons {

    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveRecord)];
    
    self.tabBarController.navigationItem.rightBarButtonItem = rightBarButtonItem;

    [rightBarButtonItem release];
    
//    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
//    
//    self.tabBarController.navigationItem.leftBarButtonItem = leftBarButtonItem;
//    
//    [leftBarButtonItem release];
}

- (void)cancel{
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    [self.theTableView setContentInset:UIEdgeInsetsMake(0,0,0,0)];
    [UIView commitAnimations];

//    UITableViewCell *cell = [[[DescriptionTableCell alloc] resignFirstResponder] autorelease];
//    [cell.descriptionTextLabel resignFirstResponder];
//    [self.view findAndResignFirstResonder];
//    [self.tabBarController resignFirstResponder];
}





-(BOOL)saveRecord
{

    UITableViewCell *titleView = [self.tableCells objectAtIndex: 0];
//    UITableViewCell *mapView = [self.tableCells objectAtIndex: 2];
    UITableViewCell *subTitleView = [self.tableCells objectAtIndex: 3];
    
    // found
    report.title = [titleView getText];
    
    NSLog(@"TITLE %@",[titleView getText]);
    
    report.subtitle = [subTitleView getText];
    report.lat = [[self.tableCells objectAtIndex:2] centerLat];
    report.lng = [[self.tableCells objectAtIndex:2] centerLng];
//    report.categoryid = 0;
    
    NSLog(@"REPORT");
    
    NSLog(@"%@",report);
    
    RecordsManager *rm = [[RecordsManager alloc] init];
    
    BOOL success = [rm addReport:report];
    [rm release];
    
    return success;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setMapView:nil];
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    UITableViewCell *cell = [self.tableCells objectAtIndex:3];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [self.theTableView setContentInset:UIEdgeInsetsMake(0,0,0,0)];
    [UIView commitAnimations];

    [textField resignFirstResponder];
    return YES;
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

//    UITableViewCell *cell = [self.tableCells objectAtIndex:indexPath.row];
//    UITableViewCell *cell = [self.tableCells objectAtIndex:indexPath.row];

//    [cell.frame.hei
//    [cell get
    
    float margin = 0;
    
    switch (indexPath.row) {
        case 0: // what
        case 1: // where
            return 44 + margin;
        break;
        case 2: // map
            return 165 + margin;
        break;
        case 3: // desc
            return 70 + margin;
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
	return [self.tableCells count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSLog(@"TEST: %i", indexPath.row);

    UITableViewCell *cell = [self.tableCells objectAtIndex:indexPath.row];
    
    CustomCellBackgroundView *bgView = [[CustomCellBackgroundView alloc] initWithFrame:CGRectZero];
    
    bgView.fillColor = [UIColor colorWithWhite:1.0f alpha:0.9f];
    bgView.borderColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
    bgView.position = CustomCellBackgroundViewPositionMiddle;
//    bgView.frame = CGRectMake(0, 0, 300, 44);
//    bgView.cli
    
    cell.backgroundView = bgView;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

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
	
    switch(indexPath.row){
        case 0:
            [self whatRowClicked];
        break;
    }
    
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
