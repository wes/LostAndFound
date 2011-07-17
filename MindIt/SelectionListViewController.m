//
//  SelectionListViewController.m
//  MindIt
//
//  Created by Wes Edling on 7/16/11.
//  Copyright 2011 Joe Designs. All rights reserved.
//

#import "SelectionListViewController.h"

@implementation SelectionListViewController
@synthesize list;
@synthesize lastIndexPath;
@synthesize initialSelection;
@synthesize delegate;
-(IBAction)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}
//-(IBAction)save
//{
//}
#pragma mark -
- (id)initWithStyle:(UITableViewStyle)style
{
    initialSelection = -1;
    return self;
}
- (void)viewDidLoad 
{
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated 
{
    // Check to see if user has indicated a row to be selected, and set it
    if (initialSelection > - 1 && initialSelection < [list count])
    {
        NSUInteger newIndex[] = {0, initialSelection};
        NSIndexPath *newPath = [[NSIndexPath alloc] initWithIndexes:newIndex length:2];
        self.lastIndexPath = newPath;
        [newPath release];
    }
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                     initWithTitle:NSLocalizedString(@"Cancel", @"Cancel - for button to cancel changes")
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [cancelButton release];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:NSLocalizedString(@"Save", @"Save - for button to save changes")
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];
    
    [super viewWillAppear:animated];
}
- (void)dealloc 
{
    [list release];
    [lastIndexPath release];
    [super dealloc];
}
#pragma mark -
#pragma mark Tableview methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *SelectionListCellIdentifier = @"SelectionListCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectionListCellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:SelectionListCellIdentifier] autorelease];
    }
    
    NSUInteger row = [indexPath row];
    NSUInteger oldRow = [lastIndexPath row];
    cell.text = [list objectAtIndex:row];
    cell.accessoryType = (row == oldRow && lastIndexPath != nil) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    int newRow = [indexPath row];
    int oldRow = [lastIndexPath row];
    
    if (newRow != oldRow)
    {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath: lastIndexPath]; 
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        
        lastIndexPath = indexPath;  
    }
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.delegate rowChosen:[lastIndexPath row]];
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end