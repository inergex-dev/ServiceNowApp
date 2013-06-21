//
//  Ticket.m
//  ServiceNow
//
//  Created by Developer on 6/12/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "Ticket.h"

@implementation Ticket
@synthesize number, shortDesc, comments, opened, closed;

-(id)init {
    self = [super init];
    if(self) {
        self.number = 0;
        self.shortDesc = @"";
        self.comments = @"";
        self.opened = @"";
        self.closed = @"";
    }
    return self;
}

@end