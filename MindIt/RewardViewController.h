//
//  RewardViewController.h
//  ilfdb
//
//  Created by John on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPal.h"

typedef enum PaymentStatuses {
    PAYMENTSTATUS_SUCCESS,
    PAYMENTSTATUS_FAILED,
    PAYMENTSTATUS_CANCELED,
} PaymentStatus;


@interface RewardViewController : UIViewController <PayPalPaymentDelegate> {
    IBOutlet UITextField * amountTextField;
    IBOutlet UITextField * payeeTextField;
    
        PaymentStatus status;
}

@property (retain, nonatomic) UITextField * amountTextField;
@property (retain, nonatomic) UITextField * payeeTextField;

@end
