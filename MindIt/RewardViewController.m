//
//  RewardViewController.m
//  ilfdb
//
//  Created by John on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RewardViewController.h"
#import "PayPalPayment.h"
#import "PayPalAdvancedPayment.h"
#import "PayPalAmounts.h"
#import "PayPalReceiverAmounts.h"
#import "PayPalAddress.h"
#import "PayPalInvoiceItem.h"

@implementation RewardViewController
@synthesize amountTextField, payeeTextField;

- (void)addLabelWithText:(NSString *)text andButtonWithType:(PayPalButtonType)type withAction:(SEL)action {
	
	//you should call getPayButton to have the library generate a button for you.
	//this button will be disabled if device interrogation fails for any reason.
	//
	//-- required parameters --
	//target is a class which implements the PayPalPaymentDelegate protocol.
	//action is the selector to call when the button is clicked.
	//inButtonType is the button type (desired size).
	//
	//-- optional parameter --
	//inButtonText can be either BUTTON_TEXT_PAY (default, displays "Pay with PayPal"
	//in the button) or BUTTON_TEXT_DONATE (displays "Donate with PayPal" in the
	//button). the inButtonText parameter also affects some of the library behavior
	//and the wording of some messages to the user.
	UIButton *button = [[PayPal getInstance] getPayButtonWithTarget:self andAction:action andButtonType:type];
	CGRect frame = button.frame;
	frame.origin.x = 15;
	frame.origin.y = 130;
	button.frame = frame;
	[self.view addSubview:button];
	
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"stripe.png"]]];
    
    [self setTitle:@"Reward Finder"];
    self.payeeTextField.text = @"jvpaye_1310853970_biz@gmail.com";
    self.amountTextField.text = @"10.00";
    [self addLabelWithText:@"Chained Payment" andButtonWithType:BUTTON_294x43 withAction:@selector(parallelPayment)];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) removeKeyboard
{
    [self resignFirstResponder];
}


#pragma mark -
#pragma mark PayPalPaymentDelegate methods

//paymentSuccessWithKey:andStatus: is a required method. in it, you should record that the payment
//was successful and perform any desired bookkeeping. you should not do any user interface updates.
//payKey is a string which uniquely identifies the transaction.
//paymentStatus is an enum value which can be STATUS_COMPLETED, STATUS_CREATED, or STATUS_OTHER
- (void)paymentSuccessWithKey:(NSString *)payKey andStatus:(PayPalPaymentStatus)paymentStatus {
	status = PAYMENTSTATUS_SUCCESS;
}

//paymentFailedWithCorrelationID:andErrorCode:andErrorMessage: is a required method. in it, you should
//record that the payment failed and perform any desired bookkeeping. you should not do any user interface updates.
//correlationID is a string which uniquely identifies the failed transaction, should you need to contact PayPal.
//errorCode is generally (but not always) a numerical code associated with the error.
//errorMessage is a human-readable string describing the error that occurred.
- (void)paymentFailedWithCorrelationID:(NSString *)correlationID andErrorCode:(NSString *)errorCode andErrorMessage:(NSString *)errorMessage {
	status = PAYMENTSTATUS_FAILED;
}

//paymentCanceled is a required method. in it, you should record that the payment was canceled by
//the user and perform any desired bookkeeping. you should not do any user interface updates.
- (void)paymentCanceled {
	status = PAYMENTSTATUS_CANCELED;
}

//paymentLibraryExit is a required method. this is called when the library is finished with the display
//and is returning control back to your app. you should now do any user interface updates such as
//displaying a success/failure/canceled message.
- (void)paymentLibraryExit {
	switch (status) {
		case PAYMENTSTATUS_SUCCESS:
		case PAYMENTSTATUS_FAILED:
		case PAYMENTSTATUS_CANCELED:
            break;
	}
}


- (void)parallelPayment {
	
	//optional, set shippingEnabled to TRUE if you want to display shipping
	//options to the user, default: TRUE
	//[PayPal getInstance].shippingEnabled = TRUE;
    
	
	//optional, set dynamicAmountUpdateEnabled to TRUE if you want to compute
	//shipping and tax based on the user's address choice, default: FALSE
	//[PayPal getInstance].dynamicAmountUpdateEnabled = TRUE;
	[self.amountTextField resignFirstResponder];
    [self.payeeTextField resignFirstResponder];
    
	//optional, choose who pays the fee, default: FEEPAYER_EACHRECEIVER
	[PayPal getInstance].feePayer = FEEPAYER_EACHRECEIVER;
	
	//for a payment with multiple recipients, use a PayPalAdvancedPayment object
	PayPalAdvancedPayment *payment = [[[PayPalAdvancedPayment alloc] init] autorelease];
	payment.paymentCurrency = @"USD";
	
	//receiverPaymentDetails is a list of PPReceiverPaymentDetails objects
	payment.receiverPaymentDetails = [NSMutableArray array];
	
	//receiverPaymentDetails is a list of PPReceiverPaymentDetails objects
	payment.receiverPaymentDetails = [NSMutableArray array];
	
	//Frank's Robert's Julie's Bear Parts;
	NSArray *nameArray = [NSArray arrayWithObjects:@"The Honest Finder", @"The Lost and Found Team",nil];
	
	for (int i = 1; i <= 2; i++) {
		PPReceiverPaymentDetails *details = [[[PPReceiverPaymentDetails alloc] init] autorelease];
		
		details.description = [NSString stringWithFormat:@"Reward for finding my thing"];
		details.recipient = [NSString stringWithFormat:@"example-merchant-%d@paypal.com", 4 - i];
		details.merchantName = [NSString stringWithFormat:@"%@",[nameArray objectAtIndex:i-1]];
        
		unsigned long long order;
        float amount = [amountTextField.text floatValue];
        if (i==1) 
        {
            order = amount * 90;
        }
        else
        {
            order = amount * 10;
        }

		
		//subtotal of all items for this recipient, without tax and shipping
		details.subTotal = [NSDecimalNumber decimalNumberWithMantissa:order exponent:-2 isNegative:FALSE];
		
		//invoiceData is a PayPalInvoiceData object which contains tax, shipping, and a list of PayPalInvoiceItem objects
		details.invoiceData = [[[PayPalInvoiceData alloc] init] autorelease];
		
		//invoiceItems is a list of PayPalInvoiceItem objects
		//NOTE: sum of totalPrice for all items must equal details.subTotal
		//NOTE: example only shows a single item, but you can have more than one
		details.invoiceData.invoiceItems = [NSMutableArray array];
		PayPalInvoiceItem *item = [[[PayPalInvoiceItem alloc] init] autorelease];
		item.totalPrice = details.subTotal;
		item.name = @"Reward";
		[details.invoiceData.invoiceItems addObject:item];
		
		[payment.receiverPaymentDetails addObject:details];
	}
	
	[[PayPal getInstance] advancedCheckoutWithPayment:payment];

}


@end
