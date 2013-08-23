//
//  Ticket.m
//  ServiceNow
//
//  Created by Developer on 6/12/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "Ticket.h"

@implementation Ticket
@synthesize sys_id, state, short_description, curComment, severity, impact, opened_at, closed_at, comments;

-(id)init {
    self = [super init];
    if(self) {
        self.sys_id = @"";
        self.state = 0;
        self.short_description = @"";
        self.curComment = @"";
        self.severity = 3;
        self.impact = 3;
        self.opened_at = @"";
        self.closed_at = @"";
        self.comments = [[NSMutableArray alloc] init];
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
    self.curComment             = [ticket.curComment copy];
    self.severity             =  ticket.severity;
    self.impact               =  ticket.impact;
    self.opened_at            = [ticket.opened_at copy];
    self.closed_at            = [ticket.closed_at copy];
    self.comments     = [[NSMutableArray alloc] init];
    for(NSString *comment in ticket.comments)
    {
        [self.comments addObject:[comment copy]];
    }
}

@end