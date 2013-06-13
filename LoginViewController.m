//
//  LoginViewController.m
//  ServiceNow
//
//  Created by Developer on 6/11/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "LoginViewController.h"
@interface LoginViewController ()@end

@implementation LoginViewController

@synthesize usernameTextField;
@synthesize passwordTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {/*Custom initialization*/}
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
	// Do any additional setup after view appears.
    
    NSString* username = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    NSString* password = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
    
    NSLog(@"%@", username ? [@"Username: " stringByAppendingString: username] : @"No Username");
    NSLog(@"%@", password ? [@"Password: " stringByAppendingString: password] : @"No Password");
    
    // If: credentials are stored
    if (username && password) {
        // Then: load them and check if true
        if([self confirmLoginUsername:username password:password]) {
            [self performSegueWithIdentifier:@"loginSegue" sender:self];
        }
    }
}

- (IBAction)attemptlogin:(id)sender
{
    if([self confirmLoginUsername: usernameTextField.text password: passwordTextField.text]) {
        // Store the passwords
        [[NSUserDefaults standardUserDefaults] setObject:usernameTextField.text forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] setObject:passwordTextField.text forKey:@"password"];
        
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    }
}

- (BOOL)confirmLoginUsername:(NSString*)username password:(NSString*)password
{
    // check if correct via internet
    if ([username isEqualToString:@"admin"] && [password isEqualToString:@"pass"]) {
        
        // show the login screen
        return true;
    }
    return false;
}

// Keyboard disappears if user touches screen - http://mobile.tutsplus.com/tutorials/iphone/ios-sdk-uitextfield-uitextfielddelegate/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


#define USERFIELD_TAG 1
#define PASSFIELD_TAG 2
// Dictates how a field behaves when the return button is clicked - http://mobile.tutsplus.com/tutorials/iphone/ios-sdk-uitextfield-uitextfielddelegate/
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == USERFIELD_TAG) {
        NSLog(@"Should switch to passwordTextField");
        [passwordTextField becomeFirstResponder];
    }
    else {
        NSLog(@"Should submit the query");
        [self attemptlogin:textField];
    }
    return YES;
}

@end
