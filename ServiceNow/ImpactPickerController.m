//
//  ImpactPickerController.m
//  ServiceNow
//
//  Created by Developer on 7/24/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "ImpactPickerController.h"
#import "EditTicketTVC.h"
#import "Utility.h"

@implementation ImpactPickerController
@synthesize delegate, impactPicker, selectedRow;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    impactArray = [Utility getImpactStringArray];
    impactPicker.delegate = self;
    
    [impactPicker selectRow:selectedRow inComponent:0 animated:NO];
}

- (IBAction)confirmed:(id)sender
{
    EditTicketTVC *myController = self.delegate;
    [myController setTicketImpact:selectedRow];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark picker view methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%i row selected.", row);
    selectedRow = row;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return impactArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [impactArray objectAtIndex:row];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"testing");
    EditTicketTVC *ticketTableViewController = segue.destinationViewController;
    
    [ticketTableViewController setTicketImpact: selectedRow];
}

@end