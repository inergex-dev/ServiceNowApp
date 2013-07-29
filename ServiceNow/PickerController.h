//
//  ImpactPickerController.h
//  ServiceNow
//
//  Created by Developer on 7/24/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Ticket;
@class SelectedRow;

@interface PickerController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    NSArray *pickerArray;
    Ticket *ticket;
    SelectedRow *pickerRow;
}

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) NSArray *pickerArray;
@property (strong, nonatomic) Ticket *ticket;
@property (strong, nonatomic) SelectedRow *pickerRow;

- (IBAction)confirmed:(id)sender;

@end




// Allows an int value to be passed around with a pointer (without the original int value needing to be a pointer).
@interface SelectedRow : NSObject {
    int row;
}
@property int row;
- (id)initWithRow:(int)myRow;
@end