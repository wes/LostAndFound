//
//  MessageDetailViewController.m
//  MindIt
//
//  Created by Sohel Siddique on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "MessageObj.h"

@implementation MessageDetailViewController
@synthesize lblDate, lblMessage;
@synthesize msg = _msg;


- (id)initWithReport:(MessageObj *)msg
{
    self = [super initWithNibName:@"MessageDetailViewController" bundle:nil];
    if (self) {
        self.msg = msg;
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

@end
