//
//  MessageObj.m
//  MindIt
//
//  Created by Sveta on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MessageObj.h"


@implementation MessageObj
@synthesize identifier;
@synthesize date;
@synthesize fromudid;
@synthesize recordid;
@synthesize text;

+ (MessageObj *)reportWithDictionaryRepresentation:(NSDictionary *)dictionary {
    return [[[self alloc] initWithDictionaryRepresentation:dictionary] autorelease];
}

@end
