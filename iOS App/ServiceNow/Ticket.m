//
//  Ticket.m
//  ServiceNow
//
//  Created by Developer on 6/12/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "Ticket.h"

@implementation Ticket
@synthesize number, state, short_description, comments, severity, impact, opened_at, closed_at, previousComments;

-(id)init {
    self = [super init];
    if(self) {
        self.number = @"";
        self.state = 0;
        self.short_description = @"";
        self.comments = @"";
        self.severity = 3;
        self.impact = 3;
        self.opened_at = @"";
        self.closed_at = @"";
        self.previousComments = [[NSArray alloc] initWithObjects:@"Your right, it IS broken! go figure.", @"Have you tried turning it off and on again?", nil];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    Ticket *ticket = [[Ticket alloc] init];
    ticket.number               = [self.number copyWithZone:zone];
    ticket.state                =  self.state;
    ticket.short_description    = [self.short_description copyWithZone:zone];
    ticket.comments             = [self.comments copyWithZone:zone];
    ticket.severity             =  self.severity;
    ticket.impact               =  self.impact;
    ticket.opened_at            = [self.opened_at copyWithZone:zone];
    ticket.closed_at            = [self.closed_at copyWithZone:zone];
    ticket.previousComments     = [self.previousComments copyWithZone:zone];
    
    return ticket;
}

@end