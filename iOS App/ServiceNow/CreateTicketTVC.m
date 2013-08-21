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
#import "SOAPRequest.h"
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
                         @"severityCell",
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
        
        SOAPRequest* soap = [[SOAPRequest alloc] initWithDelegate:self];
        [soap sendSOAPRequestForMethod:@"createTicket" withParameters:
         [[SOAPRequestParameter alloc] initWithKey:@"username" value:[Utility getUsername]],
         [[SOAPRequestParameter alloc] initWithKey:@"password" value:[Utility getPassword]],
         [[SOAPRequestParameter alloc] initWithKey:@"shortDescription" value:shortDescTB.text],
         [[SOAPRequestParameter alloc] initWithKey:@"comments" value:commentsTB.text],
         //[[SOAPRequestParameter alloc] initWithKey:@"severity" value:[NSString stringWithFormat:@"%i", ticket.severity]],
         nil];
    }
}

- (IBAction)cancel:(id)sender
{
    //http://stackoverflow.com/questions/14143095/storyboard-prepareforsegue
    // Pops this view of the navigation controller to achieve the same effect as hitting the back key.
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)returnedSOAPResult:(TBXMLElement*)element
{
    [Utility dismissLoadingAlert];
    
    if([[TBXML textForElement:element] isEqual: @"true"]) {
        [[[UIAlertView alloc] initWithTitle:@"Ticket Sent" message:@"You ticket has been sent succesfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Not Found" message:@"No internet connection found, please connect and try again." delegate:self cancelButtonTitle:@"Retry" otherButtonTitles: @"Cancel", Nil];
        alert.tag = NO_INTERNET_CODE;
        [alert show];
    }else{
        [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error %i",error.code] message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        NSLog(@"SOAP XML Error:%@ %@", [error localizedDescription], [error userInfo]);
    }
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
    
    if(severityCell.tag == cell.tag) {
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
            [self send:Nil];
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
        
        sequeController.pickerArray = [Utility getSeverityStringArray];
        pickerRow.row = ticket.severity - 1;
        sequeController.pickerRow = pickerRow;
    }
}

@end
