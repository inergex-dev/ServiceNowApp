//
//  MainMenuViewController.m
//  ServiceNow
//
//  Created by Developer on 6/12/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "MainMenuTableViewController.h"
#import "Ticket.h"

@interface MainMenuTableViewController ()@end

#define CREATE_TAG 1
#define OPEN_TAG 2
#define CLOSED_TAG 3
#define LOGOUT_TAG 4

@implementation MainMenuTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"%@",[@"Selected row with tag: " stringByAppendingFormat:@"%i",cell.tag]);
    switch (cell.tag) {
        case CREATE_TAG:
            // nothing currently
            break;
            
        case OPEN_TAG:
            // nothing currently
            break;
            
        case CLOSED_TAG:
            // nothing currently
            break;
            
        case LOGOUT_TAG:
            // http://stackoverflow.com/questions/545091/clearing-nsuserdefaults
            //[[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
            break;
            
        default:
            break;
    }
    
    [cell setAccessoryView:Nil]; // Gets rid of Activity Indicator if added in prepareForSeque
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(sender == self.openTicketsCell)
    {
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [spinner startAnimating];
        [self.openTicketsCell setAccessoryView:spinner];
        spinner = nil;
        
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    }
    else if(sender == self.closedTicketsCell)
    {
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [spinner startAnimating];
        [self.openTicketsCell setAccessoryView:spinner];
        spinner = nil;
        
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    }
}

@end
