//
//  DealCell.h
//  iPet
//
//  Created by rajender on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageObj.h"

@interface MessageCell: UITableViewCell {
	
	MessageObj *objMessages;
	
	UILabel *lblCategory;
	UILabel *lblMessage;
	UILabel *lblDateTime;
}
@property (nonatomic, retain) MessageObj *objMessages;
@property (nonatomic, retain) UILabel *lblCategory;
@property (nonatomic, retain) UILabel *lblMessage;
@property (nonatomic, retain) UILabel *lblDateTime;
@property (nonatomic,retain) UIImageView *imgBG;
-(void)setMessage:(MessageObj *)message;

@end
