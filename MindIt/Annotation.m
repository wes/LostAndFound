//
//  Annotation.m
//  MindIt
//
//  Created by Sohel Siddique on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Annotation.h"


@implementation Annotation
@synthesize coordinate,title,subtitle;

-(void)dealloc
{
    [title release];
    [subtitle release];
    [super dealloc];
}

@end