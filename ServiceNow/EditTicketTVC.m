//
//  EditTicketTVC.m
//  ServiceNow
//
//  Created by Developer on 7/19/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "EditTicketTVC.h"
#import "ImpactPickerController.h"
#import "Ticket.h"
#import "Utility.h"

#define TYPE 0
#define TITLE 1
#define CONTENT 2
#define MAX_LENGTH 3

#define TYPE_PICKER @"Picker"
#define TYPE_TEXTBOX @"Textbox"

@implementation EditTicketTVC

@synthesize realTicket, ticket;

- (void)viewDidLoad
{
    [super viewDidLoad]; // Do any additional setup after loading the view.
    ticket = [realTicket copy];
    
    sections = [[NSMutableArray alloc] init];
    [sections addObject:shortDesc = [NSArray arrayWithObjects:TYPE_TEXTBOX, @"Short Description", ticket.short_description, [NSNumber numberWithInt:80], Nil]];
    [sections addObject:impact =    [NSArray arrayWithObjects:TYPE_PICKER, @"Impact", [NSNumber numberWithInt:ticket.impact], Nil]];
    [sections addObject:comments =  [NSArray arrayWithObjects:TYPE_TEXTBOX, @"Comments", ticket.comments, [NSNumber numberWithInt:4000], Nil]];
}

- (void)setTicketImpact:(int)num
{
    ticket.impact = num;
    ticket.short_description = shortDesc.text;
    ticket.comments = comments.text;
    [self.tableView reloadData];
}

- (IBAction)save:(id)sender
{
    NSLog(@"Saved");
}

- (IBAction)cancel:(id)sender
{
    // Pops this view of the navigation controller to achieve the same effect as hitting the back key.
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [sections count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[sections objectAtIndex:section] objectAtIndex:TITLE];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[[sections objectAtIndex:indexPath.section] objectAtIndex:TYPE] isEqual: TYPE_TEXTBOX]) {
        return 30;
    }
    
    // Return default height otherwise
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if([[[sections objectAtIndex:indexPath.section] objectAtIndex:TYPE] isEqual: TYPE_TEXTBOX])
    {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(2.0, 4.0, 300.0, 30.0)];
        textField.delegate = self;
        textField.placeholder = [[sections objectAtIndex:indexPath.section] objectAtIndex:TITLE];
        textField.text = [[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT];
        textField.tag = indexPath.section;
        [cell.contentView addSubview:textField];
    }
    else if([[[sections objectAtIndex:indexPath.section] objectAtIndex:TYPE] isEqual: TYPE_PICKER])
    {
        cell.textLabel.text = [Utility impactIntToString:[(NSNumber *)[[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT] intValue]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.tag = indexPath.section;
    
    return cell;
}

// This will make sure text doesn't excede the expected max length.
// http://stackoverflow.com/questions/2523501/set-uitextfield-maximum-length
- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    NSUInteger textFieldMaxLength = [(NSNumber *)[[sections objectAtIndex:textField.tag] objectAtIndex:MAX_LENGTH] unsignedIntegerValue];
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= textFieldMaxLength || returnKey;
}

// Keyboard disappears if user touches screen - http://mobile.tutsplus.com/tutorials/iphone/ios-sdk-uitextfield-uitextfielddelegate/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    switch (cell.tag) {
        case 1:
            [self performSegueWithIdentifier:@"pickerSegue" sender:self];
            break;
            
        default:
            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pickerSegue"]) {
        ImpactPickerController *ticketViewController = segue.destinationViewController;
        ticketViewController.delegate = self;
        ticketViewController.selectedRow = ticket.impact - 1;
    }
}

@end
