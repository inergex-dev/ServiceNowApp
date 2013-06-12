//
//  XMLParser.h
//  ServiceNow
//
//  Created by Developer on 6/12/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Ticket;

@interface XMLParser : NSObject {
    NSMutableString *currentElementValue; // an ad hoc string to hold element value
    Ticket *ticket; // user object
    NSMutableArray *tickets; // array of user objects
}

@property (nonatomic, retain) Ticket *ticket;
@property (nonatomic, retain) NSMutableArray *tickets;

- (XMLParser *) initXMLParser;

@end