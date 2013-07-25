//
//  TicketViewController.m
//  ServiceNow
//
//  Created by Developer on 6/14/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "ViewOpenTicketTVC.h"
#import "EditTicketTVC.h"
#import "Utility.h"
#import "Ticket.h"

#define TITLE 0
#define CONTENT 1

@implementation ViewOpenTicketTVC

@synthesize ticket;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Display Ticket
    //self.navigationItem.title = ticket.short_description;
    
    //http://www.icodeblog.com/2010/12/10/implementing-uitableview-sections-from-an-nsarray-of-nsdictionary-objects/
    sections = [[NSMutableArray alloc] init];
    
    [sections addObject:[NSArray arrayWithObjects:@"Short Description", ticket.short_description, Nil]];
    [sections addObject:[NSArray arrayWithObjects:@"Opened", ticket.opened_at, Nil]];
    [sections addObject:[NSArray arrayWithObjects:@"Impact", [Utility impactIntToString:ticket.impact], Nil]];
    [sections addObject:[NSArray arrayWithObjects:@"State", [Utility stateIntToString:ticket.state], Nil]];
    if([ticket.comments isEqualToString:@""] == NO) {
        [sections addObject:[NSArray arrayWithObjects:@"Comments", ticket.comments, Nil]];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sections count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[sections objectAtIndex:section] objectAtIndex:TITLE];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize maximumSize1 = CGSizeMake(280, 9999);
    NSString *myString1 = [[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT];
    UIFont *myFont1 = [UIFont systemFontOfSize:17];
    UILabel *lbl_Title=[[UILabel alloc] init];
    
    CGSize stringSize = [myString1 sizeWithFont:myFont1
                                 constrainedToSize:maximumSize1
                                     lineBreakMode:lbl_Title.lineBreakMode];
    return stringSize.height + 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"editTicketSegue"]) {
        EditTicketTVC *sequeController = segue.destinationViewController;
        
        sequeController.realTicket = self.ticket;
    }
}

@end
