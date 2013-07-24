//
//  ImpactPickerController.h
//  ServiceNow
//
//  Created by Developer on 7/24/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImpactPickerController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    NSArray *impactArray;
    int selectedRow;
}

@property (nonatomic, assign) id delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *impactPicker;
@property int selectedRow;

- (IBAction)confirmed:(id)sender;

@end