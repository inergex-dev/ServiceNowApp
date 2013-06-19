//
//  TicketViewController.m
//  ServiceNow
//
//  Created by Developer on 6/14/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "TicketViewController.h"
#import "Ticket.h"

@implementation TicketViewController

@synthesize ticket;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = ticket.shortDesc;
}

@end
