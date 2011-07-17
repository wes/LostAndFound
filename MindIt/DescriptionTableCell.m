//
//  DescriptionTableCell.m
//  MindIt
//
//  Created by Wes Edling on 7/17/11.
//  Copyright 2011 Joe Designs. All rights reserved.
//

#import "DescriptionTableCell.h"


@implementation DescriptionTableCell

@synthesize descriptionTextLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setLabel:(NSString *)labelText{
    [self.descriptionTextLabel setText: labelText];
//    self.descriptionTextLabel.text.returnKeyType = UIReturnKeyDone;
//    [self.
//    [self.descriptionTextLabel set
//    self.descriptionTextLabel.text.returnKeyType = UIReturnKeyDone;

}

//-(IBAction)textFieldGainedFocus:(id)sender {
////    NSLog(@"GOT HERE AAAAAAAAAAAAA");
////    [self.descriptionTextLabel setReturnKeyType: UIReturnKeyDone];
//}
//
//-(IBAction)textFieldLostFocus:(id)sender {
//    [self.descriptionTextLabel resignFirstResponder];
//}
//

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)dismissKeyboard
//{
//    [self.descriptionTextLabel becomeFirstResponder];
//    [self.descriptionTextLabel resignFirstResponder];
//}


- (void)dealloc
{
    [super dealloc];
}

@end
