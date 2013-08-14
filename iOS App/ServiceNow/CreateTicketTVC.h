//
//  CreateTicketViewController.h
//  ServiceNow
//
//  Created by Developer on 6/14/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOAPRequest.h"
@class Ticket;
@class SelectedRow;

@interface CreateTicketTVC : UITableViewController <UITextFieldDelegate, SOAPRequestDelegate> {
    Ticket *ticket;
    NSMutableArray *sections;
    
    SelectedRow *pickerRow;
    
    UITableViewCell *severityCell;
    UITextField *shortDescTB;
    UITextField *commentsTB;
}

@property (strong, nonatomic) Ticket *ticket;

- (IBAction)send:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end
