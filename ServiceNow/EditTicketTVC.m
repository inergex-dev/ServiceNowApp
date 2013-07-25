//
//  EditTicketTVC.m
//  ServiceNow
//
//  Created by Developer on 7/19/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "EditTicketTVC.h"
#import "PickerController.h"
#import "Ticket.h"
#import "Utility.h"

#define TYPE 0
#define TITLE 1
#define CONTENT 2
#define UI_OBJECT_NAME 3
#define MAX_LENGTH 4

#define TYPE_PICKER @"Picker"
#define TYPE_TEXTBOX @"Textbox"

@implementation EditTicketTVC

@synthesize realTicket, ticket;

- (void)viewDidLoad
{
    [super viewDidLoad]; // Do any additional setup after loading the view.
    
    ticket = [realTicket copy];
    pickerRow = [[SelectedRow alloc] init];
    [self getSectionsFromTicket];
    selectedForPickerTag = -1;
}

- (void)viewDidAppear:(BOOL)animated
{
    if(selectedForPickerTag != -1) {
        if(selectedForPickerTag == impactCell.tag) {
            ticket.impact = pickerRow.row + 1;
        }
        else if(selectedForPickerTag == stateCell.tag) {
            ticket.state = pickerRow.row;
        }
        selectedForPickerTag = -1;
    }
    
    if(shortDescTB != Nil)
        ticket.short_description = [shortDescTB.text copy];
    if(commentsTB != Nil)
        ticket.comments = [commentsTB.text copy];
    
    [self getSectionsFromTicket];
    
    [self.tableView reloadData];
}

- (void)getSectionsFromTicket
{
    // There's apparently an issue with storing UI objects in the array, so the object's name is stored instead.
    sections = [[NSMutableArray alloc] init];
    [sections addObject:[NSArray arrayWithObjects:
                         TYPE_PICKER,
                         @"Impact",
                         [Utility impactIntToString:ticket.impact],
                         @"impactCell",
                         [NSNumber numberWithInt:40],
                         Nil]];
    [sections addObject:[NSArray arrayWithObjects:
                         TYPE_PICKER,
                         @"State",
                         [Utility stateIntToString:ticket.state],
                         @"stateCell",
                         [NSNumber numberWithInt:40],
                         Nil]];
    [sections addObject:[NSArray arrayWithObjects:
                         TYPE_TEXTBOX,
                         @"Short Description",
                         ticket.short_description,
                         @"shortDescTB",
                         [NSNumber numberWithInt:80],
                         Nil]];
    [sections addObject:[NSArray arrayWithObjects:
                         TYPE_TEXTBOX,
                         @"Comments",
                         @"",
                         @"commentsTB",
                         [NSNumber numberWithInt:4000],
                         Nil]];
}

- (IBAction)save:(id)sender
{
    realTicket = [ticket copy];
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
        
        [self setValue:textField forKey:[[sections objectAtIndex:indexPath.section] objectAtIndex:UI_OBJECT_NAME]];
    }
    else if([[[sections objectAtIndex:indexPath.section] objectAtIndex:TYPE] isEqual: TYPE_PICKER])
    {
        cell.textLabel.text = [[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self setValue:cell forKey:[[sections objectAtIndex:indexPath.section] objectAtIndex:UI_OBJECT_NAME]];
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
    
    if(impactCell.tag == cell.tag)
    {
        selectedForPickerTag = cell.tag;
        [self performSegueWithIdentifier:@"pickerSegue" sender:self];
    }
    else if(stateCell.tag == cell.tag)
    {
        selectedForPickerTag = cell.tag;
        [self performSegueWithIdentifier:@"pickerSegue" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pickerSegue"]) {
        PickerController *sequeController = segue.destinationViewController;
        sequeController.ticket = self.ticket;
        
        if(selectedForPickerTag == impactCell.tag) {
            sequeController.pickerArray = [Utility getImpactStringArray];
            pickerRow.row = ticket.impact - 1;
            sequeController.pickerRow = pickerRow;
        }
        else if(selectedForPickerTag == stateCell.tag) {
            sequeController.pickerArray = [Utility getStateStringArray];
            pickerRow.row = ticket.state;
            sequeController.pickerRow = pickerRow;
        }
    }
}

@end
