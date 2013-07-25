//
//  EditTicketTVC.h
//  ServiceNow
//
//  Created by Developer on 7/19/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Ticket;
@class SelectedRow;

@interface EditTicketTVC : UITableViewController <UITextFieldDelegate> {
    Ticket *realTicket;
    Ticket *ticket;
    
    NSMutableArray *sections;
    
    int selectedForPickerTag;
    SelectedRow *pickerRow;
    
    UITableViewCell *impactCell;
    UITableViewCell *stateCell;
    UITextField *shortDescTB;
    UITextField *commentsTB;
}

@property (strong, nonatomic) Ticket *realTicket;
@property (strong, nonatomic) Ticket *ticket;

- (void)getSectionsFromTicket;
- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@end
