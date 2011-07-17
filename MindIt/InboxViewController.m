//
//  InboxViewController.m
//  MindIt
//
//  Created by Sveta on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InboxViewController.h"
#import "MessageManager.h"
#import "MessageObj.h"
#import "MessageCell.h"
#import "MessageDetailViewController.h"

@implementation InboxViewController
@synthesize appDelegate, tblMessages, msg, aDict;

- (UINavigationController *)tabBarNavigationController {
    return [(MindItAppDelegate *)[[UIApplication sharedApplication] delegate] navigationController];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    appDelegate = (MindItAppDelegate *)[[UIApplication sharedApplication] delegate];
    [tblMessages reloadData];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"stripe.png"]]];
}
/*
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger returnValue = 1;
	tableView.rowHeight = 100;
	tableView.separatorColor = [UIColor clearColor];
	returnValue = [appDelegate.arr_Messages count];
	
	if(returnValue == 0)
		returnValue = 1;
	
	return returnValue;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	BOOL NoRows = NO;
	
	if([appDelegate.arr_Messages count] > 0)
	{
		self.navigationItem.leftBarButtonItem.enabled = YES;
		static NSString *CellIdentifier = @"Cell";
		
		MessageCell *cell = (MessageCell *)[self.tblMessages dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[MessageCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		MessageObj *objMsgs = [appDelegate.arr_Messages objectAtIndex:indexPath.row];
		[cell setMessage:objMsgs];

		return cell;
	} else
		NoRows = YES;
	
	if(NoRows)
	{
		static NSString *CellIdentifier = @"CellEmpty";
		UITableViewCell *cell = [self.tblMessages dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) 
		{
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		}
		cell.textLabel.text = @"No Messages";
		self.navigationItem.leftBarButtonItem.enabled = NO;
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		cell.textLabel.textColor = [UIColor whiteColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		return cell;
	}
	return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *aCell = [tableView cellForRowAtIndexPath:indexPath];
	if([aCell.textLabel.text isEqualToString:@"No Messages"])
	{
		return NO;
	}
	return YES;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageObj *msg = [MessageObj reportWithDictionaryRepresentation:(NSDictionary *)[aDict objectAtIndex:[indexPath row]]];
    MessageDetailViewController* detailView = [[MessageDetailViewController alloc] initWithReport:msg];
	[[self tabBarNavigationController] pushViewController:detailView animated:YES];
}

@end
