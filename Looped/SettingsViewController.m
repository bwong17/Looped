//
//  SettingsViewController.m
//  Looped
//
//  Created by Barbara Wong on 4/28/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import "SettingsViewController.h"
#import "Parse/Parse.h"
#import "FacebookSDK/FacebookSDK.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize connectFacebookButton;
@synthesize loading;
@synthesize editPermissionsButton;
@synthesize facebookLogo2;

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
    self.loading.hidden = YES;
    
    PFUser *user = [PFUser currentUser];
    
    if (![PFFacebookUtils isLinkedWithUser:user]){
        [connectFacebookButton setTitle:@"Connect" forState:normal];
        [editPermissionsButton setEnabled:NO];
        [facebookLogo2 setBackgroundColor:[UIColor grayColor]];
        [editPermissionsButton setBackgroundColor:[UIColor grayColor]];
    }
    else{
        [connectFacebookButton setTitle:@"Disconnect" forState:normal];
        [editPermissionsButton setEnabled:YES];
        [facebookLogo2 setBackgroundColor:[UIColor colorWithRed:(0.0/255.0) green:(122.0/255.0) blue:(255.0/255.0) alpha:1.0]];
        [editPermissionsButton setBackgroundColor:[UIColor colorWithRed:(0.0/255.0) green:(122.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    }

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

-(IBAction) ConnectToFacebook: (id) sender{
    
    PFUser *user = [PFUser currentUser];
    NSArray *permissions = @[@"public_profile",@"publish_actions"];
    
    if (![PFFacebookUtils isLinkedWithUser:user]) {
        [PFFacebookUtils linkUser:user permissions:permissions block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Succesfully Connected To Facebook" message:@"Woohoo, user logged in with Facebook!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                
                [alert show];
                [connectFacebookButton setTitle:@"Disconnect" forState:normal];
                [editPermissionsButton setEnabled:YES];
                [facebookLogo2 setBackgroundColor:[UIColor colorWithRed:(0.0/255.0) green:(122.0/255.0) blue:(255.0/255.0) alpha:1.0]];               [editPermissionsButton setBackgroundColor:[UIColor colorWithRed:(0.0/255.0) green:(122.0/255.0) blue:(255.0/255.0) alpha:1.0]];
            }
        }];
        
    }else{
        self.loading.hidden = NO;
        [loading startAnimating];
        
        [PFFacebookUtils unlinkUserInBackground:user block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disconnected From Facebook" message:@"The user is no longer associated with their Facebook account." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                
                [alert show];
                [connectFacebookButton setTitle:@"Connect" forState:normal];
                [editPermissionsButton setEnabled:NO];
                [facebookLogo2 setBackgroundColor:[UIColor grayColor]];
                [editPermissionsButton setBackgroundColor:[UIColor grayColor]];

            }
            self.loading.hidden = YES;
            [loading stopAnimating];

        }];
    }
}
- (IBAction)test:(id)sender {
    
    NSArray *permissionsNeeded = @[@"email",@"user_birthday"];
    
    [PFFacebookUtils reauthorizeUser:[PFUser currentUser] withPublishPermissions:permissionsNeeded audience:FBSessionDefaultAudienceFriends
            block:^(BOOL succeeded, NSError *error) {
        
                if (succeeded) {
                    
                }
    }];
}

@end
