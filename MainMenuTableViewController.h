//
//  MainMenuViewController.h
//  ServiceNow
//
//  Created by Developer on 6/12/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableViewCell *openTicketsCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *closedTicketsCell;

@end
