//
//  MessageDetailViewController.h
//  MindIt
//
//  Created by Sohel Siddique on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageObj.h"

@interface MessageDetailViewController : UIViewController {
    IBOutlet UILabel *lblDate;
    IBOutlet UILabel *lblMessage;

}
@property (retain, nonatomic) UILabel *lblDate;
@property (retain, nonatomic) UILabel *lblMessage;
@property (retain, nonatomic) MessageObj *msg;
- (id)initWithReport:(MessageObj *)msg;
@end
