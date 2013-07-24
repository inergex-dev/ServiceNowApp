//
//  Ticket.h
//  ServiceNow
//
//  Created by Developer on 6/12/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject <NSCopying> {
    NSString *number;
    int state;
    NSString *short_description;
    NSString *comments;
    int severity;
    int impact;
    NSString *opened_at;
    NSString *closed_at;
}

@property (nonatomic, retain) NSString *number;
@property int state;
@property (nonatomic, retain) NSString *short_description;
@property (nonatomic, retain) NSString *comments;
@property int severity;
@property int impact;
@property (nonatomic, retain) NSString *opened_at;
@property (nonatomic, retain) NSString *closed_at;

@end