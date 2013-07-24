//
//  Utility.h
//  ServiceNow
//
//  Created by Developer on 7/23/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (void) initialize;
+ (NSString*) getHost;
+ (NSArray*) getSeverityStringArray;
+ (NSString*) severityIntToString:(int)num;
+ (NSArray*) getImpactStringArray;
+ (NSString*) impactIntToString:(int)num;

@end
