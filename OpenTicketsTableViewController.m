//
//  OpenTicketsTableViewController.m
//  ServiceNow
//
//  Created by Developer on 6/13/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "OpenTicketsTableViewController.h"
#import "TicketViewController.h"
#import "Ticket.h"

#import "XMLParser.h"

@implementation OpenTicketsTableViewController

@synthesize ticketsArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {/*Custom initialization*/}
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSData* xmlData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:@"test.xml"] ];
    
    // create and init NSXMLParser object
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:xmlData];
    
    // create and init our delegate
    XMLParser *parser = [[XMLParser alloc] initXMLParser];
    
    // set delegate
    [nsXmlParser setDelegate:parser];
    
    // parsing...
    BOOL success = [nsXmlParser parse];
    
    NSLog(@"%@", success ? @"Yes" : @"No");
    
    ticketsArray = [NSArray arrayWithObjects:
                    [[Ticket alloc] init:@"Test"],
                    [[Ticket alloc] init:@"Test2"],
                    [[Ticket alloc] init:@"bob"],
                    [[Ticket alloc] init:@"honey"],
                    [[Ticket alloc] init:@"iFrog"],
                    [[Ticket alloc] init:@"mexicans"],
                    [[Ticket alloc] init:@"purple"],
                    [[Ticket alloc] init:@"pride land"],
                    [[Ticket alloc] init:@"number 4"],
                    [[Ticket alloc] init:@"Fido"],
                    [[Ticket alloc] init:@"Orphan"],
                    nil
                ];
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
    cell.textLabel.text = ((Ticket *)[ticketsArray objectAtIndex:indexPath.row]).shortDesc;
    
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
        TicketViewController *ticketViewController = (TicketViewController *)segue.destinationViewController;
        
        ticketViewController.ticket = selectedTicket;
    }
}

@end
