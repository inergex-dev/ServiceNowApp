//
//  Ticket.m
//  ServiceNow
//
//  Created by Developer on 6/12/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "Ticket.h"

@implementation Ticket
@synthesize shortDesc, userName, firstName, lastName;

- (void) dealloc {
    [userName release];
    [firstName release];
    [lastName release];
    [super dealloc];
}

-(id)init {
    [super init];
    shortDesc = @"Desc Needed";
    return self;
}

-(id)init:(NSString *)sDesc
{
    self.shortDesc = sDesc;
    self.firstName = @"";
    self.lastName = @"";
    self.userName = @"";
    
    return self;
}

@end