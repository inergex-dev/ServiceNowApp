//
//  EditTicketTVC.h
//  ServiceNow
//
//  Created by Developer on 7/19/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Ticket;

@interface EditTicketTVC : UITableViewController <UITextFieldDelegate> {
    Ticket *realTicket;
    Ticket *ticket;
    
    NSMutableArray *sections;
    UITextField *shortDesc;
    UITableViewCell *impact;
    UITextField *comments;
}

@property (strong, nonatomic) Ticket *realTicket;
@property (strong, nonatomic) Ticket *ticket;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
- (void)setTicketImpact:(int)num;

@end
