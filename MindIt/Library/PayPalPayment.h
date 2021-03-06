
#import <Foundation/Foundation.h>
#import "PayPal.h"
#import "PayPalInvoiceData.h"

@interface PayPalPayment : NSObject {
	@private
	
//required
	NSString *paymentCurrency;
	NSDecimalNumber *subTotal; //Not including taxes and shipping
	NSString *recipient;
	
//optional
	PayPalPaymentType paymentType; //defaults to TYPE_NOT_SET
	PayPalPaymentSubType paymentSubType; //defaults to SUBTYPE_NOT_SET
	PayPalInvoiceData *invoiceData;
	NSString *description; //payment note
	NSString *customId;
	NSString *merchantName;
	NSString *ipnUrl;
	NSString *memo;
}

@property (nonatomic, retain) NSString *paymentCurrency;
@property (nonatomic, retain) NSDecimalNumber *subTotal; //Not including taxes and shipping
@property (nonatomic, retain) NSString *recipient;

@property (nonatomic, assign) PayPalPaymentType paymentType; //defaults to TYPE_NOT_SET
@property (nonatomic, assign) PayPalPaymentSubType paymentSubType; //defaults to SUBTYPE_NOT_SET
@property (nonatomic, retain) PayPalInvoiceData *invoiceData;
@property (nonatomic, retain) NSString *description; //payment note
@property (nonatomic, retain) NSString *customId;
@property (nonatomic, retain) NSString *merchantName;
@property (nonatomic, retain) NSString *ipnUrl;
@property (nonatomic, retain) NSString *memo;

@end
