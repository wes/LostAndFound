//
//  WhereMapTableCell.m
//  MindIt
//
//  Created by Wes Edling on 7/17/11.
//  Copyright 2011 Joe Designs. All rights reserved.
//

#import "WhereMapTableCell.h"


@implementation WhereMapTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
}

@end
