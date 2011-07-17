//
//  TableViewController.m
//  MindIt
//
//  Created by Sophia on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import "JSON.h"
#import "DetailViewController.h"
#import "ReportObj.h"
#import "MindItAppDelegate.h"

@implementation SearchViewController

@synthesize responseData, progressInd, aDict, tableView, sBar, detailView ;

- (UINavigationController *)tabBarNavigationController {
    return [(MindItAppDelegate *)[[UIApplication sharedApplication] delegate] navigationController];
}

#pragma mark -
#pragma mark Initialization

/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 self = [super initWithStyle:style];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
	[super viewDidLoad];
	NSLog(@"ASDF");
	
	cLocation.longitude = 150.000;
	cLocation.latitude = 150.000;
	
	sBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0,0,320,44)];
	sBar.delegate = self;
	[self.view addSubview:sBar];
	tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 400)];
	tableView.delegate = self;
	tableView.dataSource = self;
	tableView.hidden=YES;
	[self.view addSubview:tableView];
	//[self.tableView addSubview:self.progressInd];
	
	
	NSString *urlString = 
	[NSString stringWithFormat:@"http://petbookapp.com/services/lnf.php?m=founds&user='xyz'&cat=0&lat=34.67269185&lng=-79.00355048333333",
	 cLocation.latitude,
	 cLocation.longitude];
	NSLog(@" %@",urlString);
	responseData = [[NSMutableData data] retain]; 
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];  
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
	//[self.tableView reloadData];
	[super viewWillAppear:animated];
//    [[self tabBarNavigationController] setNavigationBarHidden:NO animated:YES];
}

 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
//    [[self tabBarNavigationController] setNavigationBarHidden:YES animated:YES];

 [super viewWillDisappear:animated];
 }

/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */




#pragma mark -
#pragma mark Table view data source

-(void)reloadTableView{
	//[[[UIApplication sharedApplication] delegate] setNetworkActivityIndicatorVisible:YES];
	[self.view addSubview:self.progressInd];
	//[self.tableview reloadData];		
	NSLog(@"reloaded tableview  %@",self.tableView);
	
	[[self tableView]reloadData];
	
	[self.progressInd removeFromSuperview];
	//[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of rows in the section.
	// return [aDict count];
	//	 return 2;
	
	if(aDict == nil){
		return 0;
	}
	else{
		return [aDict count];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	//NSString* theText =  //first get the text that will be displayed in the cell
	//CGSize textSize = [theTextsizeWithFont: font constrainedToSize:CGSizeMake(280, 500)];
	
	return 57;
}


#define TITLELABEL_TAG 1
#define INFOLABEL_TAG 2
#define INFOLABEL2_TAG 3
#define MILELABEL_TAG 4
#define PHOTOIMAGE_TAG 5

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UILabel *titleLabel, *infoLabel,*infoLabel2, *mileLabel;
    UIImageView *photo;
	
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellular"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellular"] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
        titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(50.0, 5.0, 270.0, 25.0)] autorelease];
        titleLabel.tag = TITLELABEL_TAG;
        titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        titleLabel.textColor = [UIColor orangeColor];
        [cell.contentView addSubview:titleLabel];
		
        infoLabel = [[[UILabel alloc] initWithFrame:CGRectMake(125.0, 10.0, 225.0, 15.0)] autorelease];
        infoLabel.tag = INFOLABEL_TAG;
        infoLabel.font = [UIFont systemFontOfSize:13.0];
        infoLabel.textColor = [UIColor darkGrayColor];
        [cell.contentView addSubview:infoLabel];
		
		infoLabel2 = [[[UILabel alloc] initWithFrame:CGRectMake(50.0, 30.0, 250.0, 15.0)] autorelease];
        infoLabel2.tag = INFOLABEL2_TAG;
        infoLabel2.font = [UIFont systemFontOfSize:13.0];
        infoLabel2.textColor = [UIColor darkGrayColor];
        [cell.contentView addSubview:infoLabel2];
		
		mileLabel = [[[UILabel alloc] initWithFrame:CGRectMake(280.0, 3.0, 35.0, 15.0)] autorelease];
        mileLabel.tag = MILELABEL_TAG;
        mileLabel.font = [UIFont systemFontOfSize:10.0];
        mileLabel.textColor = [UIColor darkGrayColor];
		mileLabel.textAlignment = UITextAlignmentRight;
        [cell.contentView addSubview:mileLabel];
		
		photo = [[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)]autorelease];
		photo.tag = PHOTOIMAGE_TAG;
		[cell.contentView addSubview:photo];
    } 
	else {
        titleLabel = (UILabel *)[cell.contentView viewWithTag:TITLELABEL_TAG];
        infoLabel = (UILabel *)[cell.contentView viewWithTag:INFOLABEL_TAG];
        infoLabel2 = (UILabel *)[cell.contentView viewWithTag:INFOLABEL2_TAG];
		mileLabel = (UILabel *)[cell.contentView viewWithTag:MILELABEL_TAG];
		photo = (UIImageView *)[cell.contentView viewWithTag:PHOTOIMAGE_TAG];
	}
	
	if(aDict==nil){
		NSLog(@"aDict is NULL");
	}
	NSDictionary *recordArr = (NSDictionary *)[aDict objectAtIndex:[indexPath row]];
	
	//Today Aug 05 at 5:00pm
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	//2011-07-14 01:12:57
	[dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	
	NSLog(@"date=%@", [recordArr objectForKey:@"date"]);
	
	NSDate *date = [dateFormat dateFromString:[recordArr objectForKey:@"date"]];  
	
	// Convert date object to desired output format
	[dateFormat setDateFormat:@"EEE, MMM d"];
	NSString *dateStr = [dateFormat stringFromDate:date];  
	
	NSLog(@"date formatted string=", dateStr);
	
	[dateFormat setDateFormat:@"HH:mm:ss"];
	// Convert date object to desired output format
	[dateFormat setDateFormat:@"h:mm a"];
	NSString *timeStr = [dateFormat stringFromDate:date];  
	[dateFormat release];
	
    //titleLabel.text = [NSString stringWithFormat:@"%d. %@", indexPath.row+1, [recordArr objectForKey:@"category"]];//start_date,description
	
	NSString *catIdString = (NSString *)[recordArr objectForKey:@"categoryid"];
	NSString *catName;
	
	if([catIdString compare:@"0"]){
		catName=@"KEYS";	
	}
	else if([catIdString compare:@"1"]){
		catName=@"PHONE";
	}
	else if([catIdString compare:@"2"]){
		catName=@"WALLET";
	}
	
	titleLabel.text = [NSString stringWithFormat:@"%@", catName];//start_date,description
	
	infoLabel.text = [NSString stringWithFormat:@"%@ at %@", 
					  dateStr, timeStr];
	
	infoLabel2.text = [NSString stringWithFormat:@"%@", [recordArr objectForKey:@"text"]];
	
	float stringFloat = [[recordArr objectForKey:@"distance"] floatValue];
	
	mileLabel.text = [NSString stringWithFormat:@"%3.1f mi",stringFloat];
	
	return cell;
}


#pragma mark -
#pragma mark Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ReportObj *report = [ReportObj reportWithDictionaryRepresentation:(NSDictionary *)[aDict objectAtIndex:[indexPath row]]];
    detailView = [[DetailViewController alloc] initWithReport:report];
	[[self tabBarNavigationController] pushViewController:detailView animated:YES];
}
 
//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
// detailView = [[DetailViewController alloc] init];
// [self.navigationController pushViewController:detailView animated:YES];
//}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed: %@", [error description]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [connection release];
    NSString *responseString = [[NSString alloc] init];
    responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    [responseData release];
	
	self.aDict = [responseString JSONValue];
	
	//self.aDict = [dictionary objectForKey:@"results"];  
	NSLog(@"connectiondidFinishLoading");
	
	if(aDict==nil){
		NSLog(@"no found items");
	}
	else {
		NSLog(@"found count='%d'",[aDict count]);
	}
	
	//[self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
	
	
	[self.view addSubview:self.progressInd];
	NSLog(@"reloaded tableview  %@",self.tableView);
	[self.tableView reloadData];
	[self.progressInd removeFromSuperview];
	tableView.hidden=NO;
	
	[responseString release];
	//[self.progressInd removeFromSuperview];
} 

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
	// only show the status bar’s cancel button while in edit mode
	sBar.showsCancelButton = YES;
	sBar.autocorrectionType = UITextAutocorrectionTypeNo;
	// flush the previous search content
	//[tableData removeAllObjects];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
	sBar.showsCancelButton = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	//[tableData removeAllObjects];// remove all data that belongs to previous search
	if([searchText isEqualToString:@""] || searchText==nil){
		[tableView reloadData];
		return;
	}
	NSInteger counter = 0;
	/*
	 for(NSString *name in dataSource)
	 {
	 NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	 NSRange r = [name rangeOfString:searchText];
	 if(r.location != NSNotFound)
	 {
	 if(r.location== 0)//that is we are checking only the start of the names.
	 {
	 //			[tableData addObject:name];
	 }
	 }
	 counter++;
	 [pool release];
	 }
	 */
	[tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	// if a valid search was entered but the user wanted to cancel, bring back the main list content
	//[tableData removeAllObjects];
	//[tableData addObjectsFromArray:dataSource];
	@try{
		[tableView reloadData];
	}
	@catch(NSException *e){
	}
	[sBar resignFirstResponder];
	sBar.text = @"";
}
// called when Search (in our case “Done”) button pressed

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

