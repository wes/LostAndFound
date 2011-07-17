//
//  ReportObj.h
//  MindIt
//
//  Created by Sohel Siddique on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ReportObj : NSObject {
    int categoryid;
    float lat;
    float lng;
    BOOL isFoundReport;
}

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *udid;
@property (nonatomic, readwrite) float lat;
@property (nonatomic, readwrite) float lng;
@property (nonatomic, readwrite) int categoryid;
@property (nonatomic, readwrite) BOOL isFoundReport;

+ (ReportObj *)reportWithDictionaryRepresentation:(NSDictionary *)dictionary;
@end
