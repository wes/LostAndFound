//
//  InboxViewController.m
//  MindIt
//
//  Created by Sveta on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InboxViewController.h"
#import "MessageManager.h"

@implementation InboxViewController

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
    
    [self setNavigationItem];
    MessageManager *mssgManager = [[MessageManager alloc]init];
    [mssgManager selectMessages:@"inbox"];
    [mssgManager release];
}
/*
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}*/
-(void)setNavigationItem
{ self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(loadSent)] autorelease];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)loadInbox
{
    
    MessageManager *mssgManager = [[MessageManager alloc]init];
    [mssgManager selectMessages:@"inbox"];
    [mssgManager release];
    
}
- (void)loadSent
{
    
    MessageManager *mssgManager = [[MessageManager alloc]init];
    [mssgManager selectMessages:@"sent"];
    [mssgManager release];
    
}
@end
