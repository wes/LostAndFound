//
//  ReportObj.m
//  MindIt
//
//  Created by Sohel Siddique on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ReportObj.h"


@implementation ReportObj
@synthesize identifier, title, subtitle, udid, lat, lng, categoryid, isFoundReport;


- (id)initWithDictionaryRepresentation:(NSDictionary *)dictionary {
    self.identifier = [dictionary valueForKey:@"id"];
    self.subtitle = [dictionary valueForKey:@"text"];
    self.title = [dictionary valueForKey:@"categoryid"];
//    ....
    return self;
}

+ (ReportObj *)reportWithDictionaryRepresentation:(NSDictionary *)dictionary {
    return [[[self alloc] initWithDictionaryRepresentation:dictionary] autorelease];
}

  @end
