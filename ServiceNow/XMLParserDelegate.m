//
//  XMLParser.m
//  ServiceNow
//
//  Created by Developer on 6/12/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//
//  Based of of http://wiki.cs.unh.edu/wiki/index.php/Parsing_XML_data_with_NSXMLParser
//

#import "XMLParserDelegate.h"
#import "Ticket.h"

@implementation XMLParserDelegate
@synthesize ticket, tickets, acceptedKeys;

#define TICKETS @"getRecordsResponse"
#define TICKET @"getRecordsResult"

- (XMLParserDelegate *)init {
    [super init];
    // init array of user objects
    tickets = [[NSMutableArray alloc] init];
    acceptedKeys = [NSArray arrayWithObjects:
                    @"short_description",
                    @"comments",
                    @"impact",
                    @"severity",
                    @"state",
                    @"opened_at",
                    @"closed_at",
                    nil];
    return self;
}

//didStartElement
- (void)parser:         (NSXMLParser *) parser
        didStartElement:(NSString *)    elementName
        namespaceURI:   (NSString *)    namespaceURI
        qualifiedName:  (NSString *)    qualifiedName
        attributes:     (NSDictionary *)attributeDict
{
    //http://wiki.cs.unh.edu/wiki/index.php/Parsing_XML_data_with_NSXMLParser
    //http://stackoverflow.com/questions/4705588/nsxmlparser-example
    
    if ([elementName isEqualToString:TICKET]) {
        //NSLog(@"ticket element found – create a new instance of Ticket class...");
        ticket = [[Ticket alloc] init];
        // You can extract attributes here:
        // user.att = [[attributeDict objectForKey:@"<att name>"] ...];
    }
}

//foundCharacters
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (currentElementValue) {
        // append value to the ad hoc string
        [currentElementValue appendString:string];
    } else {
        // init the ad hoc string with the value
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    }
    //NSLog(@"Processing value for : %@", string);
}

//didEndElement
- (void)parser          :(NSXMLParser *)parser
        didEndElement   :(NSString *)   elementName
        namespaceURI    :(NSString *)   namespaceURI
        qualifiedName   :(NSString *)   qName
{
    if ([elementName isEqualToString:TICKETS]) {
        return; // We reached the end of the XML document
    }
    
    if ([elementName isEqualToString:TICKET]) {
        // We are done with user entry – add the parsed ticket
        // object to our ticket array
        [tickets addObject:ticket];
        // release user object
        [ticket release];
        ticket = nil;
    } else {
        // The parser hit one of the element values.
        if([self.acceptedKeys containsObject:elementName]) {
            [currentElementValue setString:[currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            if([elementName isEqualToString:@"someLongKeyThatWasShortenedInTicket"]) {
                [ticket setValue:currentElementValue forKey:@"actualKey"];
            }
            else {
                // This syntax is possible because Ticket object property names match the XML user element names
                [ticket setValue:currentElementValue forKey:elementName];
            }
        }
    }
    
    [currentElementValue release];
    currentElementValue = nil;
}

@end