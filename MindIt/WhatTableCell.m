//
//  WhatTableCell.m
//  MindIt
//
//  Created by Wes Edling on 7/17/11.
//  Copyright 2011 Joe Designs. All rights reserved.
//

#import "WhatTableCell.h"
#import "CustomCellBackgroundView.h"

@implementation WhatTableCell

@synthesize whatTextLabel;

//-(void)awakeFromNib{
//    self = [super initWithStyle: CustomCellBackgroundViewPositionMiddle reuseIdentifier:@"Cell"];
//}

-(NSString *)getText{
    return whatTextLabel.text;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setLabel:(NSString *)labelText{
    [self.whatTextLabel setText: labelText];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
}

@end
