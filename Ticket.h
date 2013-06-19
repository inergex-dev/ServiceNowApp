//
//  Ticket.h
//  ServiceNow
//
//  Created by Developer on 6/12/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject {
    int *number;
    NSString *shortDesc;
    NSString *comments;
    NSString *opened;
    NSString *closed;
}

@property int number;
@property (nonatomic, retain) NSString *shortDesc;
@property (nonatomic, retain) NSString *comments;
@property (nonatomic, retain) NSString *opened;
@property (nonatomic, retain) NSString *closed;

@end