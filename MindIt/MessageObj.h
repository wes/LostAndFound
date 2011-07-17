//
//  MessageObj.h
//  MindIt
//
//  Created by Sveta on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MessageObj : NSObject {
    NSString *identifier;
    NSString *date;
    NSString *fromudid;
    NSString *recordid;
    NSString *text;
}

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *fromudid;
@property (nonatomic, copy) NSString *recordid;
@property (nonatomic, copy) NSString *text;
@end
