//
//  LogInViewController.m
//  Looped
//
//  Created by Barbara Wong on 4/20/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import "LoginViewController.h"
#import "NewsfeedViewController.h"
#import "Variables.h"
#import "Parse/Parse.h"


@implementation LoginViewController
@synthesize userName;
@synthesize password;
@synthesize topBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.userName setDelegate:self];
    [self.password setDelegate:self];
    
    PFUser *currentUser = [PFUser currentUser];
    if(currentUser){
        self.userName.text = currentUser.username;
        self.createAccountButton.enabled = NO;
    }else{
        self.createAccountButton.enabled = YES;
    }
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

-(NSUInteger) supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}


-(void)textFieldDidBeginEditing:(UITextField *)textfield
{
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 150, self.view.frame.size.width, self.view.frame.size.height);
    
    self.topBar.frame = CGRectMake(self.topBar.frame.origin.x,self.topBar.frame.origin.y + 150,self.topBar.frame.size.width, self.topBar.frame.size.height);
}
- (IBAction)creatingAccount:(id)sender {
    [self performSegueWithIdentifier:@"creatingAccount" sender:self];
}

-(void)textFieldDidEndEditing:(UITextField *)textfield
{
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 150, self.view.frame.size.width, self.view.frame.size.height);
    
    self.topBar.frame = CGRectMake(self.topBar.frame.origin.x,self.topBar.frame.origin.y - 150,self.topBar.frame.size.width, self.topBar.frame.size.height);
}

-(IBAction)LogIn:(id)sender
{
    [PFUser logInWithUsernameInBackground:self.userName.text password:self.password.text block:^(PFUser *user, NSError *error) {
         if (user) {
            NSString *welcome  = [NSString stringWithFormat:@"%@ %@ %@",@"Welcome back",user.username,@"!"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:welcome message: @"Your Looped Account has been loaded" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                 [alert show];
             [self performSegueWithIdentifier:@"logInSuccess" sender:self];
         } else {
            NSString *errorString = [error userInfo][@"error"];
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Account Info" message:errorString delegate:self cancelButtonTitle:@"dismiss"otherButtonTitles:nil];
              [alert show];
          }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
