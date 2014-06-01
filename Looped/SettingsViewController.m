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
    
    if (![PFFacebookUtils isLinkedWithUser:user])
        [connectFacebookButton setTitle:@"Connect To Facebook" forState:normal];
    else
        [connectFacebookButton setTitle:@"Disconnect From Facebook" forState:normal];
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
    
    if (![PFFacebookUtils isLinkedWithUser:user]) {
        [PFFacebookUtils linkUser:user permissions:nil block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Succesfully Connected To Facebook" message:@"Woohoo, user logged in with Facebook!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                
                [alert show];
                [connectFacebookButton setTitle:@"Disconnect From Facebook" forState:normal];
            }
        }];
        
    }else{
        self.loading.hidden = NO;
        [loading startAnimating];
        
        [PFFacebookUtils unlinkUserInBackground:user block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disconnected From Facebook" message:@"The user is no longer associated with their Facebook account." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                
                [alert show];
                [connectFacebookButton setTitle:@"Connect To Facebook" forState:normal];
            }
            self.loading.hidden = YES;
            [loading stopAnimating];
            

        }];
    }
}
- (IBAction)test:(id)sender {
    /*
    NSArray *permissionsNeeded = @[@"basic_info", @"user_birthday"];
    
    // Request the permissions the user currently has
    [FBRequestConnection startWithGraphPath:@"/me/permissions"
     completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error){
                                  // These are the current permissions the user has:
                                  NSDictionary *currentPermissions= [(NSArray *)[result data] objectAtIndex:0];
                                  
                                  // We will store here the missing permissions that we will have to request
                                  NSMutableArray *requestPermissions = [[NSMutableArray alloc] initWithArray:@[]];
                                  
                                  // Check if all the permissions we need are present in the user's current permissions
                                  // If they are not present add them to the permissions to be requested
                                  for (NSString *permission in permissionsNeeded){
                                      if (![currentPermissions objectForKey:permission]){
                                          [requestPermissions addObject:permission];
                                      }
                                  }
                                  
                                  // If we have permissions to request
                                  if ([requestPermissions count] > 0){
                                      // Ask for the missing permissions
                                      [FBSession.activeSession
                                       requestNewReadPermissions:requestPermissions
                                       completionHandler:^(FBSession *session, NSError *error) {
                                           if (!error) {
                                               // Permission granted
                                               NSLog(@"new permissions %@", [FBSession.activeSession permissions]);
                                               // We can request the user information
                                               [self makeRequestForUserData];
                                           } else {
                                               // An error occurred, we need to handle the error
                                        }
                                       }];
                                  } else {
                                      // Permissions are present
                                      // We can request the user information
                                      [self makeRequestForUserData];
                                  }
                                  
                              } else {
                                  // An error occurred, we need to handle the error
                              }
                          }];}
*/
}

@end
