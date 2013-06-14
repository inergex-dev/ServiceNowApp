//
//  OpenTicketsTableViewController.h
//  ServiceNow
//
//  Created by Developer on 6/13/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Ticket;

@interface OpenTicketsTableViewController : UITableViewController {
    Ticket *selectedTicket;
}

@property (nonatomic, retain) NSArray *ticketsArray;

@end
