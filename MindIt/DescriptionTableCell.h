//
//  DescriptionTableCell.h
//  MindIt
//
//  Created by Wes Edling on 7/17/11.
//  Copyright 2011 Joe Designs. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DescriptionTableCell : UITableViewCell <UITextFieldDelegate> {
    IBOutlet UITextField *descriptionTextLabel;
}

@property (nonatomic, retain) IBOutlet UITextField *descriptionTextLabel;

//- (IBAction)textFieldGainedFocus:(id)sender;
//- (IBAction)textFieldLostFocus:(id)sender;

-(NSString *)getText;

@end
