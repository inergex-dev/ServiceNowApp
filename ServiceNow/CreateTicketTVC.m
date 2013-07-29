//
//  CreateTicketViewController.m
//  ServiceNow
//
//  Created by Developer on 6/14/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "CreateTicketTVC.h"
#import "PickerController.h"
#import "Ticket.h"
#import "Utility.h"

#define TYPE 0
#define TITLE 1
#define CONTENT 2
#define UI_OBJECT 3
#define MAX_LENGTH 4

#define TYPE_PICKER @"Picker"
#define TYPE_TEXTBOX @"Textbox"

@implementation CreateTicketTVC
@synthesize ticket;

- (void)viewDidLoad
{
    [super viewDidLoad]; // Do any additional setup after loading the view.
    
    // Allows the keyboard to be hiden since touchesBegan isn't activated with tableViews
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [tap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tap];
    
    ticket = [[Ticket alloc] init];
    pickerRow = [[SelectedRow alloc] initWithRow:ticket.severity - 1];
    
    shortDescTB = [[UITextField alloc] initWithFrame:CGRectMake(2.0, 4.0, 300.0, 30.0)];
    commentsTB = [[UITextField alloc] initWithFrame:CGRectMake(2.0, 4.0, 300.0, 30.0)];
    
    [self createSectionsFromTicket];
}

- (void)viewDidAppear:(BOOL)animated
{
    ticket.severity = pickerRow.row + 1;
    
    if(shortDescTB != Nil)
        ticket.short_description = [shortDescTB.text copy];
    if(commentsTB != Nil)
        ticket.comments = [commentsTB.text copy];
    
    [self createSectionsFromTicket];
    
    [self.tableView reloadData];
}

- (void)createSectionsFromTicket
{
    // TYPE, Section Header, value, object (Nil if TYPE_PICKER), max size (Nil if TYPE_PICKER)
    sections = [[NSMutableArray alloc] init];
    [sections addObject:[NSArray arrayWithObjects:
                         TYPE_PICKER,
                         @"Severity",
                         [Utility severityIntToString:ticket.severity],
                         Nil,
                         Nil,
                         Nil]];
    [sections addObject:[NSArray arrayWithObjects:
                         TYPE_TEXTBOX,
                         @"Short Description",
                         ticket.short_description,
                         shortDescTB,
                         [NSNumber numberWithInt:80],
                         Nil]];
    [sections addObject:[NSArray arrayWithObjects:
                         TYPE_TEXTBOX,
                         @"Comments",
                         ticket.comments,
                         commentsTB,
                         [NSNumber numberWithInt:4000],
                         Nil]];
}

- (IBAction)send:(id)sender
{
    NSMutableArray *mandatoryFields = [[NSMutableArray alloc] init];
    if(shortDescTB != Nil && [shortDescTB.text isEqual:@""]) {
        [mandatoryFields addObject:@"Short Description"];
    }
    if(commentsTB != Nil && [commentsTB.text isEqual:@""]) {
        [mandatoryFields addObject:@"Comments"];
    }
    
    if(mandatoryFields.count > 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mandatory Fields"
                                                        message:[NSString stringWithFormat:@"The following mandatory fields are not filled in:\n%@", [[mandatoryFields valueForKey:@"description"] componentsJoinedByString:@", "]]
                                                        delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    } else {
        [Utility showLoadingAlert:@"Sending Ticket"];
        [NSThread detachNewThreadSelector:@selector(sendThread) toTarget:self withObject:Nil];
    }
}

- (void)sendThread
{
    [NSThread sleepForTimeInterval:3];
    [Utility dismissLoadingAlert];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender
{
    //http://stackoverflow.com/questions/14143095/storyboard-prepareforsegue
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
        UITextField *textField = (UITextField *)[[sections objectAtIndex:indexPath.section] objectAtIndex:UI_OBJECT];
        textField.delegate = self;
        textField.placeholder = [[sections objectAtIndex:indexPath.section] objectAtIndex:TITLE];
        textField.text = [[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT];
        textField.tag = indexPath.section;
        [cell.contentView addSubview:textField];
        
        //[self setValue:textField forKey:[[sections objectAtIndex:indexPath.section] objectAtIndex:UI_OBJECT_NAME]];
    }
    else if([[[sections objectAtIndex:indexPath.section] objectAtIndex:TYPE] isEqual: TYPE_PICKER])
    {
        cell.textLabel.text = [[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT];
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

- (IBAction)hideKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(severityCell.tag == cell.tag)
    {
        [self performSegueWithIdentifier:@"pickerSegue" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pickerSegue"]) {
        PickerController *sequeController = segue.destinationViewController;
        sequeController.ticket = self.ticket;
        
        sequeController.pickerArray = [Utility getSeverityStringArray];
        pickerRow.row = ticket.severity - 1;
        sequeController.pickerRow = pickerRow;
    }
}

@end
