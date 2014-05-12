//
//  ProfileViewController.m
//  Looped
//
//  Created by Barbara Wong on 4/20/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import "ProfileViewController.h"
#import "Variables.h"
#import "Parse/Parse.h"

@implementation ProfileViewController
@synthesize ProfileLabel;
@synthesize firstNameLabel;
@synthesize lastNameLabel;
@synthesize profileImage;
@synthesize birthdayDay;
@synthesize birthdayMonth;
@synthesize birthdayYear;
@synthesize emailField;
@synthesize statusIndicator;
@synthesize emailVerified;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.birthdayDay setDelegate:self];
    [self.birthdayMonth setDelegate:self];
    [self.birthdayYear setDelegate:self];
    [self.emailField setDelegate:self];
    
    self.statusIndicator.hidden = NO;
    [statusIndicator startAnimating];
    
    PFUser *currentUser = [PFUser currentUser];
    
    NSString *label = [NSString stringWithFormat:@"%@'s Profile",currentUser.username];
    self.ProfileLabel.text = label;
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
        [query getObjectInBackgroundWithId:currentUser.objectId block:^(PFObject *loggedUser, NSError *error) {
            
            
            NSString *firstName = loggedUser[@"firstName"];
            NSString *lastName = loggedUser[@"lastName"];
            NSString *gender = loggedUser[@"gender"];
            NSString *month = loggedUser[@"birthMonth"];
            NSString *day = loggedUser[@"birthDay"];
            NSString *year = loggedUser[@"birthYear"];
            NSString *email = loggedUser[@"email"];
            
            self.firstNameLabel.text = firstName;
            self.lastNameLabel.text = lastName;
            self.birthdayMonth.text = month;
            self.birthdayDay.text = day;
            self.birthdayYear.text = year;
            self.emailField.text = email;
                        
            if(loggedUser[@"emailVerified"]){
                self.emailVerified.text = @"Verified";
                [self.emailVerified setTextColor:[UIColor greenColor]];
            }else{
                self.emailVerified.text = @"Not Verified";
                [self.emailVerified setTextColor:[UIColor redColor]];
            }
            
            if([gender isEqualToString:@"Female"]){
                self.profileImage.image = [UIImage imageNamed:@"woman.png"];
            }else if ([gender isEqualToString:@"Male"]){
                self.profileImage.image = [UIImage imageNamed:@"man.png"];
            }else{
                self.profileImage.image = [UIImage imageNamed:@"camera.png"];
            }
            self.statusIndicator.hidden = YES;
            [statusIndicator stopAnimating];
    }];
    
    
}
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

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)edittedBirthMonth:(UITextField *)sender {

    PFUser *currentUser = [PFUser currentUser];
    
    if(self.birthdayMonth.text.intValue < 12 && self.birthdayMonth.text.intValue > 1){
        currentUser[@"birthMonth"] = self.birthdayMonth.text;
        [currentUser saveInBackground];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message: @"Your birth month is invalid. Try Again." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
}
- (IBAction)edittedBirthDay:(UITextField *)sender {
    
    PFUser *currentUser = [PFUser currentUser];

    if(self.birthdayDay.text.intValue < 31 && self.birthdayDay.text.intValue > 0){
        currentUser[@"birthDay"] = self.birthdayDay.text;
        [currentUser saveInBackground];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message: @"Your birth day is invalid. Try Again." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }

}
- (IBAction)edittedBirthYear:(UITextField *)sender {
    
    PFUser *currentUser = [PFUser currentUser];
    
    if(self.birthdayYear.text.intValue < 1996 && self.birthdayYear.text.intValue > 1930){
        currentUser[@"birthYear"] = self.birthdayYear.text;
    
        [currentUser saveInBackground];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message: @"Your birth year is invalid. Must be 18 years or older. Try Again." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
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
@end
