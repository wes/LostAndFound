//
//  MessageManager.m
//  MindIt
//
//  Created by Sveta on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MessageManager.h"
#import <sqlite3.h>

#import "JSON.h"


@implementation MessageManager
@synthesize appDelegate;
@synthesize messagesData, responseData, returnValue, mssg;
/*--------------------------------------------------------------------------------
 init method
 --------------------------------------------------------------------------------*/
-(id)init {
	
	appDelegate = (MindItAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	return self;
}

-(BOOL)selectA_MessageById:(NSString *)str_MessageID
{
	returnValue = NO;
	return returnValue;
}


-(BOOL)selectMessages:(NSString *)messagesToQuery{
	
	returnValue = NO;
    NSString *url;
    if (messagesToQuery==@"inbox") {
        url = [NSString stringWithFormat:@"http://petbookapp.com/services/lnf.php?m=inbox&user=BCB6AFF6-31CE-5A53-91D7-FC008BB406D0"];
        
    } else {
        url = [NSString stringWithFormat:@"http://petbookapp.com/services/lnf.php?m=sent&user=ACB6AFF6-31CE-5A53-91D7-FC008BB406D0"];
        
    }
        
    responseData = [[NSMutableData data] retain];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    connRec =  [[NSURLConnection alloc] initWithRequest:request delegate:self ];
    
	return YES;
}

-(BOOL)addMessage:(MessageObj *)messageToSend{
	
	returnValue = NO;
    NSString *url;
    UIDevice *myDevice = [UIDevice currentDevice];
    NSString *deviceUDID = [myDevice uniqueIdentifier];
    
//todo: change messageToSend.fromudid to TO??
    
    url = [NSString stringWithFormat:@"http://petbookapp.com/services/lnf.php?m=msg&from=%@&text=%@&to=%@&id=%@", deviceUDID, messageToSend.text, messageToSend.fromudid,messageToSend.identifier];
	responseData = [[NSMutableData data] retain];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    connRec =  [[NSURLConnection alloc] initWithRequest:request delegate:self ];
    return YES;
}



- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed: %@", [error description]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [connection release];
    NSString *responseString = [[NSString alloc] init];
    [appDelegate.arr_Messages removeAllObjects];
    responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    [responseData release];
    
    
	
    NSArray *objData = [responseString JSONValue];
	
	for (NSDictionary *ann in objData)
	{
        
		mssg = [[MessageObj alloc]init];
		NSString *fro = [NSString stringWithFormat:@"%@",[ann objectForKey:@"id"]];
		
		if (![fro isEqualToString:@"<null>"]) {
			mssg.identifier = [NSString stringWithFormat:@"%@",[ann objectForKey:@"id"]];
			
		}
		fro = [NSString stringWithFormat:@"%@",[ann objectForKey:@"text"]];
		if (![fro isEqualToString:@"<null>"]) {
			mssg.text = [NSString stringWithFormat:@"%@",[ann objectForKey:@"text"]];
		}
        
		[appDelegate.arr_Messages addObject:mssg];
        [mssg release];
		
	}
    messagesData = appDelegate.arr_Messages;
    
}

@end
