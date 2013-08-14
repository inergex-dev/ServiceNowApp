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
#import "SOAPRequest.h"
#import "Utility.h"

#define TYPE 0
#define TITLE 1
#define CONTENT 2
#define UI_OBJECT 3
#define MAX_LENGTH 4

#define TYPE_PICKER @"Picker"
#define TYPE_TEXTBOX @"Textbox"

@implementation EditTicketTVC

@synthesize realTicket, ticket;

- (void)viewDidLoad
{
    [super viewDidLoad]; // Do any additional setup after loading the view.
    
    // Allows the keyboard to be hiden since touchesBegan isn't activated with tableViews
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [tap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tap];
    
    ticket = [realTicket copy];
    pickerRow = [[SelectedRow alloc] init];
    
    // Initalize the objects here so they aren't created every time the view appears.
    shortDescTB = [[UITextField alloc] initWithFrame:CGRectMake(2.0, 4.0, 300.0, 30.0)];
    commentsTB = [[UITextField alloc] initWithFrame:CGRectMake(2.0, 4.0, 300.0, 30.0)];
    
    selectedForPickerTag = -1;
    [self getSectionsFromTicket];
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
    // TYPE, Section Header, value, UIObject, max size (Nil if TYPE_PICKER)
    sections = [[NSMutableArray alloc] init];
    [sections addObject:[NSArray arrayWithObjects:
                         TYPE_PICKER,
                         @"Impact",
                         [Utility impactIntToString:ticket.impact],
                         @"impactCell",
                         Nil]];
    [sections addObject:[NSArray arrayWithObjects:
                         TYPE_PICKER,
                         @"State",
                         [Utility stateIntToString:ticket.state],
                         @"stateCell",
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

- (IBAction)save:(id)sender
{
    NSMutableArray *mandatoryFields = [[NSMutableArray alloc] init];
    if(shortDescTB != Nil && [shortDescTB.text isEqual:@""]) {
        [mandatoryFields addObject:@"Short Description"];
    }
    
    if(ticket.impact == realTicket.impact && ticket.state == realTicket.state && [shortDescTB.text isEqual:realTicket.short_description] && [commentsTB.text isEqual:realTicket.comments]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Changes"
                                                        message:@"No changes have been made to the ticket, so it has not been saved."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    else if(mandatoryFields.count > 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mandatory Fields"
                                                        message:[NSString stringWithFormat:@"The following mandatory fields are not filled in:\n%@", [[mandatoryFields valueForKey:@"description"] componentsJoinedByString:@", "]]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    } else {
        [Utility showLoadingAlert:@"Saving Data"];
        SOAPRequest* soap = [[SOAPRequest alloc] initWithDelegate:self];
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setValue:[Utility getUsername] forKey:@"username"];
        [parameters setValue:[Utility getPassword] forKey:@"password"];
        [parameters setValue:shortDescTB.text forKey:@"shortDescription"];
        [parameters setValue:commentsTB.text forKey:@"comments"];
        //[parameters setValue:[NSString stringWithFormat:@"%i", ticket.severity] forKey:@"severity"];
        [soap sendSOAPRequestForMethod:@"EEEEEEEEEDDDDDDDDDIIIIIIIIITTTTTTT______TTTIIIICCCKKKKEEETTTTTT" withParameters:parameters];
    }
}

- (void)returnedSOAPResult:(TBXMLElement*)element
{
    [Utility dismissLoadingAlert];
    
    if([[TBXML textForElement:element] isEqual: @"true"]) {
        realTicket = [ticket copy];
        [[[UIAlertView alloc] initWithTitle:@"Ticket Saved" message:@"You ticket has been edited succesfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Incorrect Data" message:@"Service now doesn't like this input. Try entering it again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
}

- (void)returnedSOAPError:(NSError *)error
{
    [Utility dismissLoadingAlert];
    
    if(error.code == NO_INTERNET_CODE)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Not Found" message:@"No internet connection found, please connect and try again." delegate:self cancelButtonTitle:@"Retry" otherButtonTitles: @"Alright", Nil];
        alert.tag = NO_INTERNET_CODE;
        [alert show];
    }else{
        [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error %i",error.code] message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        NSLog(@"SOAP XML Error:%@ %@", [error localizedDescription], [error userInfo]);
    }
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if([[[sections objectAtIndex:indexPath.section] objectAtIndex:TYPE] isEqual: TYPE_TEXTBOX])
    {
        UITextField *textField = (UITextField *)[[sections objectAtIndex:indexPath.section] objectAtIndex:UI_OBJECT];
        textField.delegate = self;
        textField.placeholder = [[sections objectAtIndex:indexPath.section] objectAtIndex:TITLE];
        textField.text = [[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT];
        textField.returnKeyType = UIReturnKeyNext;
        
        textField.tag = indexPath.section;
        [cell.contentView addSubview:textField];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if([[[sections objectAtIndex:indexPath.section] objectAtIndex:TYPE] isEqual: TYPE_PICKER])
    {
        cell.textLabel.text = [[sections objectAtIndex:indexPath.section] objectAtIndex:CONTENT];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self setValue:cell forKey:[[sections objectAtIndex:indexPath.section] objectAtIndex:UI_OBJECT]];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    int currentTag = textField.tag;
    int lastSection = sections.count - 1;
    // If Next (Return) is hit, the next textbox will be selected. If no text boxes are left, send/saves the form.
    while(true)
    {
        if (currentTag < lastSection) {
            currentTag++;
            if([[[sections objectAtIndex:currentTag] objectAtIndex:TYPE] isEqual:TYPE_TEXTBOX])
            {
                UITextField *next = (UITextField*)[[sections objectAtIndex:currentTag] objectAtIndex:UI_OBJECT];
                [self.view endEditing:YES]; // This closes the keyboard so it won't cover the next textField.
                [next becomeFirstResponder]; // selects next textField, and re-opens keyboard (while moving the screen to keep the field visisble).
                break;
            }
            
        } else {
            [self save:Nil];
            break;
        }
    }
    return YES;
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
