//
//  MessageManager.h
//  MindIt
//
//  Created by Sveta on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import "MindItAppDelegate.h"
#import "Annotation.h"
#import "MessageObj.h"
@interface MessageManager : NSObject {
    MindItAppDelegate *appDelegate;
    
	NSArray *messagesData;
    NSMutableData *responseData;
	BOOL returnValue;
	MessageObj *mssg;
    NSURLConnection *connRec;
}
@property(nonatomic,retain)MindItAppDelegate *appDelegate;
@property(nonatomic,retain)MessageObj *mssg;
@property(nonatomic,retain)NSArray *messagesData;
@property(nonatomic, retain)NSMutableData *responseData;
@property(nonatomic)BOOL returnValue;
-(BOOL)addMessage:(MessageObj *)messageToAdd;
-(BOOL)selectMessages:(NSString *)messagesToQuery;
-(BOOL)selectA_MessageById:(NSString *)str_MessageID;



@end
