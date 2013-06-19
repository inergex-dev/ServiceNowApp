//
//  OpenTicketsTableViewController.h
//  ServiceNow
//
//  Created by Developer on 6/13/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
@class Ticket;
@class Reachability;

@interface OpenTicketsTableViewController : PullRefreshTableViewController {
    Ticket *selectedTicket;
    
    Reachability *internetReachableFoo;
}

@property (nonatomic, retain) NSArray *ticketsArray;

@end
