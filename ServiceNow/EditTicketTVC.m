//
//  EditTicketTVC.m
//  ServiceNow
//
//  Created by Developer on 7/19/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "EditTicketTVC.h"
#import "Ticket.h"

#define TITLE 0
#define CONTENT 1

@implementation EditTicketTVC

@synthesize ticket;

- (void)viewDidLoad
{
    [super viewDidLoad]; // Do any additional setup after loading the view.
    
    sections = [[NSMutableArray alloc] init];
    
    if([ticket.short_description isEqualToString:@""] == NO) {
        [sections addObject:[NSArray arrayWithObjects:@"Short Description", ticket.short_description, Nil]];
    }
    if([ticket.comments isEqualToString:@""] == NO) {
        [sections addObject:[NSArray arrayWithObjects:@"Comments", ticket.comments, Nil]];
    }
}

- (IBAction)cancel:(id)sender
{
    // Pops this view of the navigation controller to achieve the same effect as hitting the back key.
    [self.navigationController popViewControllerAnimated:YES];
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
    /*CGSize maximumSize1 = CGSizeMake(280, 9999);
     NSString *myString1 = [[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT];
     UIFont *myFont1 = [UIFont systemFontOfSize:17];
     UILabel *lbl_Title=[[UILabel alloc] init];
     
     CGSize stringSize = [myString1 sizeWithFont:myFont1
     constrainedToSize:maximumSize1
     lineBreakMode:lbl_Title.lineBreakMode];
     return stringSize.height + 3;*/
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    //UITextField *textField = [[UITextField alloc] init];
    //[cell addSubview:textField];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(2.0, 4.0, 300.0, 30.0)];
    //textField.delegate = self;
    textField.placeholder = [[sections objectAtIndex:indexPath.section] objectAtIndex:TITLE];
    textField.text = [[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT];
    [cell.contentView addSubview:textField];
    
    //cell.textLabel.font = [UIFont systemFontOfSize:17];
    //cell.textLabel.numberOfLines = 0;
    //cell.textLabel.text = [[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT];
    
    return cell;
}

@end
