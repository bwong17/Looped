//
//  NewAccountViewController.m
//  Looped
//
//  Created by Barbara Wong on 4/20/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import "NewAccountViewController.h"
#import "Variables.h"
#import "Parse/Parse.h"

@implementation NewAccountViewController

@synthesize firstName;
@synthesize lastName;
@synthesize userName;
@synthesize password;

@synthesize genderLabel;
@synthesize ddMenuGender;

-(BOOL) shouldAutorotate { return NO; }

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (IBAction)cancelNewAccount:(id)sender {
    [self performSegueWithIdentifier:@"cancelNewAccount" sender:self];
}

- (IBAction)GenderDropDown:(UIButton *)sender
{
    if (sender.tag == 0) {
        sender.tag = 1;
        self.ddMenuGender.hidden = NO;
        
    } else {
        sender.tag = 0;
        self.ddMenuGender.hidden = YES;
    }

}
- (IBAction)ddMenuGenderSelectionMade:(UIButton *)sender {
    
    self.genderLabel.titleLabel.text = sender.titleLabel.text;
    
    self.genderLabel.tag = 0;
    self.ddMenuGender.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)createdAccount:(id)sender {
    
    PFUser *user = [PFUser currentUser];
    
    user.username = self.userName.text;
    user.password = self.password.text;
    
    user[@"firstName"] = self.firstName.text;
    user[@"lastName"] = self.lastName.text;
    user[@"gender"] = self.genderLabel.titleLabel.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSString *errorString = [error userInfo][@"error"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Account Info" message:errorString delegate:self cancelButtonTitle:@"dismiss"otherButtonTitles:nil];
            [alert show];
        }else{
            NSLog(@"Added %@",user.username);
            NSString *welcomeMessage = [NSString stringWithFormat: @"%@ %@ %@",@"Welcome",self.firstName.text, self.lastName.text];
     
        [self performSegueWithIdentifier:@"createAccount" sender:self];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:welcomeMessage message:@"Your Looped profile has been created" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
     
        }
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.firstName setDelegate:self];
    [self.lastName setDelegate:self];
    [self.userName setDelegate:self];
    [self.password setDelegate:self];
}

@end
