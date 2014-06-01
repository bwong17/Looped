//
//  ResetViewController.m
//  Looped
//
//  Created by Barbara Wong on 5/12/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import "ResetViewController.h"
#import "Parse/Parse.h"

@interface ResetViewController ()

@end

@implementation ResetViewController
@synthesize emailAddressField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL) shouldAutorotate { return NO; }

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self emailAddressField];
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nevermindButton:(id)sender {
    
    [self performSegueWithIdentifier:@"backToLogin" sender:self];
    
}
- (IBAction)sendEmail:(id)sender {
    
    [PFUser requestPasswordResetForEmailInBackground:self.emailAddressField.text];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Sent" message:@"Check your email for a reset password link and log in again"delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    
    [alert show];
    
    [self performSegueWithIdentifier:@"backToLogin" sender:self];
}

@end
