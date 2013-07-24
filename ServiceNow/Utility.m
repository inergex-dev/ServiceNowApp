//
//  Utility.m
//  ServiceNow
//
//  Created by Developer on 7/23/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "Utility.h"

@implementation Utility

static NSString* host = @"inergex.service-now.com";
static NSArray* severityStringArray = Nil;
static NSArray* impactStringArray = Nil;

+ (void)initialize {
    if(!severityStringArray)
        severityStringArray = [NSArray arrayWithObjects:@"High", @"Medium", @"Low", nil];
    if(!impactStringArray)
        impactStringArray = [NSArray arrayWithObjects:@"High", @"Medium", @"Low", nil];
}

+ (NSString*) getHost { return host; }

+ (NSArray*) getSeverityStringArray { return severityStringArray; }

/** Takes a severity (1-3) and returns the corresponding string. */
+ (NSString*) severityIntToString:(int)num
{
    return [severityStringArray objectAtIndex:num - 1];
}

+ (NSArray*) getImpactStringArray { return impactStringArray; }

/** Takes a severity (1-3) and returns the corresponding string. */
+ (NSString*) impactIntToString:(int)num
{
    return [NSString stringWithFormat:@"%i - %@", num, [impactStringArray objectAtIndex:num - 1]];
}

@end
