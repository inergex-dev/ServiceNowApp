//
//  LoginViewController.h
//  ServiceNow
//
//  Created by Developer on 6/11/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOAPRequest.h"

@class LoginViewController;
@class Reachability;

@interface LoginViewController : UIViewController <UIAlertViewDelegate, SOAPRequestDelegate>

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

//- (void)autoLogin;
- (IBAction)attemptlogin:(id)sender;

@end
