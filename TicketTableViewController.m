//
//  TicketViewController.m
//  ServiceNow
//
//  Created by Developer on 6/14/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "TicketTableViewController.h"
#import "Ticket.h"

@implementation TicketTableViewController

@synthesize ticket;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Display Ticket
    self.navigationItem.title = ticket.shortDesc;
    
    NSMutableArray *cells = [[NSMutableArray alloc] init];
    static NSString *CellIdentifier = @"Cell";
    
    if([ticket.comments isEqualToString:@"-"] == NO)
    {
        //[self ]
        
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) { cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]; }
        
        //UILabel *cellHeader
        
        //[cell addSubview:(UIView *)];
        
        [cells addObject:ticket];
    }
}

@end
