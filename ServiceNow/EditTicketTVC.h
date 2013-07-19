//
//  EditTicketTVC.h
//  ServiceNow
//
//  Created by Developer on 7/19/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Ticket;

@interface EditTicketTVC : UITableViewController {
    Ticket *ticket;
    NSMutableArray *sections;
}

@property (strong, nonatomic) Ticket *ticket;

- (IBAction)cancel:(id)sender;

@end
