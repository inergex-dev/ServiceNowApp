//
//  XMLParser.m
//  ServiceNow
//
//  Created by Developer on 6/12/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//
//  Based of of http://wiki.cs.unh.edu/wiki/index.php/Parsing_XML_data_with_NSXMLParser
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
        // You can extract attributes here:
        // user.att = [[attributeDict objectForKey:@"<att name>"] ...];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!currentElementValue) {
        // init the ad hoc string with the value
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    } else {
        // append value to the ad hoc string
        [currentElementValue appendString:string];
    }
    NSLog(@"Processing value for : %@", string);
}

- (void)parser          :(NSXMLParser *)parser
        didEndElement   :(NSString *)   elementName
        namespaceURI    :(NSString *)   namespaceURI
        qualifiedName   :(NSString *)   qName
{
    if ([elementName isEqualToString:@"tickets"]) {
        // We reached the end of the XML document
        return;
    }
    
    if ([elementName isEqualToString:@"ticket"]) {
        // We are done with user entry – add the parsed ticket
        // object to our ticket array
        [tickets addObject:ticket];
        // release user object
        [ticket release];
        ticket = nil;
    } else {
        // The parser hit one of the element values.
        // This syntax is possible because Ticket object
        // property names match the XML user element names
        [ticket setValue:currentElementValue forKey:elementName];
    }
    
    [currentElementValue release];
    currentElementValue = nil;
}

@end