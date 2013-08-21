//
//  Utility.m
//  ServiceNow
//
//  Created by Developer on 7/23/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "Utility.h"

@implementation Utility

static NSString *username = Nil;
static NSString *password = Nil;

static NSArray* severityStringArray = Nil;
static NSArray* impactStringArray = Nil;
static NSArray* stateStringArray = Nil;
static UIAlertView *loadingAlert;

+ (void)initialize {
    if(!severityStringArray)
        severityStringArray = [NSArray arrayWithObjects:@"High", @"Medium", @"Low", nil];
    if(!impactStringArray)
        impactStringArray = [NSArray arrayWithObjects:@"High", @"Medium", @"Low", nil];
    if(!stateStringArray)
        stateStringArray = [NSArray arrayWithObjects:@"New", @"Assigned", @"Work in Progress", @"Pending", @"Resolved", @"Closed Complete", @"Auto Closed", nil];
}

+ (NSString*) getUsername { return username; }//[[NSUserDefaults standardUserDefaults] valueForKey:@"username"]; }
+ (NSString*) getPassword { return password; }//[[NSUserDefaults standardUserDefaults] valueForKey:@"password"]; }
+ (void) setUsername:(NSString*)user password:(NSString*)pass { username = [user copy]; password = [pass copy]; }

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


+ (NSArray*) getStateStringArray { return stateStringArray; }
/** Takes a severity (1-3) and returns the corresponding string. */
+ (NSString*) stateIntToString:(int)num
{
    return [NSString stringWithFormat:@"%@", [stateStringArray objectAtIndex:num]];
}

+ (void) showLoadingAlert
{
    [self showLoadingAlert:@"Loading Data"];
}

+ (void) showLoadingAlert:(NSString*)title
{
    loadingAlert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@\nPlease Wait...",title] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [loadingAlert show];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // Adjust the indicator so it is up a few pixels from the bottom of the alert
    indicator.center = CGPointMake(loadingAlert.bounds.size.width / 2, loadingAlert.bounds.size.height - 50);
    [indicator startAnimating];
    [loadingAlert addSubview:indicator];
}

+ (void) dismissLoadingAlert
{
    if(loadingAlert) {
        [loadingAlert dismissWithClickedButtonIndex:0 animated:YES];
        loadingAlert = Nil;
    }
}

@end
