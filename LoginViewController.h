//
//  LoginViewController.h
//  ServiceNow
//
//  Created by Developer on 6/11/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginViewController;
@class Reachability;

@interface LoginViewController : UIViewController <UIAlertViewDelegate> {
    Reachability *reach;
}

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (strong, nonatomic) Reachability *reach;

//- (void)autoLogin;
- (IBAction)attemptlogin:(id)sender;
- (BOOL)confirmLoginUsername:(NSString*)username password:(NSString*)password;

@end
