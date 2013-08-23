//
//  TicketViewController.m
//  ServiceNow
//
//  Created by Developer on 6/14/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "ViewClosedTicketTVC.h"
#import "EditTicketTVC.h"
#import "Utility.h"
#import "Ticket.h"

#define TITLE 0
#define CONTENT 1

@implementation ViewClosedTicketTVC

@synthesize ticket;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Display Ticket
    //self.navigationItem.title = ticket.short_description;
    
    //http://www.icodeblog.com/2010/12/10/implementing-uitableview-sections-from-an-nsarray-of-nsdictionary-objects/
    sections = [[NSMutableArray alloc] init];
    
    [sections addObject:[NSArray arrayWithObjects:@"Short Description", ticket.short_description, Nil]];
    [sections addObject:[NSArray arrayWithObjects:@"Closed", ticket.closed_at, Nil]];
    [sections addObject:[NSArray arrayWithObjects:@"Impact", [Utility impactIntToString:ticket.impact], Nil]];
    [sections addObject:[NSArray arrayWithObjects:@"State", [Utility stateIntToString:ticket.state], Nil]];
    if(ticket.comments.count > 0) {
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
    if([[[sections objectAtIndex:section] objectAtIndex:CONTENT] isKindOfClass:[NSArray class]])
        return ((NSArray *)[[sections objectAtIndex:section] objectAtIndex:CONTENT]).count;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = Nil;
    if([[[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT] isKindOfClass:[NSArray class]]) {
        cellText = [[[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT] objectAtIndex:indexPath.row];
    } else {
        cellText = [[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT];
    }
    
    CGSize stringSize = [cellText sizeWithFont: [UIFont systemFontOfSize:17]
                             constrainedToSize: CGSizeMake(280, 9999)
                                 lineBreakMode: NSLineBreakByWordWrapping];
    return stringSize.height + 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = Nil;
    if([[[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT] isKindOfClass:[NSArray class]]) {
        cellText = [[[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT] objectAtIndex:indexPath.row];
    } else {
        cellText = [[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT];
    }
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = cellText;
    
    return cell;
}

@end
