//
//  CreateTicketViewController.m
//  ServiceNow
//
//  Created by Developer on 6/14/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "CreateTicketTVC.h"

#define TITLE 0
#define CONTENT 1

@implementation CreateTicketTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender
{
    //http://stackoverflow.com/questions/14143095/storyboard-prepareforsegue
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
