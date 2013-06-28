//
//  TicketViewController.m
//  ServiceNow
//
//  Created by Developer on 6/14/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "TicketTableViewController.h"
#import "Ticket.h"

#define TITLE 0
#define CONTENT 1

@implementation TicketTableViewController

@synthesize ticket;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Display Ticket
    //self.navigationItem.title = ticket.short_description;
    
    //http://www.icodeblog.com/2010/12/10/implementing-uitableview-sections-from-an-nsarray-of-nsdictionary-objects/
    sections = [[NSMutableArray alloc] init];
    
    if([ticket.short_description isEqualToString:@""] == NO) {
        [sections addObject:[NSArray arrayWithObjects:@"Short Description", ticket.short_description, Nil]];
    }
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"4)Create cell");
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

@end
