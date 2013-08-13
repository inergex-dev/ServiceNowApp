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
    
    [picker selectRow:pickerRow.row inComponent:0 animated:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
    //http://stackoverflow.com/questions/13352166/uipickerview-cant-autoselect-last-row-when-compiled-under-xcode-4-5-2-ios-6
    // Having this in viewDidAppear is because there's a bug with auto-layout were the last row cannot be selected
    // in viewDidLoad (others work fine, so the select row is there also to avoid un-neccisary animation).
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