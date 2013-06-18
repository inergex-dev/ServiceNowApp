//
//  MainMenuViewController.m
//  ServiceNow
//
//  Created by Developer on 6/12/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "MainMenuTableViewController.h"
#import "Ticket.h"
#import "XMLParser.h"

@interface MainMenuTableViewController ()@end

#define CREATE_TAG 1
#define OPEN_TAG 2
#define CLOSED_TAG 3
#define LOGOUT_TAG 4

@implementation MainMenuTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { /*Custom initialization*/ }
    return self;
}

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
    
    /*UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    [cell setAccessoryView:spinner];
    spinner = nil;
    //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];*/
    [cell setAccessoryView:Nil];
    NSLog(@"1111");
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"preparing for seque");
    if(sender == self.openTicketsCell)
    {
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [spinner startAnimating];
        [self.openTicketsCell setAccessoryView:spinner];
        spinner = nil;
        //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];

    }
    else if(sender == self.closedTicketsCell)
    {
        
    }
}

- (NSMutableArray*)retrieveTicketsFromUrl:(NSString*)url
{
    // Get Array
    NSMutableArray *tickets = Nil;
    NSData *xmlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url] ];
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:xmlData];
    XMLParser *parserDelagate = [[XMLParser alloc] initXMLParser];
    [nsXmlParser setDelegate:parserDelagate];
    
    BOOL success = [nsXmlParser parse];
    if (success) {
        NSLog(@"No errors - user count : %i", [parserDelagate.tickets count]);
        // get array of tickets here
        tickets = parserDelagate.tickets;
    } else {
        NSLog(@"Error parsing document!");
    }
    
    xmlData = Nil;
    nsXmlParser = Nil;
    parserDelagate = Nil;
    
    return tickets;
}

@end
