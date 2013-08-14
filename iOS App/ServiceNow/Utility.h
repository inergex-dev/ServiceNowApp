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

+ (NSString*) getUsername;
+ (NSString*) getPassword;

+ (NSArray*) getSeverityStringArray;
+ (NSString*) severityIntToString:(int)num;

+ (NSArray*) getImpactStringArray;
+ (NSString*) impactIntToString:(int)num;

+ (NSArray*) getStateStringArray;
+ (NSString*) stateIntToString:(int)num;

+ (void) showLoadingAlert;
+ (void) showLoadingAlert:(NSString*)title;
+ (void) dismissLoadingAlert;

@end
