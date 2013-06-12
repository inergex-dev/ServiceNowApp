//
//  Ticket.m
//  ServiceNow
//
//  Created by Developer on 6/12/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "Ticket.h"

@implementation Ticket
@synthesize userName, firstName, lastName;

- (void) dealloc {
    [userName release];
    [firstName release];
    [lastName release];
    [super dealloc];
}

@end