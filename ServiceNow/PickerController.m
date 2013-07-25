//
//  ImpactPickerController.m
//  ServiceNow
//
//  Created by Developer on 7/24/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "PickerController.h"
#import "EditTicketTVC.h"
#import "Ticket.h"
#import "Utility.h"

@implementation PickerController
@synthesize picker, pickerArray, pickerRow, ticket;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    picker.delegate = self;
    
    [picker reloadAllComponents];
    [picker selectRow:pickerRow.row inComponent:0 animated:YES];
}

- (IBAction)confirmed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark picker view methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    pickerRow.row = row;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return pickerArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [pickerArray objectAtIndex:row];
}

@end



@implementation SelectedRow
@synthesize row;

- (id)initWithRow:(int)myRow {
    self = [super init];
    self.row = myRow;
    
    return self;
}

@end