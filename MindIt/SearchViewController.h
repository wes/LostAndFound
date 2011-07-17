//
//  SearchViewController.h
//  MindIt
//
//  Created by Sophia on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DetailViewController.h"

@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {
	CLLocationCoordinate2D  cLocation;
	NSMutableData *responseData;
	NSArray *aDict;
	UIActivityIndicatorView *progressInd;
	UITableView *tableView;
	UISearchBar *sBar;//search bar	
	DetailViewController *detailView;
}

@property (retain,nonatomic) DetailViewController *detailView;
@property (retain,nonatomic) UISearchBar *sBar;//search bar
@property (retain,nonatomic) IBOutlet UITableView *tableView;
@property (retain,nonatomic) NSMutableData *responseData;
@property (retain,nonatomic) NSArray *aDict;
@property (retain,nonatomic) UIActivityIndicatorView *progressInd;

-(void)reloadTableView;

@end
