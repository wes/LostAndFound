//
//  SelectionListViewController.h
//  MindIt
//
//  Created by Wes Edling on 7/16/11.
//  Copyright 2011 Joe Designs. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <UIKit/UIKit.h>

@protocol SelectionListViewControllerDelegate <NSObject>
@required
- (void)rowChosen:(NSInteger)row;
@end

@interface SelectionListViewController : UITableViewController 
{
    NSArray         *list;
    NSIndexPath     *lastIndexPath;
    NSInteger       initialSelection;
    
    id <SelectionListViewControllerDelegate>    delegate;
}
@property (nonatomic, retain) NSIndexPath *lastIndexPath;
@property (nonatomic, retain) NSArray *list;
@property NSInteger initialSelection;
@property (nonatomic, assign) id <SelectionListViewControllerDelegate> delegate;
@end