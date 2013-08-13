//
//  XMLParser.h
//  ServiceNow
//
//  Created by Developer on 6/12/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Ticket;

@interface XMLParserDelegate : NSObject <NSXMLParserDelegate> {
    NSMutableString *currentElementValue; // an ad hoc string to hold element value
    Ticket *ticket; // user object
    NSMutableArray *tickets; // array of user objects
    
    NSArray *acceptedKeys;
}

@property (nonatomic, retain) Ticket *ticket;
@property (nonatomic, retain) NSMutableArray *tickets;
@property (readonly) NSArray *acceptedKeys;

@end