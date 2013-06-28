//
//  OpenTicketsTableViewController.m
//  ServiceNow
//
//  Created by Developer on 6/13/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "OpenTicketsTableViewController.h"
#import "TicketTableViewController.h"
#import "Ticket.h"
#import "XMLParserDelegate.h"
#import "Reachability.h"

@implementation OpenTicketsTableViewController

@synthesize selectedTicket, ticketsArray, reach;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    reach = [Reachability reachabilityWithHostname:@"www.bing.com"];
    [reach startNotifier];
    
    __weak typeof(self) weakSelf = self; // Used to avoid self being retained in the blocks.
    reach.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf refresh]; // Loads information
            weakSelf.reach.reachableBlock = Nil;
        });
    };
    reach.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf refresh]; // Loads information
            weakSelf.reach.unreachableBlock = Nil;
        });
    };
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
    // Navigation logic may go here. Create and push another view controller.
    //UITableViewController *detailViewController = [[UITableViewController alloc] initWithNibName:@"Nib name" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    //[self.navigationController pushViewController:detailViewController animated:YES];
    
    selectedTicket = [ticketsArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"openTicketSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"openTicketSegue"]) {
        TicketTableViewController *ticketTableViewController = segue.destinationViewController;
        
        ticketTableViewController.ticket = selectedTicket;
    }
}

- (void)refresh
{
    if(reach.isReachable)
    {
        NSData* xmlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://people.rit.edu/tjs7664/test.xml"] ];
        NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:xmlData];
        XMLParserDelegate *parserDelagate = [[XMLParserDelegate alloc] init];
        [nsXmlParser setDelegate:parserDelagate];
        
        BOOL success = [nsXmlParser parse];
        if (success) {
            NSLog(@"No errors - user count : %i", [parserDelagate.tickets count]);
            // get array of tickets here
            self.ticketsArray = parserDelagate.tickets;
        } else {
            NSLog(@"Error parsing document!");
        }
        [self.tableView reloadData];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"No internet connection found, please connect and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.0];
    
    /*
    __weak typeof(self) weakSelf = self; // Used to avoid self being retained in the blocks.
    // set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"REACHABLE!");
            NSData* xmlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://people.rit.edu/tjs7664/test.xml"] ];
            NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:xmlData];
            XMLParserDelegate *parserDelagate = [[XMLParserDelegate alloc] init];
            [nsXmlParser setDelegate:parserDelagate];
            
            BOOL success = [nsXmlParser parse];
            if (success) {
                NSLog(@"No errors - user count : %i", [parserDelagate.tickets count]);
                // get array of tickets here
                weakSelf.ticketsArray = parserDelagate.tickets;
            } else {
                NSLog(@"Error parsing document!");
            }
            [weakSelf.tableView reloadData];
            
            [weakSelf performSelector:@selector(stopLoading) withObject:nil afterDelay:0.0];
        });
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"UNREACHABLE!");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"No internet connection found, please connect and try again." delegate:weakSelf cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        });
    };*/
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //[self refresh];
}

@end
