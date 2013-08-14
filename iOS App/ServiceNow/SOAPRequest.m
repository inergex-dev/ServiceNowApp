//
//  SOAPRequest.m
//  ServiceNow
//
//  Created by Developer on 8/5/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "SOAPRequest.h"
#import "TBXML.h"
#import "Utility.h"

//http://www.devx.com/wireless/Article/43209/0/page/3
@implementation SOAPRequest
@synthesize delegate;

int NO_INTERNET_CODE = -1009;

- (id)initWithDelegate:(id <SOAPRequestDelegate>) myDelegate
{
    self = [self init];
    
    delegate = myDelegate;
    
    return self;
}

- (void) sendSOAPRequestForMethod:(NSString*)mName withParameters:(NSDictionary*)parameterDict
{
    methodName = [mName copy];
    
    NSMutableString* method = [[NSMutableString alloc] initWithFormat:@"<tem:%@>", methodName];
    for (NSString* key in parameterDict) {
        [method appendFormat:@"<tem:%@>%@</tem:%@>", key, [parameterDict objectForKey:key], key];
    }
    [method appendFormat:@"</tem:%@>", methodName];
    
    NSString *soapMsg = [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
     "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\">"
        "<soapenv:Body>"
            "%@"//Method
        "</soapenv:Body>"
     "</soapenv:Envelope>"
     , method
     ];
    
    //NSLog(@"%@", soapMsg);
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: @"http://dev-igx02:3636/Service1.svc"]];
    [req setHTTPMethod:@"POST"];
    //---set the headers---
    [req addValue:@"text/xml; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:[NSString stringWithFormat:@"http://tempuri.org/IServiceNow/%@", methodName] forHTTPHeaderField:@"SOAPAction"];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    if (conn) webData = [NSMutableData data];
}

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response {
    [webData setLength: 0];
}
-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *) data {
    [webData appendData:data];
}
-(void) connection:(NSURLConnection *) connection didFailWithError:(NSError *) error {
    webData = Nil;
    connection = Nil;
    NSLog(@"didFailWithError: %@", error.userInfo);
    [delegate returnedSOAPError:error];
}

-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
    //NSLog(@"DONE. Received Bytes: %d", [webData length]);
    NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    webData = Nil;
    
    //---shows the XML---
    NSLog(@"%@", theXML);
    
    NSError *error;
    TBXML *tbxml = [TBXML newTBXMLWithXMLString:theXML error:&error];
    if (error) {
        [delegate returnedSOAPError:error];
    } else if (tbxml.rootXMLElement) {
        TBXMLElement *parent = tbxml.rootXMLElement->firstChild->firstChild;
        if([[TBXML elementName:parent] isEqual:@"s:Fault"]) {
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:[TBXML textForElement:parent->firstChild] forKey:NSLocalizedDescriptionKey];
            [delegate returnedSOAPError:[NSError errorWithDomain:@"myDomain" code:2463 userInfo:errorDetail]];
        } else {
            //[self traverseElement:root];
            TBXMLElement *result = [TBXML childElementNamed:[NSString stringWithFormat:@"%@Result",methodName] parentElement:parent];
            [delegate returnedSOAPResult:result];
        }
    } else {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:@"Cannot find root node." forKey:NSLocalizedDescriptionKey];
        [delegate returnedSOAPError:[NSError errorWithDomain:@"myDomain" code:12321 userInfo:errorDetail]];
    }
}

- (void) traverseElement:(TBXMLElement *)element {
    do {
        // Display the name of the element
        NSLog(@"%@: %@",[TBXML elementName:element],[TBXML textForElement:element]);
        
        // Obtain first attribute from element
        TBXMLAttribute * attribute = element->firstAttribute;
        
        // if attribute is valid
        while (attribute) {
            // Display name and value of attribute to the log window
            NSLog(@"%@->%@ = %@",  [TBXML elementName:element],
                  [TBXML attributeName:attribute],
                  [TBXML attributeValue:attribute]);
            
            // Obtain the next attribute
            attribute = attribute->next;
        }
        
        // if the element has child elements, process them
        if (element->firstChild)
            [self traverseElement:element->firstChild];
        
        // Obtain next sibling element
    } while ((element = element->nextSibling));
}

@end
