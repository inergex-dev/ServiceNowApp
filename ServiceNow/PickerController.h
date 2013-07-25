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





@interface SelectedRow : NSObject {
    int row;
}
@property int row;
- (id)initWithRow:(int)myRow;
@end