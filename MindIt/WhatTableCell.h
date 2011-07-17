//
//  WhatTableCell.h
//  MindIt
//
//  Created by Wes Edling on 7/17/11.
//  Copyright 2011 Joe Designs. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WhatTableCell : UITableViewCell {

    IBOutlet UILabel *whatTextLabel;
    
}

@property (nonatomic, retain) IBOutlet UILabel *whatTextLabel;

- (void)setLabel:(NSString *)labelText;

@end
