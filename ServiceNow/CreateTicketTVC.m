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
#define MAX_LENGTH 2

@implementation CreateTicketTVC

- (void)viewDidLoad
{
    [super viewDidLoad]; // Do any additional setup after loading the view.
    
    sections = [[NSMutableArray alloc] init];
    [sections addObject:[NSArray arrayWithObjects:@"Short Description", @"Test", 80, Nil]];
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
    [cell.contentView addSubview:textField];
    
    //cell.textLabel.font = [UIFont systemFontOfSize:17];
    //cell.textLabel.numberOfLines = 0;
    //cell.textLabel.text = [[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT];
    
    return cell;
}

// This will make sure text doesn't excede the expected max length.
// http://stackoverflow.com/questions/2523501/set-uitextfield-maximum-length
- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    NSUInteger textFieldMaxLength = (NSUInteger)[[sections objectAtIndex:textField.tag] objectAtIndex:MAX_LENGTH];
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= textFieldMaxLength || returnKey;
}

@end
