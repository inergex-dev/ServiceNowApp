//
//  LoginViewController.m
//  ServiceNow
//
//  Created by Developer on 6/11/13.
//  Copyright (c) 2013 Inergex. All rights reserved.
//

#import "LoginViewController.h"
#import "SOAPRequest.h"
#import "Utility.h"

@implementation LoginViewController

#define USERFIELD_TAG 1
#define PASSFIELD_TAG 2

@synthesize usernameTextField, passwordTextField, loginButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [Utility initialize]; // Only needs to be done once for program, so done on first view load.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Check if login information is stored.
    NSString* username = [Utility getUsername];
    NSString* password = [Utility getPassword];
    //NSLog(@"Username: %@\nPassword: %@", (username ? username : @"--No Username--"), (password ? password : @"--No Password--"));
    
    // If: credentials are stored
    if (username && password) {
        // Then: imput them into fields
        usernameTextField.text = username;
        passwordTextField.text = password;
        //[self attemptlogin:Nil];
    }
}

- (IBAction)attemptlogin:(id)sender
{
    SOAPRequest* soap = [[SOAPRequest alloc] initWithDelegate:self];
    [Utility showLoadingAlert:@"Logging In"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:usernameTextField.text forKey:@"username"];
    [parameters setValue:passwordTextField.text forKey:@"password"];
    [soap sendSOAPRequestForMethod:@"login" withParameters:parameters];
}

- (void)returnedSOAPResult:(TBXMLElement*)element
{
    [Utility dismissLoadingAlert];
    
    if([[TBXML textForElement:element] isEqual: @"true"]) {
        // Store the passwords
        [[NSUserDefaults standardUserDefaults] setObject:usernameTextField.text forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] setObject:passwordTextField.text forKey:@"password"];
        
        //NSLog(@"Credentials stored - username:%@ password:%@",
        //      [[NSUserDefaults standardUserDefaults] valueForKey:@"username"],
        //      [[NSUserDefaults standardUserDefaults] valueForKey:@"password"]);
        
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Incorrect Credentials" message:@"The username or password you entered isn't correct. Try entering it again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
}

- (void)returnedSOAPError:(NSError *)error
{
    [Utility dismissLoadingAlert];
    
    if(error.code == NO_INTERNET_CODE)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Not Found" message:@"No internet connection found, please connect and try again." delegate:self cancelButtonTitle:@"Retry" otherButtonTitles: @"Alright", Nil];
        alert.tag = NO_INTERNET_CODE;
        [alert show];
    }else{
        [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error %i",error.code] message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        NSLog(@"SOAP XML Error:%@ %@", [error localizedDescription], [error userInfo]);
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == NO_INTERNET_CODE)
    {
        if(buttonIndex == 0) {
            [alertView dismissWithClickedButtonIndex:-1 animated:NO];
            [self attemptlogin:Nil];
        }
    }
}

// Keyboard disappears if user touches screen - http://mobile.tutsplus.com/tutorials/iphone/ios-sdk-uitextfield-uitextfielddelegate/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

// Dictates how a field behaves when the return button is clicked - http://mobile.tutsplus.com/tutorials/iphone/ios-sdk-uitextfield-uitextfielddelegate/
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == USERFIELD_TAG) {
        // Should switch to passwordTextField
        [passwordTextField becomeFirstResponder];
    }
    else if (textField.tag == PASSFIELD_TAG) {
        // Should submit the query
        [self attemptlogin:Nil];
    }
    return YES;
}

@end
