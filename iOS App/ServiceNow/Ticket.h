//
//  Ticket.h
//  ServiceNow
//
//  Created by Developer on 6/12/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject <NSCopying> {
    NSString *sys_id;
    int state;
    NSString *short_description;
    NSString *curComment;//For keeping track of the current comment when creating / editing a ticket
    int severity;
    int impact;
    NSString *opened_at;
    NSString *closed_at;
    NSMutableArray *comments;
}

@property (nonatomic, retain) NSString *sys_id;
@property int state;
@property (nonatomic, retain) NSString *short_description;
@property (nonatomic, retain) NSString *curComment;
@property int severity;
@property int impact;
@property (nonatomic, retain) NSString *opened_at;
@property (nonatomic, retain) NSString *closed_at;
@property (nonatomic, retain) NSMutableArray *comments;

-(void)replaceWithTicketCopy:(Ticket*)ticket;

@end