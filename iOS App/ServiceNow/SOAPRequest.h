//
//  SOAPRequest.h
//  ServiceNow
//
//  Created by Developer on 8/5/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"

@protocol SOAPRequestDelegate <NSObject>
//@optional
- (void)returnedSOAPResult:(TBXMLElement*)element;
- (void)returnedSOAPError:(NSError *)error;
@end



@interface SOAPRequest : NSObject <NSXMLParserDelegate> {
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSURLConnection *conn;
    NSString *methodName;
}
@property (nonatomic, weak) id <SOAPRequestDelegate> delegate;
- (NSString*) sendSOAPRequestForMethod:(NSString*)methodName withParameters:(NSDictionary*)parameterArray;
@end