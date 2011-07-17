//
//  JokesByDateManager.m
//  MindIt
//
//  Created by Sohel Siddique on 6/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RecordsManager.h"
#import <sqlite3.h>

#import "JSON.h"



@implementation RecordsManager
@synthesize appDelegate;
@synthesize recordsData, responseData, returnValue, rec;
/*--------------------------------------------------------------------------------
 init method
 --------------------------------------------------------------------------------*/
-(id)init {
	
	appDelegate = (MindItAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	return self;
}

-(BOOL)selectA_RecordById:(NSString *)str_RecordID
{
	returnValue = NO;
	return returnValue;	
}


-(BOOL)selectRecords:(ReportObj *)reportsToQuery{
	
	returnValue = NO;
    NSString *url;
    UIDevice *myDevice = [UIDevice currentDevice];
    NSString *deviceUDID = [myDevice uniqueIdentifier];
    if(reportsToQuery.isFoundReport)
        url = [NSString stringWithFormat:@"http://petbookapp.com/services/lnf.php?m=founds&user=%@&cat=0&lat=%@&lng=%@", deviceUDID, reportsToQuery.lat, reportsToQuery.lng];
    else
        url = [NSString stringWithFormat:@"http://petbookapp.com/services/lnf.php?m=losts&user=%@&cat=0&lat=%@&lng=%@", deviceUDID, reportsToQuery.lat, reportsToQuery.lng];	
    responseData = [[NSMutableData data] retain];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    connRec =  [[NSURLConnection alloc] initWithRequest:request delegate:self ];
    
	return YES;
}

-(BOOL)addReport:(ReportObj *)reportToAdd{
	
	returnValue = NO;
    NSString *url;
    UIDevice *myDevice = [UIDevice currentDevice];
    NSString *deviceUDID = [myDevice uniqueIdentifier];

    if(reportToAdd.isFoundReport)
        url = [NSString stringWithFormat:@"http://petbookapp.com/services/lnf.php?m=found&user=%@&cat=0&lat=%@&lng=%@&text=%@", deviceUDID, reportToAdd.lat, reportToAdd.lng, reportToAdd.subtitle];
    else
        url = [NSString stringWithFormat:@"http://petbookapp.com/services/lnf.php?m=lost&user=%@&cat=0&lat=%@&lng=%@&text=%@", deviceUDID, reportToAdd.lat, reportToAdd.lng, reportToAdd.subtitle];
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
    [appDelegate.arr_Records removeAllObjects];
    responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    [responseData release];
    
    
	
    NSArray *objData = [responseString JSONValue];
	
	for (NSDictionary *ann in objData)
	{
        
		rec = [[ReportObj alloc]init];
		NSString *fro = [NSString stringWithFormat:@"%@",[ann objectForKey:@"id"]];
		
		if (![fro isEqualToString:@"<null>"]) {
			rec.identifier = [NSString stringWithFormat:@"%@",[ann objectForKey:@"id"]];
			
		}
		fro = [NSString stringWithFormat:@"%@",[ann objectForKey:@"text"]];
		if (![fro isEqualToString:@"<null>"]) {
			rec.subtitle = [NSString stringWithFormat:@"%@",[ann objectForKey:@"text"]];
		}
		        
		[appDelegate.arr_Records addObject:rec];
        [rec release];
		
	}
    recordsData = appDelegate.arr_Records;

}
@end
