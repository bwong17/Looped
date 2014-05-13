//
//  SettingsViewController.m
//  Looped
//
//  Created by Barbara Wong on 4/28/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import "SettingsViewController.h"
#import "Parse/Parse.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 - (IBAction)LogOut:(id)sender {
 
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log Out" message:@"Are you sure you want to log out?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
 
 [alert show];
 }
 
 
 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
     PFUser *currentUser = [PFUser currentUser];
     if (buttonIndex == 1) {
         [PFUser logOut];
         currentUser = nil;
         [self performSegueWithIdentifier:@"loggingOut" sender:self];
     }
 }


/*
 - (IBAction)EmailEditting:(UITextField *)sender {
 
 PFUser *currentUser = [PFUser currentUser];
 
 PFQuery *query = [PFQuery queryWithClassName:@"_User"];
 [query getObjectInBackgroundWithId:currentUser.objectId block:^(PFObject *loggedUser, NSError *error) {
 
 loggedUser[@"email"] = self.emailField.text;
 
 self.emailVerified.text = @"Not Verified";
 [self.emailVerified setTextColor:[UIColor redColor]];
 
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Verify Email" message: @"An email has been sent to verify your account." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
 [alert show];
 [loggedUser saveInBackground];
 }];
 }
 */


@end
