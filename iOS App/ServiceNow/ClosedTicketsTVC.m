//
//  ClosedTicketsTableViewController.m
//  ServiceNow
//
//  Created by Developer on 6/24/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "ClosedTicketsTVC.h"
#import "ViewClosedTicketTVC.h"
#import "Ticket.h"
#import "SOAPRequest.h"
#import "Utility.h"

@implementation ClosedTicketsTVC

@synthesize selectedTicket, ticketsArray, reach;

- (void) viewDidAppear:(BOOL)animated
{
    [self startLoading];
}

- (void)returnedSOAPResult:(TBXMLElement*)element
{
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.0];
    
    TBXMLElement *record = element->firstChild;
    if(record != Nil) ticketsArray = [[NSMutableArray alloc] init];
    
    TBXMLElement *elem;
    Ticket *ticket;
    do {
        ticket = [[Ticket alloc] init];
        
        elem = [TBXML childElementNamed:@"a:systemId" parentElement:record];
        //NSLog(@"%@",[TBXML textForElement:elem]);
        ticket.number = [TBXML textForElement:elem];
        
        elem = [TBXML childElementNamed:@"a:shortDescription" parentElement:record];
        //NSLog(@"%@",[TBXML textForElement:elem]);
        ticket.short_description = [TBXML textForElement:elem];
        
        elem = [TBXML childElementNamed:@"a:openDate" parentElement:record];
        //NSLog(@"%@",[TBXML textForElement:elem]);
        ticket.opened_at = [TBXML textForElement:elem];
        
        elem = [TBXML childElementNamed:@"a:closeDate" parentElement:record];
        //NSLog(@"%@",[TBXML textForElement:elem]);
        ticket.closed_at = [TBXML textForElement:elem];
        
        //elem = [TBXML childElementNamed:@"a:impact" parentElement:record];
        //NSLog(@"%@",[TBXML textForElement:elem]);
        //ticket.impact = [[TBXML textForElement:elem] integerValue];
        
        //elem = [TBXML childElementNamed:@"a:state" parentElement:record];
        //NSLog(@"%@",[TBXML textForElement:elem]);
        //ticket.state = [[TBXML textForElement:elem] integerValue];
        
        [ticketsArray addObject:ticket];
        
        // Obtain next sibling element
    } while ((record = record->nextSibling));
    
    NSLog(@"%i",ticketsArray.count);
    
    [self.tableView reloadData];
}

- (void)returnedSOAPError:(NSError *)error
{
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.0];
    if(error.code == NO_INTERNET_CODE)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Not Found" message:@"No internet connection found, please connect and try again." delegate:self cancelButtonTitle:@"Retry" otherButtonTitles: @"Alright", Nil];
        alert.tag = NO_INTERNET_CODE;
        [alert show];
    }else{
        [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error %i",error.code] message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        NSLog(@"SOAP XML Error:%@ %@", [error localizedDescription], [error userInfo]);
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; // Return the number of sections.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ticketsArray.count; // Return the number of rows
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];// forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = ((Ticket *)[ticketsArray objectAtIndex:indexPath.row]).short_description;
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedTicket = [ticketsArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"closedTicketSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"closedTicketSegue"]) {
        ViewClosedTicketTVC *sequeController = segue.destinationViewController;
        
        sequeController.ticket = selectedTicket;
    }
}

- (void)refresh
{
    SOAPRequest* soap = [[SOAPRequest alloc] initWithDelegate:self];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[Utility getUsername] forKey:@"username"];
    [parameters setValue:[Utility getPassword] forKey:@"password"];
    [soap sendSOAPRequestForMethod:@"getAll" withParameters:parameters];
}

@end