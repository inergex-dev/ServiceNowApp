//
//  Ticket.m
//  ServiceNow
//
//  Created by Developer on 6/12/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "Ticket.h"

@implementation Ticket
@synthesize sys_id, state, short_description, comments, severity, impact, opened_at, closed_at, previousComments;

-(id)init {
    self = [super init];
    if(self) {
        self.sys_id = @"";
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
    [ticket replaceWithTicketCopy:self];
    
    return ticket;
}

/** Overwrites each field of the current ticket with the data of the new ticket */
-(void)replaceWithTicketCopy:(Ticket*)ticket
{
    self.sys_id               = [ticket.sys_id copy];
    self.state                =  ticket.state;
    self.short_description    = [ticket.short_description copy];
    self.comments             = [ticket.comments copy];
    self.severity             =  ticket.severity;
    self.impact               =  ticket.impact;
    self.opened_at            = [ticket.opened_at copy];
    self.closed_at            = [ticket.closed_at copy];
    self.previousComments     = [ticket.previousComments copy];
}

@end