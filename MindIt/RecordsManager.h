//
//  RecordsManager.h
//  MindIt
//
//  Created by Sohel Siddique on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MindItAppDelegate.h"
#import "Annotation.h"
#import "ReportObj.h"

@interface RecordsManager : NSObject {
    MindItAppDelegate *appDelegate;
    
	NSArray *recordsData;
    NSMutableData *responseData;
	BOOL returnValue;
	ReportObj *rec;
    NSURLConnection *connRec;
    
}
@property(nonatomic,retain)MindItAppDelegate *appDelegate;
@property(nonatomic,retain)ReportObj *rec;
@property(nonatomic,retain)NSArray *recordsData;
@property(nonatomic, retain)NSMutableData *responseData;
@property(nonatomic)BOOL returnValue;
-(BOOL)addReport:(ReportObj *)reportToAdd;
-(BOOL)selectRecords:(ReportObj *)reportsToQuery;
-(BOOL)selectA_RecordById:(NSString *)str_RecordID;

@end



