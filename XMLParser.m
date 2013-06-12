//
//  XMLParser.m
//  ServiceNow
//
//  Created by Developer on 6/12/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "XMLParser.h"
#import "Ticket.h";

@implementation XMLParser
@synthesize ticket, tickets;

- (XMLParser *) initXMLParser {
    [super init];
    // init array of user objects
    tickets = [[NSMutableArray alloc] init];
    return self;
}

- (void)parser:         (NSXMLParser *) parser
        didStartElement:(NSString *)    elementName
        namespaceURI:   (NSString *)    namespaceURI
        qualifiedName:  (NSString *)    qualifiedName
        attributes:     (NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"ticket"]) {
        NSLog(@"ticket element found – create a new instance of Ticket class...");
        ticket = [[Ticket alloc] init];
        //We do not have any attributes in the user elements, but if
        // you do, you can extract them here:
        // user.att = [[attributeDict objectForKey:@"<att name>"] ...];
    }
}

@end