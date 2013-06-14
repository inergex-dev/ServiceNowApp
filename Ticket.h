//
//  Ticket.h
//  ServiceNow
//
//  Created by Developer on 6/12/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject {
    NSString *shortDesc;
    
    NSString *userName;
    NSString *firstName;
    NSString *lastName;
}

@property (nonatomic, retain) NSString *shortDesc;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;

-(id)init:(NSString *)shortDesc;

@end