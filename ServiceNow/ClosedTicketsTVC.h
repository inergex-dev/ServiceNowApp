//
//  ClosedTicketsTableViewController.h
//  ServiceNow
//
//  Created by Developer on 6/24/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
@class Ticket;
@class Reachability;

@interface ClosedTicketsTVC : PullRefreshTableViewController {
    Ticket *selectedTicket;
    
    Reachability *reach;
}

@property (strong, nonatomic) Ticket *selectedTicket;
@property (nonatomic, retain) NSArray *ticketsArray;
@property (nonatomic, retain) Reachability *reach;

@end