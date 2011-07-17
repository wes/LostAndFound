//
//  JSONConsumerDelegate.h
//  hmtNew
//
//  Created by Androidicus Maximus on 1/26/11.
//  Copyright 2011 Stone Design Corp. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol JSONConsumerDelegate

- (void)didReceivePropertyList:(id)propertyList headers:(NSDictionary *)header code:(int)code;
- (void)networkOfflineWithRequest:(NSString *)request;

- (NSString *)archiveKey; // if nil, don't cache, otherwise cache under this key for a file name
- (id)propertyListRepresentation; // if nil, don't cache
- (void)loadFromPropertyList:(id)list;

@end
